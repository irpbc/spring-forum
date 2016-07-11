package sforum.web.dto;

import java.time.LocalDateTime;

/**
 * Created by @ivan.
 */
public class PostDTO {

	private Long id;
	private LocalDateTime timestamp;
	private String text;
	private Boolean editable;
	private Boolean deleted;

	private Boolean deletable;

	private UserBasicDTO user;

	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public LocalDateTime getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(final LocalDateTime timestamp) {
		this.timestamp = timestamp;
	}

	public String getText() {
		return text;
	}

	public void setText(final String text) {
		this.text = text;
	}

	public Boolean getEditable() {
		return editable;
	}

	public void setEditable(final Boolean editable) {
		this.editable = editable;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(final Boolean deleted) {
		this.deleted = deleted;
	}

	public Boolean getDeletable() {
		return deletable;
	}

	public void setDeletable(final Boolean deletable) {
		this.deletable = deletable;
	}

	public UserBasicDTO getUser() {
		return user;
	}

	public void setUser(final UserBasicDTO user) {
		this.user = user;
	}
}
