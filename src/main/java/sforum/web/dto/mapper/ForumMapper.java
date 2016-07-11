package sforum.web.dto.mapper;

import org.mapstruct.Mapper;
import sforum.model.Forum;
import sforum.web.dto.ForumDTO;

import java.util.List;

@Mapper(componentModel = "spring")
public abstract class ForumMapper {

	public abstract ForumDTO forumToForumDTO(Forum forum);

	public abstract List<ForumDTO> forumsToForumDTOs(List<Forum> forums);
}
