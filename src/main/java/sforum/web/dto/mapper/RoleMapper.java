package sforum.web.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import sforum.model.Permission;
import sforum.model.Role;
import sforum.web.dto.PermissionDTO;
import sforum.web.dto.RoleDTO;

/**
 * Created by @ivan.
 */
@Mapper(componentModel = "spring")
public abstract class RoleMapper {

	@Mapping(target = "permissions", ignore = true)
	public abstract RoleDTO roleToRoleDTO(Role role);

	@Mapping(target = "active", ignore = true)
	public abstract PermissionDTO permissionToPermissionDTO(Permission permission);
}
