package sforum.service;


import org.springframework.stereotype.Service;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.model.User;
import sforum.repository.UserRepository;
import sforum.web.dto.UserDTO;
import sforum.web.dto.mapper.UserMapper;

import javax.inject.Inject;
import java.util.List;

@Service
public class UserService {

	@Inject
	private Application application;

	@Inject
	private SessionData sessionData;

	@Inject
	private UserRepository userRepository;

	@Inject
	private UserMapper userMapper;

	@Inject
	private ConfigurationService configurationService;

	public User getCurrentUser() {
		return sessionData.getCurrentUser();
	}

	public User getUser(final long userId) {
		return userRepository.findOne(userId);
	}

	public List<UserDTO> getAllUsers() {
		final List<User> users = userRepository.findAll();

		return userMapper.usersToUserDTOs(users);
	}

	public boolean isLoggedIn(final User user) {
		return application.isUserLoggedIn(user.getId());
	}

	public User getUserByUserName(final String username) {
		return userRepository.findByUsername(username);
	}
}
