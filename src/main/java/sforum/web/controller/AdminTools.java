package sforum.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import sforum.beans.SessionData;
import sforum.security.PermissionConstants;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AdminTools {

	@Autowired
	SessionData sessionData;

	@RequestMapping(value = "/showDeletedThreads")
	@Secured(PermissionConstants.THREAD_SEE_DELETED)
	public View showDeletedThreads(final HttpServletRequest request) {

		sessionData.setShowDeletedThreads(!sessionData.isShowDeletedThreads());

		return new RedirectView(request.getHeader("Referer"), false);
	}

	@RequestMapping(value = "/showDeletedPosts")
	@Secured({PermissionConstants.POST_SEE_DELETED_ANY,
		  PermissionConstants.POST_SEE_DELETED_OWN})
	public View showDeletedPosts(final HttpServletRequest request) {

		SecurityContextHolder.getContext().getAuthentication().getAuthorities().forEach(a -> {
			switch (a.getAuthority()) {
				case PermissionConstants.POST_SEE_DELETED_ANY: {
					sessionData.setShowAllDeletedPosts(!sessionData.isShowAllDeletedPosts());
					break;
				}
				case PermissionConstants.POST_SEE_DELETED_OWN: {
					sessionData.setShowOwnDeletedPosts(!sessionData.isShowOwnDeletedPosts());
					break;
				}
			}
		});

		return new RedirectView(request.getHeader("Referer"), false);
	}
}
