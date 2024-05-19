package com.softskillz.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.util.SessionUserUtils;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/session")
public class SessionController {
	
	  @Autowired
	    private SessionUserUtils sessionUtils;

	    @GetMapping("/logged-in-user")
	    public ResponseEntity<Object> getLoggedInUser(HttpSession session) {
	        Object loggedInUser = sessionUtils.getLoggedInUser(session);
	        if (loggedInUser == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
	        }
	        return ResponseEntity.ok(loggedInUser);
	    }

	    @GetMapping("/user-type")
	    public ResponseEntity<String> getUserType(HttpSession session) {
	        String userType = sessionUtils.getUserType(session);
	        if (userType == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
	        }
	        return ResponseEntity.ok(userType);
	    }
	

}
