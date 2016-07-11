package sforum.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Forum;
import sforum.repository.ForumRepository;
import sforum.web.dto.ForumDTO;
import sforum.web.dto.mapper.ForumMapper;

import javax.inject.Inject;
import java.util.List;

@Service
@Transactional
public class ForumService {

	@Inject
	private ForumRepository forumRepository;

	@Autowired
	private ForumMapper forumMapper;

	@Transactional(readOnly = true)
	public List<ForumDTO> getTopLevelForums() {

		final List<Forum> topLevelForums = forumRepository.findTopLevelForums();

		return forumMapper.forumsToForumDTOs(topLevelForums);
	}

	public void threadCreated(final long forumId) {

		Forum forum = forumRepository.findOne(forumId);
		while (forum.getId() != 0) {
			forum.setThreadCount(forum.getThreadCount() + 1);
			forum.setTotalThreadCount(forum.getTotalThreadCount() + 1);
			forumRepository.save(forum);
			forum = forum.getParent();
		}
	}

	public void threadDeleted(Forum forum) {
		while (forum.getId() != 0) {
			forum.setThreadCount(forum.getThreadCount() - 1);
			forumRepository.save(forum);
			forum = forum.getParent();
		}
	}

	public void threadRevived(Forum forum) {
		while (forum.getId() != 0) {
			forum.setThreadCount(forum.getThreadCount() + 1);
			forumRepository.save(forum);
			forum = forum.getParent();
		}
	}

	public void incrementPostCount(final long forumId) {

		Forum forum = forumRepository.findOne(forumId);
		while (forum.getId() != 0) {
			forum.setPostCount(forum.getPostCount() + 1);
			forumRepository.save(forum);
			forum = forum.getParent();
		}
	}

	public void decrementPostCount(final long forumId) {

		Forum forum = forumRepository.findOne(forumId);
		while (forum.getId() != 0) {
			forum.setPostCount(forum.getPostCount() - 1);
			forumRepository.save(forum);
			forum = forum.getParent();
		}
	}

	@Transactional(readOnly = true)
	public Forum findOne(final Long id) {
		return forumRepository.findOne(id);
	}
}
