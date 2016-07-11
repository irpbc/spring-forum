package sforum.forms;

import org.hibernate.validator.constraints.Length;

/**
 * Created by @ivan.
 */
public class RoleForm {

	@Length(min = 4, max = 20)
	private String code;

	@Length(min = 4, max = 30)
	private String name;

	public String getCode() {
		return code;
	}

	public void setCode(final String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}
}
