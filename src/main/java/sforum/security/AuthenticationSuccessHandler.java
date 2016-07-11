package sforum.security;

import org.springframework.security.core.Authentication;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.model.User;
import sforum.repository.UserRepository;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by @ivan.
 */
public class AuthenticationSuccessHandler implements org.springframework.security.web.authentication.AuthenticationSuccessHandler {

	@Inject
	private Application application;

	@Inject
	private SessionData sessionData;

	@Inject
	private UserRepository userRepository;

	@Override
	public void onAuthenticationSuccess(final HttpServletRequest request, final HttpServletResponse response, final Authentication authentication) throws IOException, ServletException {

		final UserDetails principal = (UserDetails) authentication.getPrincipal();

		final Long userId = principal.getUserId();
		final User user = userRepository.findOne(userId);
		sessionData.setCurrentUser(user);
		application.userLoggedIn(userId);

//		response.sendRedirect(request.getHeader("Referer"));
		request.getRequestDispatcher("/loginSuccess?referer=" + request.getHeader("Referer")).forward(request, response);
	}
}
