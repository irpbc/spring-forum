package sforum.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import sforum.model.Permission;
import sforum.model.User;

import java.util.List;

/**
 * Created by @ivan.
 */
@Repository
public interface PermissionRepository extends JpaRepository<Permission, Long> {

	Permission findOneByCode(String code);

	@Query(value = "select case when count(p) > 0 then true else false end \n" +
		  "from User u join u.role.permissions p where u = ?1 and p.code = ?2")
	boolean userHasPermission(User user, String permCode);

	@Query(value = "select case when count(p) > 0 then true else false end \n" +
		  "from User u join u.role.permissions p where u = ?1 and p.code IN ?2")
	boolean userHasAnyPermission(User currentUser, List<String> codes);
}
