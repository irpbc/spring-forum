package sforum.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sforum.beans.Application;
import sforum.beans.SessionData;
import sforum.model.Forum;
import sforum.model.Topic;
import sforum.repository.ForumRepository;
import sforum.repository.PostRepository;
import sforum.repository.TopicRepository;
import sforum.repository.UserRepository;
import sforum.service.ConfigurationService;
import sforum.service.ForumService;
import sforum.web.controller.httpcodes.HttpReturnCode404NotFound;
import sforum.web.dto.ForumDTO;

import java.util.List;


@Controller
public class ForumController {

	@Autowired
	PostRepository postRepository;

	@Autowired
	TopicRepository topicRepository;

	@Autowired
	ForumRepository forumRepository;

	@Autowired
	ForumService forumService;

	@Autowired
	UserRepository userRepository;

	@Autowired
	SessionData forumSession;

	@Autowired
	Application application;

	@Autowired
	ConfigurationService configurationService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(final Model model) {

		final List<ForumDTO> forums = forumService.getTopLevelForums();
		model.addAttribute("forums", forums);

		return "index";
	}


	@RequestMapping(value = {"/forum/{id}-{name}"}, method = RequestMethod.GET)
	public String forum(final Model model, @PathVariable final Long id, @PathVariable final String name) {

		return forumPage(model, id, name, 1);
	}

	@RequestMapping(value = "/forum/{id}-{name}/page-{page}", method = RequestMethod.GET)
	public String forumPage(final Model model, @PathVariable final Long id, @PathVariable final String name,
							@PathVariable final Integer page) {

		final Forum forum = forumService.findOne(id);
		if (forum == null || !forum.getName().equals(name))
			throw new HttpReturnCode404NotFound();

		final int pageSize = configurationService.getThreadsPageSize();

		final Page<Topic> topics;
		if (forumSession.isShowDeletedThreads()) {
			topics = topicRepository.findByForumAndPinned(forum, false, new PageRequest(page - 1, pageSize));
		} else {
			topics = topicRepository.findByForumAndPinnedAndDeleted(forum, false, false, new PageRequest(page - 1, pageSize));
		}

		model.addAttribute("pageData", topics);
		model.addAttribute("forum", forum);

		return "forum";
	}

	@RequestMapping(value = "/resources.js", method = RequestMethod.GET)
	public String getJsResources() {
		return "th/jsResources";
	}
}
