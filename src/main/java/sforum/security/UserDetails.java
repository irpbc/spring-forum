package sforum.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

public class UserDetails extends User {

	private Long userId;

	public UserDetails(final Long userId, final String username, final String password, final Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);

		this.userId = userId;
	}

	public Long getUserId() {
		return userId;
	}
}
