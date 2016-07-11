package sforum.web.controller.httpcodes;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class HttpReturnCode404NotFound extends RuntimeException {
}
