package com.softskillz.zoom.model;

import java.nio.charset.StandardCharsets;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ZoomService {

	@Value("${zoom.client.id}")
	private String clientId;

	@Value("${zoom.client.secret}")
	private String clientSecret;

	@Value("${zoom.account.id}")
	private String accountId;

	@Value("${zoom.oauth.url:https://zoom.us/oauth/token}")
	private String oauthUrl;

	@Value("${zoom.create.meeting.url:https://api.zoom.us/v2/users/me/meetings}")
	private String createMeetingUrl;
	
//	@Value("${zoom.delete.meeting.url:https://api.zoom.us/v2/meetings/}")
//    private String deleteMeetingUrl;

	private final RestTemplate restTemplate;

	public ZoomService(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public String createMeeting(OffsetDateTime startTime, String meetingName, int meetingType) throws Exception {
		String accessToken = getAccessToken();
		return createZoomMeeting(accessToken, startTime, meetingName, meetingType);
	}

	private String getAccessToken() throws Exception {
		HttpHeaders headers = createHeaders();
		String body = "grant_type=account_credentials&account_id=" + accountId;
		HttpEntity<String> request = new HttpEntity<>(body, headers);

		ResponseEntity<String> response = restTemplate.postForEntity(oauthUrl, request, String.class);

		if (response.getStatusCode().is2xxSuccessful()) {
			JSONObject jsonResponse = new JSONObject(response.getBody());
			return jsonResponse.getString("access_token");
		} else {
			throw new Exception("Failed to get access token: " + response.getStatusCode());
		}
	}

	private HttpHeaders createHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		String auth = clientId + ":" + clientSecret;
		byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes(StandardCharsets.UTF_8));
		String authHeader = "Basic " + new String(encodedAuth);
		headers.set("Authorization", authHeader);
		return headers;
	}

	private String createZoomMeeting(String accessToken, OffsetDateTime startTime, String meetingName, int meetingType)
			throws Exception {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.add("Content-Type", "application/json");

		String startTimeIso = startTime.format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);
		String meetingDetails = String.format("{\"topic\":\"%s\",\"type\":%d,\"start_time\":\"%s\"}", meetingName,
				meetingType, startTimeIso);
		HttpEntity<String> request = new HttpEntity<>(meetingDetails, headers);

		ResponseEntity<String> response = restTemplate.postForEntity(createMeetingUrl, request, String.class);

		if (response.getStatusCode().is2xxSuccessful()) {
			JSONObject jsonResponse = new JSONObject(response.getBody());
			return jsonResponse.getString("join_url");
		} else {
			throw new Exception("Failed to create meeting: " + response.getStatusCode());
		}
	}

//	public void deleteMeeting(String meetingUrl) throws Exception {
//        String meetingId = extractMeetingId(meetingUrl);
//        String accessToken = getAccessToken();
//        deleteZoomMeeting(accessToken, meetingId);
//    }
//
//    private String extractMeetingId(String meetingUrl) {
//        // 提取會議ID
//        return meetingUrl.substring(meetingUrl.lastIndexOf("/") + 1);
//    }
//
//    private void deleteZoomMeeting(String accessToken, String meetingId) throws Exception {
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Authorization", "Bearer " + accessToken);
//        headers.add("Content-Type", "application/json");
//
//        HttpEntity<String> request = new HttpEntity<>(null, headers);
//        String deleteUrl = deleteMeetingUrl + meetingId;
//
//        ResponseEntity<String> response = restTemplate.exchange(deleteUrl, HttpMethod.DELETE, request, String.class);
//
//        if (!response.getStatusCode().is2xxSuccessful()) {
//            throw new Exception("Failed to delete meeting: " + response.getStatusCode());
//        } else {
//            System.out.println("Meeting deleted successfully");
//        }
//    }
}