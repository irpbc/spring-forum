package sforum.web.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import sforum.model.Post;
import sforum.web.dto.PostDTO;
import sforum.web.dto.UserBasicDTO;

import java.util.List;

/**
 * Created by @ivan.
 */
@Mapper(componentModel = "spring", uses = { UserMapper.class })
public abstract class PostMapper {

	@Mapping(target = "editable", ignore = true)
	@Mapping(target = "deletable", ignore = true)
	@Mapping(target = "user", resultType = UserBasicDTO.class)
	public abstract PostDTO postToPostDTO(Post post);

	public abstract List<PostDTO> postsToPostDTOs(List<Post> posts);
}
