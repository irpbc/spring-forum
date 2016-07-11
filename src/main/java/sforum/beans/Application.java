package sforum.beans;


import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import sforum.security.UserDetails;

import javax.inject.Inject;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Application {

	int unregisteredUsers;
	private Set<Long> loggedInUserIds = new HashSet<>();
	@Inject
	private SessionRegistry sessionRegistry;

	public Collection<UserDetails> getRegisteredUsers() {
		return ((List) sessionRegistry.getAllPrincipals());
	}

	public int getUnregisteredUsers() {
		return unregisteredUsers;
	}

	public synchronized void userLoggedIn(final long id) {
		loggedInUserIds.add(id);
		unregisteredUsers--;
	}

	public void userLoggedOut(final Long userId) {
		loggedInUserIds.remove(userId);
	}

	public boolean isUserLoggedIn(final long id) {
		return loggedInUserIds.contains(id);
	}

	public synchronized void logoutAllUsers() {
		for (final Object principal : sessionRegistry.getAllPrincipals()) {
			if (principal instanceof UserDetails) {
				final UserDetails userDetails = (UserDetails) principal;
				sessionRegistry.getAllSessions(principal, false).forEach(SessionInformation::expireNow);
			}
		}
		loggedInUserIds.clear();
	}

	public synchronized void logoutUser(final long id) {
		for (final Object principal : sessionRegistry.getAllPrincipals()) {
			if (principal instanceof UserDetails) {
				final UserDetails userDetails = (UserDetails) principal;
				if (userDetails.getUserId().equals(id)) {
					sessionRegistry.getAllSessions(principal, false).forEach(SessionInformation::expireNow);
					return;
				}
			}
		}
		loggedInUserIds.remove(id);
	}

}
