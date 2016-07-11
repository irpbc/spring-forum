package sforum.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import sforum.beans.SessionData;
import sforum.forms.ForumForm;
import sforum.model.Forum;
import sforum.repository.ForumRepository;
import sforum.security.PermissionConstants;
import sforum.utils.Utils;

import javax.validation.Valid;
import java.util.List;

@Controller
public class ForumOperations {

	@Autowired
	SessionData session;

	@Autowired
	ForumRepository forumRepository;

	@RequestMapping(value = "/forumRaise", method = RequestMethod.GET)
	@Secured(PermissionConstants.FORUM_EDIT)
	@Transactional
	public View forumRaise(@RequestParam final long id) {

		final Forum forum = forumRepository.findOne(id);
		Utils.checkNull(forum);

		final int order = forum.getPosition();
		final Forum lower = forumRepository.findByParentIdAndPosition(forum.getParent().getId(), order - 1);
		if (lower != null) {
			forum.setPosition(order - 1);
			lower.setPosition(order);

			forumRepository.save(forum);
			forumRepository.save(lower);
		}

		return new RedirectView("/", true);
	}

	@RequestMapping(value = "/forumLower", method = RequestMethod.GET)
	@Secured(PermissionConstants.FORUM_EDIT)
	public View forumLower(@RequestParam final long id) {

		final Forum forum = forumRepository.findOne(id);
		Utils.checkNull(forum);

		final int order = forum.getPosition();
		final Forum higher = forumRepository.findByParentIdAndPosition(forum.getParent().getId(), order + 1);
		if (higher != null) {
			forum.setPosition(order + 1);
			higher.setPosition(order);

			forumRepository.save(forum);
			forumRepository.save(higher);
		}

		return new RedirectView("/", true);
	}

	@RequestMapping(value = "/forumDelete", method = RequestMethod.GET)
	@Secured(PermissionConstants.FORUM_DELETE)
	@Transactional
	public View forumDelete(@RequestParam final long id) {

		final Forum forum = forumRepository.findOne(id);
		Utils.checkNull(forum);
		final long parentId = forum.getParent().getId();
		forumRepository.delete(forum);
		final List<Forum> children = forumRepository.findByParentIdOrderByPositionAsc(parentId);
		if (children != null) {
			int count = 0;
			for (final Forum f : children) {
				f.setPosition(count);
				count++;
			}

			forumRepository.save(children);
		}

		return new RedirectView("/", true);
	}

	@RequestMapping(value = "/forumCreate", method = RequestMethod.GET)
	@Secured(PermissionConstants.FORUM_CREATE)
	public String forumCreate(final Model model, @RequestParam(required = false) final Long parentId) {

		model.addAttribute("forumForm", new ForumForm(parentId));

		return "newForum";
	}

	@RequestMapping(value = "/forumSubmit", method = RequestMethod.POST)
	@Secured(PermissionConstants.FORUM_CREATE)
	@Transactional
	public String forumSubmit(@Valid final ForumForm forumForm, final BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			return "newForum";
		}

		final Forum parent = forumRepository.findOne(forumForm.getParentId());
		Utils.checkNull(parent);
		final Integer lowest = forumRepository.findMaxChildPositionForParent(forumForm.getParentId());

		final Forum newForum = new Forum();
		newForum.setPosition(lowest == null ? 0 : lowest + 1);
		newForum.setName(forumForm.getForumName());
		newForum.setParent(parent);

		forumRepository.save(newForum);

		return "redirect:/";
	}
}
