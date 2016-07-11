package sforum.model;


import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "topic")
public class Topic implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "name")
	private String name;

	@Column(name = "post_count")
	private int postCount;

	@Column(name = "total_post_count")
	private int totalPostCount;

	@Column(name = "pinned")
	private boolean pinned;

	@Column(name = "deleted")
	private boolean deleted;

	@Column(name = "locked")
	private boolean locked;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "forum_id")
	private Forum forum;

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

	public int getPostCount() {
		return postCount;
	}

	public void setPostCount(final int postCount) {
		this.postCount = postCount;
	}

	public int getTotalPostCount() {
		return totalPostCount;
	}

	public void setTotalPostCount(final int totalPostCount) {
		this.totalPostCount = totalPostCount;
	}

	public boolean isPinned() {
		return pinned;
	}

	public void setPinned(final boolean pinned) {
		this.pinned = pinned;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(final boolean deleted) {
		this.deleted = deleted;
	}

	public boolean isLocked() {
		return locked;
	}

	public void setLocked(final boolean locked) {
		this.locked = locked;
	}

	public Forum getForum() {
		return forum;
	}

	public void setForum(final Forum forum) {
		this.forum = forum;
	}
}
