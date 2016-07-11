package sforum.web.controller.httpcodes;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Created by @ivan.
 */
public final class Errors {

	private Errors() {}

	@ResponseStatus(HttpStatus.FORBIDDEN)
	public static class Forbidden extends RuntimeException {

	}

	@ResponseStatus(HttpStatus.NOT_FOUND)
	public static class NotFound extends RuntimeException {

	}

	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public static class BadRequest extends RuntimeException {

	}
}
