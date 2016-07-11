package sforum.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sforum.model.Topic;
import sforum.repository.ForumRepository;
import sforum.repository.TopicRepository;
import sforum.repository.UserRepository;
import sforum.web.dto.PostDTO;
import sforum.web.dto.TopicDTO;
import sforum.web.dto.mapper.TopicMapper;

import javax.inject.Inject;

/**
 * Created by @ivan.
 */
@Service
public class TopicService {

	@Inject
	private TopicRepository topicRepository;

	@Inject
	private TopicMapper topicMapper;

	@Inject
	private PostService postService;

	@Inject
	private UserRepository userRepository;

	@Inject
	private ForumRepository forumRepository;

	@Inject
	private ForumService forumService;

	@Inject
	private ConfigurationService configurationService;



	@Transactional(readOnly = true)
	public TopicDTO getTopic(final Long topicId, final String name, final int pageNumber) {

		final Topic topic = topicRepository.findOne(topicId);
		if (topic == null || !topic.getName().equals(name)) {
			return null;
		}

		final int pageSize = configurationService.getPostsPageSize();

		final PageRequest pageable = new PageRequest(pageNumber - 1, pageSize);

		final Page<PostDTO> postDTOPage = postService.getPostsForTopic(topic, pageable);

		final TopicDTO topicDTO = topicMapper.topicToTopicDTO(topic);
		topicDTO.setPostsPage(postDTOPage);

		return topicDTO;
	}

	@Transactional
	public void deleteTopic(final long id) {
		final Topic topic = topicRepository.findOne(id);
		topic.setDeleted(true);

		userRepository.updateTopicDeleted(topic);

		topicRepository.save(topic);

		forumService.threadDeleted(topic.getForum());
	}

	@Transactional
	public void reviveTopic(final long id) {
		final Topic topic = topicRepository.findOne(id);
		topic.setDeleted(false);

		userRepository.updateTopicRevived(topic);

		topicRepository.save(topic);

		forumService.threadRevived(topic.getForum());
	}
}
