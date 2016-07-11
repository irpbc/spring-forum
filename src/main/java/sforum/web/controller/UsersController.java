package sforum.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sforum.beans.SessionData;
import sforum.model.User;
import sforum.repository.RoleRepository;
import sforum.service.UserService;
import sforum.web.dto.UserDTO;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;

@Controller
public class UsersController {

	@Autowired
	UserService userService;
	@Autowired
	SessionData sessionData;
	@Inject
	private RoleRepository roleRepository;

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public String users(final Model model) {

		final List<UserDTO> users = userService.getAllUsers();

		model.addAttribute("users", users);

		return "users";
	}

	@RequestMapping(value = "/users/{id}")
	public String user(final Model model, @PathVariable("id") final Long id) {

		final User user = userService.getUser(id);

		model.addAttribute("user", user);
		model.addAttribute("roles", roleRepository.findAll());

		final LocalDate dateOfBirth = user.getDateOfBirth();
		if (dateOfBirth != null) {
			final LocalDate now = LocalDate.now();
			model.addAttribute("userAge", now.getYear() - dateOfBirth.getYear());
		}

		return "user";
	}
}
