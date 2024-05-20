package com.softskillz.zoom.controller;

import java.time.OffsetDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.zoom.model.ZoomService;


@RestController
@RequestMapping("/zoom")
public class ZoomController {

	private final ZoomService zoomService;

	public ZoomController(ZoomService zoomService) {
		this.zoomService = zoomService;
	}

	@GetMapping("/create-meeting")
	public ResponseEntity<String> createMeeting(
			@RequestParam("start_time") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) OffsetDateTime startTime,
			@RequestParam("meeting_name") String meetingName, @RequestParam("meeting_type") int meetingType) {
		try {
			String meetingUrl = zoomService.createMeeting(startTime, meetingName, meetingType);
			return ResponseEntity.ok(meetingUrl);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
		}
	}
}