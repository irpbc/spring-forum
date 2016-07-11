package sforum.web.dto;


import sforum.model.Forum;

import java.util.List;

public class ForumDTO {

	private Long id;
	private String name;
	private String description;
	private int threadCount;
	private int totalThreadCount;
	private int postCount;
	private int totalPostCount;
	private Forum parent;
	private Integer position;

	private List<ForumDTO> subForums;

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

	public List<ForumDTO> getSubForums() {
		return subForums;
	}

	public void setSubForums(final List<ForumDTO> subForums) {
		this.subForums = subForums;
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

	public Forum getParent() {
		return parent;
	}

	public void setParent(final Forum parent) {
		this.parent = parent;
	}

	public Integer getPosition() {
		return position;
	}

	public void setPosition(final Integer position) {
		this.position = position;
	}
}
