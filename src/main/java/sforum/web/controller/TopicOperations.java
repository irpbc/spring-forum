package sforum.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import sforum.beans.SessionData;
import sforum.forms.ThreadForm;
import sforum.model.Forum;
import sforum.model.Post;
import sforum.model.Topic;
import sforum.repository.ForumRepository;
import sforum.repository.PostRepository;
import sforum.repository.TopicRepository;
import sforum.repository.UserRepository;
import sforum.security.PermissionConstants;
import sforum.service.ConfigurationService;
import sforum.service.ForumService;
import sforum.service.TopicService;
import sforum.utils.Utils;
import sforum.web.controller.httpcodes.Errors;
import sforum.web.dto.TopicDTO;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.LocalDateTime;

@Controller
public class TopicOperations {

	@Autowired
	SessionData sessionData;

	@Autowired
	TopicService topicService;

	@Autowired
	ForumService forumService;

	@Autowired
	ForumRepository forumRepository;

	@Autowired
	TopicRepository topicRepository;

	@Autowired
	PostRepository postRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	ConfigurationService configurationService;

	@RequestMapping(value = {"/thread/{id}-{name}"}, method = RequestMethod.GET)
	public String thread(final Model model, @PathVariable final Long id,
	                     @PathVariable final String name) {

		return threadPage(model, id, name, 1);
	}

	@RequestMapping(value = "/thread/{id}-{name}/page-{page}", method = RequestMethod.GET)
	public String threadPage(final Model model, @PathVariable final long id,
	                         @PathVariable final String name,
	                         @PathVariable("page") final int pageNumber) {

		final TopicDTO topicDTO = topicService.getTopic(id, name, pageNumber);

		if (topicDTO == null) {
			throw new Errors.NotFound();
		}

		model.addAttribute("topic", topicDTO);
		return "topic";
	}

	@RequestMapping(value = "/threadCreate")
	@Secured(PermissionConstants.THREAD_CREATE)
	public String threadCreate(final Model model, @RequestParam final long forumId) {

		model.addAttribute("threadForm", new ThreadForm(forumId));
		model.addAttribute("forumId", forumId);

		return "newTopic";
	}

	@RequestMapping(value = "/threadSubmit", method = RequestMethod.POST)
	@Secured(PermissionConstants.THREAD_CREATE)
	@Transactional
	public String threadSubmit(@Valid final ThreadForm threadForm, final BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			return "newTopic";
		}

		final Forum forum = forumRepository.findOne(threadForm.getForumId());

		// TODO: parent forum id != 0
		if (forum == null || forum.getParent() == null) {
			bindingResult.reject("");
		}

		final Topic newTopic = new Topic();
		newTopic.setName(threadForm.getTitle());
		newTopic.setPinned(false);
		newTopic.setDeleted(Boolean.FALSE);
		newTopic.setForum(forum);
		newTopic.setLocked(Boolean.FALSE);
		newTopic.setPinned(Boolean.FALSE);
		newTopic.setPostCount(0);
		newTopic.setTotalPostCount(0);

		topicRepository.save(newTopic);

		final Post newPost = new Post();
		newPost.setText(threadForm.getFirstPostText());
		newPost.setTopic(newTopic);
		newPost.setUser(sessionData.getCurrentUser());
		newPost.setDeleted(Boolean.FALSE);
		newPost.setTimestamp(LocalDateTime.now());

		postRepository.save(newPost);

		forumService.threadCreated(threadForm.getForumId());

		return "redirect:" + Utils.topicURL(newTopic);
	}

	@RequestMapping(value = "/threadSetPinned")
	@Secured(PermissionConstants.THREAD_EDIT)
	public View threadSetPinned(@RequestParam final long id, @RequestParam final boolean pinned) {

		final Topic topic = topicRepository.findOne(id);
		Utils.checkNull(topic);

		topic.setPinned(pinned);

		topicRepository.save(topic);

		return new RedirectView(Utils.forumURL(topic.getForum()), true);
	}

	@RequestMapping(value = "/threadDelete")
	@Secured(PermissionConstants.THREAD_DELETE)
	public View threadDelete(@RequestParam final long id, final HttpServletRequest request) {

		topicService.deleteTopic(id);

		return new RedirectView(request.getHeader("Referer"), true);
	}

	@RequestMapping(value = "/threadRevive")
	@Secured(PermissionConstants.THREAD_REVIVE)
	public View threadRevive(@RequestParam final long id, final HttpServletRequest request) {

		topicService.reviveTopic(id);

		return new RedirectView(request.getHeader("Referer"), true);
	}

	@RequestMapping(value = "/threadSetLocked")
	@Secured(PermissionConstants.THREAD_LOCK)
	@Transactional
	public View threadSetLocked(@RequestParam final long id, @RequestParam final boolean locked) {

		final Topic topic = topicRepository.findOne(id);
		topic.setLocked(locked);

		topicRepository.save(topic);

		return new RedirectView(Utils.topicURL(topic), true);
	}
}
