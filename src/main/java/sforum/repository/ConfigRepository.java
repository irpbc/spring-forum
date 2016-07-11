package sforum.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import sforum.model.Config;

public interface ConfigRepository extends JpaRepository<Config, String> {

}
