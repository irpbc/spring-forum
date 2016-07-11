package sforum.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import sforum.model.Post;
import sforum.model.Topic;
import sforum.model.User;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {

	/**
	 * Get all posts, including all deleted.
	 *
	 * @param topic
	 * @param pageable
	 * @return
	 */
	Page<Post> findByTopic(Topic topic, Pageable pageable);

	/**
	 * Get only non deleted posts.
	 *
	 * @param topic
	 * @param pageable
	 * @return
	 */
	Page<Post> findByTopicAndDeletedFalse(Topic topic, Pageable pageable);

	/**
	 * Get posts including deleted posts by current user.
	 *
	 * @param topic
	 * @param currentUser
	 * @param pageable
	 * @return
	 */
	@Query(value = "select p from Post p where p.topic = ?1 and (p.deleted = false or p.user = ?2)")
	Page<Post> findVisibleForUser(Topic topic, User currentUser, Pageable pageable);

	@Query(value = "select p from Post p join fetch p.topic where p.id = ?1")
	Post findByIdWithThread(long id);

	@Query(value = "select distinct p.user.id from Post p where p.topic = ?1 and p.deleted = false")
	List<Long> getUserIdsForTopicAndNotDeleted(Topic topic);
}
