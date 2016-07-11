package sforum.forms;


import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;


public class PostForm {

	@NotNull
	@Length(min = 5, max = 5000)
	private String text;

	@NotNull
	private long threadId;

	public PostForm(){}

	public PostForm(final long threadId) {
		this.threadId = threadId;
	}

	public String getText() {
		return text;
	}

	public void setText(final String text) {
		this.text = text;
	}

	public long getThreadId() {
		return threadId;
	}

	public void setThreadId(final long threadId) {
		this.threadId = threadId;
	}
}
