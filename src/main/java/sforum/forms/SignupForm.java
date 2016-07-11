package sforum.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class SignupForm {

	@NotNull
	@Pattern(regexp = "^[ \\p{Graph}]{3,25}$")
	private String username;

	@NotNull
	@Pattern(regexp = "^(?=.*[\\p{Alpha}])(?=.*[\\p{Digit}])[\\p{Alnum}\\p{Punct}]{5,64}$")
	private String password;

	public String getUsername() {
		return username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(final String password) {
		this.password = password;
	}
}
