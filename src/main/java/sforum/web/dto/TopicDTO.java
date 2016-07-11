package sforum.web.dto;

import org.springframework.data.domain.Page;

/**
 * Created by @ivan.
 */
public class TopicDTO {

	private Long id;
	private String name;
	private String description;
	private Boolean deleted;
	private Boolean locked;
	private Page<PostDTO> postsPage;

	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(final Boolean deleted) {
		this.deleted = deleted;
	}

	public Boolean getLocked() {
		return locked;
	}

	public void setLocked(final Boolean locked) {
		this.locked = locked;
	}

	public Page<PostDTO> getPostsPage() {
		return postsPage;
	}

	public void setPostsPage(final Page<PostDTO> postsPage) {
		this.postsPage = postsPage;
	}
}
