package sforum.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import sforum.beans.SessionData;
import sforum.forms.EditPostForm;
import sforum.forms.PostForm;
import sforum.model.Post;
import sforum.model.Topic;
import sforum.repository.ForumRepository;
import sforum.repository.PostRepository;
import sforum.repository.TopicRepository;
import sforum.repository.UserRepository;
import sforum.security.PermissionConstants;
import sforum.service.PostService;
import sforum.utils.Utils;
import sforum.web.controller.httpcodes.Errors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.LocalDateTime;

@Controller
public class PostOperations {

	@Autowired
	SessionData session;

	@Autowired
	PostService postService;

	@Autowired
	TopicRepository topicRepository;

	@Autowired
	PostRepository postRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	ForumRepository forumRepository;

	@RequestMapping(value = "/postCreate", method = RequestMethod.GET)
	@Secured(PermissionConstants.POST_CREATE)
	public String newPost(final Model model, @RequestParam final long threadId, final HttpServletRequest request) {

		final Topic topic = topicRepository.findOne(threadId);
		Utils.checkNull(topic);

		if (request.isUserInRole("thread_lock") && topic.isLocked())
			throw new Errors.Forbidden();

		model.addAttribute("postForm", new PostForm(threadId));

		return "newPost";
	}

	@RequestMapping(value = "/postSubmit", method = RequestMethod.POST)
	@Secured(PermissionConstants.POST_CREATE)
	@Transactional
	public String submitPost(@Valid final PostForm postForm, final BindingResult bindingResult) {

		final Topic topic = topicRepository.findOne(postForm.getThreadId());
		Utils.checkNull(topic);

		if (!session.isLockThreads() && topic.isLocked()) {
			throw new Errors.Forbidden();
		}

		if (bindingResult.hasErrors()) {
			return "newPost";
		}

		final Post newPost = new Post();
		newPost.setText(postForm.getText());
		newPost.setTopic(topic);
		newPost.setUser(session.getCurrentUser());
		newPost.setTimestamp(LocalDateTime.now());
		newPost.setDeleted(Boolean.FALSE);

		postRepository.save(newPost);
		userRepository.incrementPostCount(session.getCurrentUser());
		topicRepository.postCreated(topic.getId());

		return "redirect:" + Utils.topicURL(topic);
	}

	@RequestMapping(value = "/postEdit", method = RequestMethod.GET)
	@Secured({PermissionConstants.POST_EDIT_ANY, PermissionConstants.POST_EDIT_OWN})
	@Transactional(readOnly = true)
	public String editPost(final Model model, @RequestParam final long id) {

		final Post post = postRepository.findOne(id);
		if (post == null) {
			throw new Errors.NotFound();
		}

		if (!postService.canEditPost(post)) {
			throw new Errors.Forbidden();
		}

		final Topic topic = post.getTopic();

		final EditPostForm editPostForm = new EditPostForm(topic.getId(), id);
		editPostForm.setText(post.getText());

		model.addAttribute("editPostForm", editPostForm);

		return "editPost";
	}

	@RequestMapping(value = "/postEditSubmit", method = RequestMethod.POST)
	@Secured({PermissionConstants.POST_EDIT_ANY, PermissionConstants.POST_EDIT_OWN})
	@Transactional
	public String submitEditPost(@Valid final EditPostForm postForm, final BindingResult bindingResult) {

		final Post post = postRepository.findOne(postForm.getPostId());

		if (!postService.canEditPost(post)) {
			throw new Errors.Forbidden();
		}

		if (bindingResult.hasErrors()) {
			return "editPost";
		}

		post.setText(postForm.getText());

		postRepository.save(post);

		return "redirect:" + Utils.topicURL(post.getTopic());
	}

	@RequestMapping(value = "/postDelete", method = RequestMethod.GET)
	@Secured({PermissionConstants.POST_DELETE_ANY, PermissionConstants.POST_DELETE_OWN})
	public View postDelete(@RequestParam final long id, final HttpServletRequest request) {

		postService.deletePost(id);
		return new RedirectView(request.getHeader("Referer"), true);
	}

	@RequestMapping(value = "/postRevive", method = RequestMethod.GET)
	@Secured({PermissionConstants.POST_REVIVE_ANY, PermissionConstants.POST_REVIVE_OWN})
	public View postRevive(@RequestParam final long id, final HttpServletRequest request) {

		postService.revivePost(id);
		return new RedirectView(request.getHeader("Referer"), true);
	}
}
