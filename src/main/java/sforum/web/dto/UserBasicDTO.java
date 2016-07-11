package sforum.web.dto;

import java.time.LocalDateTime;

/**
 * Created by @ivan.
 */
public class UserBasicDTO {

	private Long id;
	private String username;
	private LocalDateTime joinDate;
	private Integer postCount;
	private boolean loggedIn;

	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}

	public LocalDateTime getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(final LocalDateTime joinDate) {
		this.joinDate = joinDate;
	}

	public Integer getPostCount() {
		return postCount;
	}

	public void setPostCount(final Integer postCount) {
		this.postCount = postCount;
	}

	public boolean isLoggedIn() {
		return loggedIn;
	}

	public void setLoggedIn(final boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
}
