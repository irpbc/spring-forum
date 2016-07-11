package sforum.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sforum.model.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

	Role findOneByCode(String code);
}
