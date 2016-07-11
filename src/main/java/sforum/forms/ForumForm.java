package sforum.forms;


import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

public class ForumForm {

	@Length(min = 8, max = 150)
	private String forumName;

	@NotNull
	private Long parentId;

	public ForumForm(final Long parentId) {
		this.parentId = parentId;
	}

	public ForumForm() {
	}

	public String getForumName() {
		return forumName;
	}

	public void setForumName(final String forumName) {
		this.forumName = forumName;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(final Long parentId) {
		this.parentId = parentId;
	}
}
