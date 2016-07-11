package sforum.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Topic;
import sforum.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

	User findByUsername(String username);
	User findByUsernameAndPassword(String username, String password);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update User u set u.postCount = u.postCount + 1 where u = ?1")
	void incrementPostCount(User user);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update User u set u.postCount = u.postCount - 1 where u = ?1")
	void decrementPostCount(User user);

	@Modifying
	@Query(value = "update User u set u.postCount = u.postCount - (select count(p.id) from Post p where p.topic = ?1 and p.user = u and p.deleted = false)")
	void updateTopicDeleted(Topic topic);

	@Modifying
	@Query(value = "update User u set u.postCount = u.postCount + (select count(p.id) from Post p where p.topic = ?1 and p.user = u and p.deleted = false)")
	void updateTopicRevived(Topic topic);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update User cu set cu.postCount = (" +
		"select count(p) from Post p join p.topic t " +
		"where p.user.id = cu.id and p.deleted = false and t.deleted = false" +
		")"
	)
	void recountPosts();

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update User cu set cu.postCount = (" +
		"select count(p) from Post p join p.topic t " +
		"where p.user = cu and p.deleted = false and t.deleted = false" +
		")" +
		"where cu = ?1"
	)
	void recountPosts(User user);
}
