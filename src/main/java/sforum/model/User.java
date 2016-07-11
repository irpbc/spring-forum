package sforum.model;


import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
public class User implements Serializable {

	protected static final long serialVersionUID = 42L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "username")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "date_of_birth")
	private LocalDate dateOfBirth;

	@Column(name = "join_date")
	private LocalDateTime joinDate;

	@Column(name = "post_count")
	private int postCount;

	@ManyToOne
	@JoinColumn(name = "role_id")
	private Role role;

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

	public String getPassword() {
		return password;
	}

	public void setPassword(final String password) {
		this.password = password;
	}

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(final LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public LocalDateTime getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(final LocalDateTime joinDate) {
		this.joinDate = joinDate;
	}

	public int getPostCount() {
		return postCount;
	}

	public void setPostCount(final int postCount) {
		this.postCount = postCount;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(final Role role) {
		this.role = role;
	}
}
