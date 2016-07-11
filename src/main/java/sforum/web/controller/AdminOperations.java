package sforum.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.forms.RoleForm;
import sforum.model.Forum;
import sforum.model.Role;
import sforum.model.User;
import sforum.repository.*;
import sforum.security.PermissionConstants;
import sforum.service.ConfigurationService;
import sforum.service.RoleService;
import sforum.service.UserService;
import sforum.web.dto.RoleDTO;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.validation.Valid;
import java.util.List;
import java.util.Locale;

@Controller
public class AdminOperations {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private TopicRepository topicRepository;

	@Autowired
	private ForumRepository forumRepository;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private PermissionRepository permissionRepository;

	@Autowired
	private SessionData sessionData;

	@Autowired
	private Application app;

	@Resource(name = "messageSource")
	private MessageSource msg;

	@Autowired
	private UserService userService;

	@Autowired
	private ConfigurationService configurationService;

	@Inject
	private RoleService roleService;

	private static String jsonOK() {
		return "{\"status\": \"OK\"}";
	}

	/*
	 * AJAX admin operations
	 */

	@RequestMapping(value = "/adminPanel", method = RequestMethod.GET)
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	public String adminPanel(@ModelAttribute(name = "roleForm") final RoleForm roleForm, final Model model) {

		fillAdminPanelModel(model);
		return "adminPanel";
	}

	private void fillAdminPanelModel(final Model model) {
		final List<Role> all = roleRepository.findAll();

		model.addAttribute("roles", all);
	}

	@RequestMapping(value = "/admin/recountPostsForUsers", method = RequestMethod.GET)
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	@ResponseBody
	public String recountPostsForUsers(@RequestParam(required = false) final Long userId, final Locale loc) {

		if (userId == null) {
			userRepository.recountPosts();
		} else {
			final User user = userRepository.findOne(userId);
			if (user != null) {
				userRepository.recountPosts(user);
			} else {
				final String code = "error.userNotFound";
				return jsonError(code, loc);
			}
		}

		return jsonOK();
	}

	@RequestMapping(value = "/admin/recountPostsForThreads", method = RequestMethod.GET)
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	@ResponseBody
	public String recountPostsForThreads(@RequestParam(required = false) final Long threadId, final Locale loc) {

		if (threadId == null) {
			topicRepository.recountPosts();
		} else if (topicRepository.exists(threadId)) {
			topicRepository.recountPosts(threadId);
		} else {
			return jsonError("error.threadNotFound", loc);
		}

		return jsonOK();
	}

	@RequestMapping(value = "/admin/recountPostsForForums", method = RequestMethod.GET)
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	@ResponseBody
	public String recountPostsForForums(@RequestParam(required = false) final Long forumId,
	                                    @RequestParam(required = false, defaultValue = "false") final boolean deep,
	                                    final Locale loc) {

		if (forumId == null) {
			forumRepository.recountPosts();
		} else {
			final Forum forum = forumRepository.findOne(forumId);
			if (forum != null) {
				if (deep) {
					topicRepository.recountPostsInForum(forum);
				}
				forumRepository.recountPosts(forum);
			} else {
				return jsonError("error.forumNotFound", loc);
			}
		}

		return jsonOK();
	}

	@RequestMapping(value = "/admin/recountThreads")
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	@ResponseBody
	public String recountThreads(@RequestParam(required = false) final Long forumId, final Locale loc) {

		if (forumId == null) {
			forumRepository.recountThreads();
		} else {
			final Forum forum = forumRepository.findOne(forumId);
			if (forum != null) {
				forumRepository.recountThreads(forum);
			} else {
				return jsonError("error.forumNotFound", loc);
			}
		}

		return jsonOK();
	}

	@RequestMapping(value = "/admin/logoutUser")
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	@ResponseBody
	public String logoutUser(@RequestParam(required = false) final Long userId, final Locale loc) {

		if (userId == null) {
			app.logoutAllUsers();
		} else if (userRepository.exists(userId)) {
			app.logoutUser(userId);
		} else {
			return jsonError("error.userNotFound", loc);
		}

		return jsonOK();
	}

	@RequestMapping(value = "/admin/addRole")
	@Secured(PermissionConstants.ADMIN_OPERATIONS)
	public String addRole(final Model model, @Valid final RoleForm roleForm, final BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			fillAdminPanelModel(model);
			return "adminPanel";
		}

		Role role = roleRepository.findOneByCode(roleForm.getCode());
		if (role != null) {
			bindingResult.rejectValue("code", "admin.role.exists");
			fillAdminPanelModel(model);
			return "adminPanel";
		}

		role = new Role();
		role.setCode(roleForm.getCode());
		role.setName(roleForm.getName());
		roleRepository.save(role);
		return "redirect:/adminPanel";
	}

	@RequestMapping(value = "/admin/setUserRole")
	@Secured(PermissionConstants.USER_CHANGE_ROLE)
	@ResponseBody
	public String setUserRole(@RequestParam final Long userId, @RequestParam final Long roleId) {

		final User user = userService.getUser(userId);
		final Role role = roleRepository.findOne(roleId);

		user.setRole(role);

		userRepository.save(user);

		app.logoutUser(userId);

		return jsonOK();
	}

	@RequestMapping(value = "/admin/addPermission")
	@Secured(PermissionConstants.ROLE_CHANGE_PERMISSIONS)
	@ResponseBody
	public String addPermission(@RequestParam final Long roleId, @RequestParam final Long permissionId, final Locale loc) {

		if (roleService.assignPermission(roleId, permissionId)) {
			return jsonOK();
		}
		return jsonError("error.roleOrPermissionNotFound", loc);
	}

	@RequestMapping(value = "/admin/removePermission")
	@Secured(PermissionConstants.ROLE_CHANGE_PERMISSIONS)
	@ResponseBody
	public String removePermission(@RequestParam final Long roleId, @RequestParam final Long permissionId, final Locale loc) {

		if (roleService.removePermission(roleId, permissionId)) {
			return jsonOK();
		}
		return jsonError("error.roleOrPermissionNotFound", loc);
	}

	private String jsonError(final String code, final Locale loc) {
		return "{\"status\":\"ERROR\",\"message\":\"" + msg.getMessage(code, null, loc) + "\"}";
	}

	/*private String jsonError(Locale loc, String code) {
		return "{\"status\":\"ERROR\", \"message\":\""+msg.getMessage(code,null,loc)+"\"}";
	}*/

	@RequestMapping(value = "/admin/role")
	@Secured(PermissionConstants.ROLE_CHANGE_PERMISSIONS)
	public String role(final Model model, @RequestParam final Long roleId) {

		final RoleDTO role = roleService.getRole(roleId);

		model.addAttribute("role", role);

		return "role";
	}
}
