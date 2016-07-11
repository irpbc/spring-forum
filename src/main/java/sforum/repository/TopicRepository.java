package sforum.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Forum;
import sforum.model.Topic;

@Repository
public interface TopicRepository extends JpaRepository<Topic, Long> {

	Page<Topic> findByForumAndPinned(Forum forum, boolean pinned, Pageable pageable);
	Page<Topic> findByForumAndPinnedAndDeleted(Forum forum, boolean pinned, boolean deleted, Pageable pageable);

	int countByForumId(long forumId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set \n" +
		  "t.postCount = (select count(p) from Post p where p.topic = t and p.deleted = false), \n" +
		  "t.totalPostCount = (select count(p) from Post p where p.topic = t)")
	void recountPosts();

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set \n" +
		  "t.postCount = (select count(p) from Post p where p.topic = t and p.deleted = false), \n" +
		  "t.totalPostCount = (select count(p) from Post p where p.topic = t)  where t.id = ?1")
	void recountPosts(long threadId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set \n" +
		  "t.postCount = (select count(p) from Post p where p.topic = t and p.deleted = false), \n" +
		  "t.totalPostCount = (select count(p) from Post p where p.topic = t) where t.forum = ?1")
	void recountPostsInForum(Forum forum);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set t.postCount = t.postCount + 1 where t.id = ?1")
	void incrementPostCount(long threadId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set t.postCount = t.postCount - 1 where t.id = ?1")
	void decrementPostCount(long threadId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set t.postCount = t.postCount + 1, t.totalPostCount = t.totalPostCount + 1 where t.id = ?1")
	void postCreated(long threadId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set t.postCount = t.postCount - 1 where t.id = ?1")
	void postDeleted(long threadId);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Topic t set t.postCount = t.postCount + 1 where t.id = ?1")
	void postRevived(long threadId);
}
