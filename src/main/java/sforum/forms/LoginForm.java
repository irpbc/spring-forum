package sforum.forms;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginForm {

	@NotEmpty
	private String username;

	@NotEmpty
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
