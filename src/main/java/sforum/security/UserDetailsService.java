package sforum.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Permission;
import sforum.model.Role;
import sforum.model.User;
import sforum.repository.UserRepository;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	@Override
	@Transactional
	public org.springframework.security.core.userdetails.UserDetails loadUserByUsername(final String username) throws UsernameNotFoundException {

		final User user = userRepository.findByUsername(username);

		if (user == null) {
			throw new UsernameNotFoundException("");
		}

		final Role role = user.getRole();
		final Set<Permission> permissions = role.getPermissions();

		final List<SimpleGrantedAuthority> authorities = permissions.stream()
			.map(p -> new SimpleGrantedAuthority(p.getCode()))
			.collect(Collectors.toList());

		return new UserDetails(user.getId(), username, user.getPassword(), authorities);
	}
}
