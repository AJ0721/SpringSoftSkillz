package com.softskillz.homepage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/softskillz")
public class HomePageController {
	
	@GetMapping("/newhomepage")
	public String homePage() {
		return "/dist/index.html";
	}
	
	@GetMapping("/fhomepage")
	public String fhomePage() {
		return "/elearning/index.html";
	}
}
