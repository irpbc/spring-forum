package sforum.web.dto;

import java.time.LocalDate;

/**
 * Created by @ivan.
 */
public class UserDTO extends UserBasicDTO {

	private LocalDate dateOfBirth;
	private int age;

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(final LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public int getAge() {
		return age;
	}

	public void setAge(final int age) {
		this.age = age;
	}
}
