package sforum.forms;


import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

public class ThreadForm {

	@Length(min = 5, max = 200)
	private String title;

	@Length(min = 5, max = 5000)
	private String firstPostText;

	@NotNull
	private long forumId;

	public ThreadForm() {
	}

	public ThreadForm(final long forumId) {
		this.forumId = forumId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(final String title) {
		this.title = title;
	}

	public String getFirstPostText() {
		return firstPostText;
	}

	public void setFirstPostText(final String firstPostText) {
		this.firstPostText = firstPostText;
	}

	public long getForumId() {
		return forumId;
	}

	public void setForumId(final long forumId) {
		this.forumId = forumId;
	}
}
