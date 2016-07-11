package sforum.forms;


import javax.validation.constraints.NotNull;


public class EditPostForm extends PostForm {

	@NotNull
	private long postId;

	public EditPostForm(){}

	public EditPostForm(final long threadId, final long postId) {
		super(threadId);
		this.postId = postId;
	}

	public void setPostId(final long postId) {
		this.postId = postId;
	}

	public long getPostId() {
		return postId;
	}
}
