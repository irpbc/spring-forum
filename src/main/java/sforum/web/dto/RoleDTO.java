package sforum.web.dto;

import java.util.List;

/**
 * Created by @ivan.
 */
public class RoleDTO {

	private Long id;
	private String code;
	private String name;

	private List<PermissionDTO> permissions;

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

	public List<PermissionDTO> getPermissions() {
		return permissions;
	}

	public void setPermissions(final List<PermissionDTO> permissions) {
		this.permissions = permissions;
	}
}
