package sforum.web.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.InitializingBean;
import sforum.model.Topic;
import sforum.web.dto.TopicDTO;

import java.util.List;

/**
 * Created by @ivan.
 */
@Mapper(componentModel = "spring", uses = {PostMapper.class})
public abstract class TopicMapper implements InitializingBean {

	@Mapping(target = "postsPage", ignore = true)
	public abstract TopicDTO topicToTopicDTO(Topic topic);

	public abstract List<TopicDTO> topicsTopicDTOs(List<Topic> topics);

	@Override
	public void afterPropertiesSet() throws Exception {
		System.out.println("asdasd");
	}
}
