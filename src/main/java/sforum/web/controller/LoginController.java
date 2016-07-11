package sforum.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.forms.LoginForm;
import sforum.forms.SignupForm;
import sforum.model.User;
import sforum.repository.UserRepository;
import sforum.service.ConfigurationService;

import javax.validation.Valid;
import java.io.Serializable;
import java.time.LocalDateTime;

@Controller
public class LoginController implements Serializable {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private SessionData sessionData;

	@Autowired
	private ConfigurationService configurationService;

	@Autowired
	private Application application;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserDetailsService userDetailsService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage(final Model model) {

		model.addAttribute("loginForm", new LoginForm());
		return "loginPage";
	}

	@RequestMapping(value = "/loginSuccess")
	public String loginSuccess(final Model model, @RequestParam(name = "referer") final String referer) {

		model.addAttribute("referer", referer);
		return "loginSuccess";
	}

	@RequestMapping(value = "/loginFailed")
	public String loginFailed(final Model model, @Valid final LoginForm loginForm, final BindingResult bindingResult) {

		if (!bindingResult.hasErrors()) {
			bindingResult.reject("login.failed");
		}
		model.addAttribute("loginForm", loginForm);
		return "loginPage";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(final Model model) {

		model.addAttribute("signupForm", new SignupForm());
		return "signup";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String submitSignup(@Valid final SignupForm signupForm, final BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			return "signup";
		}

		final User user = userRepository.findByUsername(signupForm.getUsername());
		if (user != null) {
			bindingResult.rejectValue("username", "signup.user.exists");
			return "signup";
		}

		final User newUser = new User();
		newUser.setUsername(signupForm.getUsername());
		final String encodedPassword = passwordEncoder.encode(signupForm.getPassword());
		newUser.setPassword(encodedPassword);
		newUser.setRole(configurationService.getStartingRole());
		newUser.setJoinDate(LocalDateTime.now());

		final User result = userRepository.save(newUser);

		final UserDetails userDetails = userDetailsService.loadUserByUsername(result.getUsername());

		final UsernamePasswordAuthenticationToken token =
			  new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(), userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(token);

		sessionData.setCurrentUser(result);
		application.userLoggedIn(result.getId());

		return "redirect:/signupSuccess";
	}

	@RequestMapping(value = "/signupSuccess", method = RequestMethod.GET)
	public String signupSuccess() {
		return "signupSuccess";
	}
}
