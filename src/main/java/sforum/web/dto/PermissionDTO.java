package sforum.web.dto;

/**
 * Created by @ivan.
 */
public class PermissionDTO {

	private Long id;
	private String code;
	private String name;

	// used in context of a role
	private Boolean active;

	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

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

	public Boolean getActive() {
		return active;
	}

	public void setActive(final Boolean active) {
		this.active = active;
	}
}
