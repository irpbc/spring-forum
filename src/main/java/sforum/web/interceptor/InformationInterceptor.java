package sforum.web.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.security.UserDetails;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.Map;

/**
 * Created by @ivan.
 */
@Component
public class InformationInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private Application application;

	@Autowired
	private SessionData sessionData;

	public InformationInterceptor() {
	}

	public void postHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler, final ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		if (modelAndView != null) {
			final Map<String, Object> model = modelAndView.getModel();

			final Collection<UserDetails> registeredUsers = application.getRegisteredUsers();
			final int unregisteredUsers = application.getUnregisteredUsers();

			model.put("loggedInUsers", registeredUsers);
			model.put("totalUsers", registeredUsers.size() + unregisteredUsers);
			model.put("visitors", unregisteredUsers);

			final SecurityContext context = SecurityContextHolder.getContext();
			final Authentication authentication = context.getAuthentication();
			if (authentication != null) {
				final Object principal = authentication.getPrincipal();
				if (principal instanceof UserDetails) {
					model.put("userIsLoggedIn", Boolean.TRUE);
					model.put("userId", ((UserDetails) principal).getUserId());
					model.put("username", ((UserDetails) principal).getUsername());

					final boolean showDeletedThreads = sessionData.isShowDeletedThreads();
					final boolean showDeletedPosts = sessionData.isShowOwnDeletedPosts() || sessionData.isShowAllDeletedPosts();

					model.put("showDeletedThreads", showDeletedThreads);
					model.put("showDeletedPosts", showDeletedPosts);
					model.put("showAdminTools", sessionData.isShowAdminTools());
					return;
				}
			}
			model.put("userIsLoggedIn", Boolean.FALSE);
		}
	}
}
