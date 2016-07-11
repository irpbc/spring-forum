package sforum.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Permission;
import sforum.model.Role;
import sforum.repository.PermissionRepository;
import sforum.repository.RoleRepository;
import sforum.web.dto.PermissionDTO;
import sforum.web.dto.RoleDTO;
import sforum.web.dto.mapper.RoleMapper;

import javax.inject.Inject;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by @ivan.
 */
@Service
@Transactional
public class RoleService {

	@Inject
	private RoleRepository roleRepository;

	@Inject
	private PermissionRepository permissionRepository;

	@Inject
	private RoleMapper roleMapper;

	@Transactional(readOnly = true)
	public RoleDTO getRole(final Long roleId) {
		final Role role = roleRepository.findOne(roleId);
		final List<Permission> perms = permissionRepository.findAll();

		final RoleDTO roleDTO = roleMapper.roleToRoleDTO(role);
		roleDTO.setPermissions(perms.stream().map(p -> {
			PermissionDTO dto = roleMapper.permissionToPermissionDTO(p);
			dto.setActive(role.getPermissions().contains(p));
			return dto;
		}).collect(Collectors.toList()));
		return roleDTO;
	}

	public boolean assignPermission(final Long roleId, final Long permissionId) {
		final Role role = roleRepository.findOne(roleId);
		final Permission permission = permissionRepository.findOne(permissionId);

		if (role == null || permission == null) {
			return false;
		}

		final Set<Permission> currentPermissions = role.getPermissions();

		if (!currentPermissions.contains(permission)) {
			currentPermissions.add(permission);
			roleRepository.save(role);
		}
		return true;
	}

	public boolean removePermission(final Long roleId, final Long permissionId) {
		final Role role = roleRepository.findOne(roleId);
		final Permission permission = permissionRepository.findOne(permissionId);

		if (role == null || permission == null) {
			return false;
		}

		final Set<Permission> permissions = role.getPermissions();
		if (permissions.contains(permission)) {
			permissions.remove(permission);
			roleRepository.save(role);
		}
		return true;
	}
}
