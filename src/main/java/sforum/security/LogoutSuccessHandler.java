package sforum.security;

import org.springframework.security.core.Authentication;
import sforum.beans.Application;
import sforum.beans.SessionData;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by @ivan.
 */
public class LogoutSuccessHandler implements org.springframework.security.web.authentication.logout.LogoutSuccessHandler {

	@Inject
	private Application application;

	@Inject
	private SessionData sessionData;

	@Override
	public void onLogoutSuccess(final HttpServletRequest request, final HttpServletResponse response, final Authentication authentication) throws IOException, ServletException {

		sessionData.reset();
		final Long userId = ((UserDetails) authentication.getPrincipal()).getUserId();
		application.userLoggedOut(userId);

		response.sendRedirect(request.getHeader("Referer"));
	}
}
