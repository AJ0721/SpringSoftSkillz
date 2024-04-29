package com.softskillz.studentreservation.model;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionAdvice {

	@ExceptionHandler(ReservationException.class)
	public ResponseEntity<Object> handleReservationException(ReservationException ex) {
		Map<String, Object> body = new LinkedHashMap<>();
		body.put("timestamp", LocalDateTime.now());
		body.put("message", ex.getMessage());
		body.put("errorCode", ex.getErrorCode());

		return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
	}
}