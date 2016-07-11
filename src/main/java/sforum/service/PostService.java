package sforum.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sforum.beans.SessionData;
import sforum.model.Post;
import sforum.model.Topic;
import sforum.model.User;
import sforum.repository.PostRepository;
import sforum.repository.TopicRepository;
import sforum.repository.UserRepository;
import sforum.web.controller.httpcodes.Errors;
import sforum.web.dto.PostDTO;
import sforum.web.dto.mapper.PostMapper;

import javax.inject.Inject;

@Service
public class PostService {

	@Inject
	private PostRepository postRepository;

	@Inject
	private SessionData sessionData;

	@Inject
	private PostMapper postMapper;

	@Inject
	private UserRepository userRepository;

	@Inject
	private TopicRepository topicRepository;

	@Inject
	private UserService userService;

	Page<PostDTO> getPostsForTopic(final Topic topic, final Pageable pageable) {

		final Page<Post> postPage;

		if (sessionData.isShowAllDeletedPosts()) {
			postPage = postRepository.findByTopic(topic, pageable);
		} else if (sessionData.isShowOwnDeletedPosts()) {
			postPage = postRepository.findVisibleForUser(topic, sessionData.getCurrentUser(), pageable);
		} else {
			postPage = postRepository.findByTopicAndDeletedFalse(topic, pageable);
		}

		final Page<PostDTO> postDTOPage = postPage.map(postMapper::postToPostDTO);

		final User currentUser = sessionData.getCurrentUser();
		if (currentUser != null) {
			if (sessionData.isEditAllPosts()) {
				postDTOPage.getContent().forEach(p -> p.setEditable(true));
			} else if (sessionData.isEditOwnPosts()) {
				postDTOPage.getContent().forEach(p -> {
					final boolean postByCurrentUser = p.getUser().getId().equals(currentUser.getId());
					p.setEditable(postByCurrentUser);
				});
			}
			if (sessionData.isDeleteAllPosts()) {
				postDTOPage.getContent().forEach(p -> p.setDeletable(true));
			} else if (sessionData.isDeleteOwnPosts()) {
				postDTOPage.getContent().forEach(p -> {
					final boolean postByCurrentUser = p.getUser().getId().equals(currentUser.getId());
					p.setDeletable(postByCurrentUser);
				});
			}
		}

		return postDTOPage;
	}

	@Transactional
	public void deletePost(final long id) {
		Post post = postRepository.findOne(id);

		if (!canDeletePost(post))
			throw new Errors.Forbidden();

		final Topic topic = post.getTopic();
		final Long topicId = topic.getId();

		if (!post.getDeleted()) {
			post.setDeleted(Boolean.TRUE);
			post = postRepository.save(post);
			userRepository.decrementPostCount(post.getUser());
			topicRepository.postDeleted(topicId);
		}
	}

	@Transactional
	public void revivePost(final long id) {
		final Post post = postRepository.findOne(id);

		if (!canRevivePost(post))
			throw new Errors.Forbidden();

		final Topic topic = post.getTopic();

		if (post.getDeleted()) {
			post.setDeleted(false);
			postRepository.save(post);
			userRepository.incrementPostCount(post.getUser());
			topicRepository.postRevived(topic.getId());
		}
	}

	public boolean canEditPost(final Post post) {
		final User currentUser = sessionData.getCurrentUser();
		if (currentUser != null) {
			if (sessionData.isEditAllPosts()) {
				return true;
			} else if (sessionData.isEditOwnPosts()) {
				if (post.getUser().getId().equals(currentUser.getId())) {
					return true;
				}
			}
		}
		return false;
	}

	public boolean canDeletePost(final Post post) {
		final User currentUser = sessionData.getCurrentUser();
		if (currentUser != null) {
			if (sessionData.isDeleteAllPosts()) {
				return true;
			} else if (sessionData.isDeleteOwnPosts()) {
				if (post.getUser().getId().equals(currentUser.getId())) {
					return true;
				}
			}
		}
		return false;
	}

	public boolean canRevivePost(final Post post) {
		final User currentUser = sessionData.getCurrentUser();
		if (currentUser != null) {
			if (sessionData.isReviveAllPosts()) {
				return true;
			} else if (sessionData.isReviveOwnPosts()) {
				if (post.getUser().getId().equals(currentUser.getId())) {
					return true;
				}
			}
		}
		return true;
	}
}
