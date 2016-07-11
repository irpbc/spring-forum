package sforum.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class Forum implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "name")
	private String name;

	@Column(name = "description")
	private String description;

	@Column(name = "topic_count")
	private int threadCount;

	@Column(name = "total_topic_count")
	private int totalThreadCount;

	@Column(name = "post_count")
	private int postCount;

	@Column(name = "total_post_count")
	private int totalPostCount;

	@Column(name = "position")
	private Integer position;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	private Forum parent;

	@OneToMany(mappedBy = "parent")
	@OrderBy("position asc")
	private List<Forum> subForums;

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

	public int getThreadCount() {
		return threadCount;
	}

	public void setThreadCount(final int threadCount) {
		this.threadCount = threadCount;
	}

	public int getTotalThreadCount() {
		return totalThreadCount;
	}

	public void setTotalThreadCount(final int totalThreadCount) {
		this.totalThreadCount = totalThreadCount;
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

	public Integer getPosition() {
		return position;
	}

	public void setPosition(final Integer position) {
		this.position = position;
	}

	public Forum getParent() {
		return parent;
	}

	public void setParent(final Forum parent) {
		this.parent = parent;
	}

	public List<Forum> getSubForums() {
		return subForums;
	}

	public void setSubForums(final List<Forum> subForums) {
		this.subForums = subForums;
	}
}
