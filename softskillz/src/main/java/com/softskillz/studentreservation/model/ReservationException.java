package com.softskillz.studentreservation.model;

public class ReservationException extends Exception {
	private String errorCode;

	public ReservationException(String message, String errorCode) {
		super(message);
		this.errorCode = errorCode;
	}

	public String getErrorCode() {
		return errorCode;
	}
}
