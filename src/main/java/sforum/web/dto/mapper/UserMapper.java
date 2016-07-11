package sforum.web.dto.mapper;

import org.mapstruct.InheritConfiguration;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import sforum.model.User;
import sforum.service.UserService;
import sforum.web.dto.UserBasicDTO;
import sforum.web.dto.UserDTO;

import javax.inject.Inject;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * Created by @ivan.
 */
@Mapper(componentModel = "spring")
public abstract class UserMapper {

	@Inject
	private UserService userService;

	@InheritConfiguration(name = "userToUserBasicDTO")
	@Mapping(target = "age", expression = "java(userAge(user))")
	public abstract UserDTO userToUserDTO(User user);

	public abstract List<UserDTO> usersToUserDTOs(List<User> users);

	@Mapping(target = "loggedIn", expression = "java(isLoggedIn(user))")
	public abstract UserBasicDTO userToUserBasicDTO(User user);

	protected boolean isLoggedIn(final User user) {
		return userService.isLoggedIn(user);
	}

	protected int userAge(final User user) {
		final LocalDate dateOfBirth = user.getDateOfBirth();
		if (dateOfBirth != null) {
			final LocalDate now = LocalDate.now();
			return (int) dateOfBirth.until(now, ChronoUnit.YEARS);
		}
		return 0;
	}
}
