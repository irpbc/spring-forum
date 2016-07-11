package sforum.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Forum;

import java.util.List;

@Repository
public interface ForumRepository extends JpaRepository<Forum, Long> {

	@Query(value = "select f from Forum f " +
					"where f.id <> 0 and f.parent.id = 0 " +
					"order by f.position asc")
	List<Forum> findTopLevelForums();

	List<Forum> findByParentIdOrderByPositionAsc(long parentId);

	Forum findByParentIdAndPosition(long parentId, int position);

	@Query(value = "select max(f.position) from Forum as f where f.parent.id = ?1")
	Integer findMaxChildPositionForParent(long parentId);

	default void incrementPostCount(final long forumId) {

		Forum forum = findOne(forumId);
		while (forum.getId() != 0) {
			forum.setPostCount(forum.getPostCount() + 1);
			save(forum);
			forum = forum.getParent();
		}
	}

	default void decrementPostCount(final long forumId) {

		Forum forum = findOne(forumId);
		while (forum.getId() != 0) {
			forum.setPostCount(forum.getPostCount() - 1);
			save(forum);
			forum = forum.getParent();
		}
	}

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Forum f set " +
		"f.postCount = (select sum(t.postCount) from Topic t where t.forum = f), " +
		"f.totalPostCount = (select sum(t.totalPostCount) from Topic t where t.forum = f) " +
		"where f = ?1")
	void recountPosts(Forum forum);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Forum f set " +
		"f.postCount = (select sum(t.postCount) from Topic t where t.forum.id = f.id), " +
		"f.totalPostCount = (select sum(t.totalPostCount) from Topic t where t.forum.id = f.id)")
	void recountPosts();

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Forum f set " +
		"f.threadCount = (select count(t) from Topic t where t.forum.id = f.id and t.deleted = false), " +
		"f.totalThreadCount = (select count(t) from Topic t where t.forum.id = f.id) " +
		"where f = ?1")
	void recountThreads(Forum forum);

	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "update Forum f set " +
		"f.threadCount = (select count(t) from Topic t where t.forum.id = f.id and t.deleted = false), " +
		"f.totalThreadCount = (select count(t) from Topic t where t.forum.id = f.id)")
	void recountThreads();
}
