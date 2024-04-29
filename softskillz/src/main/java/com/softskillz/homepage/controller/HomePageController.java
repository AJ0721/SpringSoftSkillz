package com.softskillz.homepage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomePageController {
	
	@GetMapping("/homepage")
	public String courseAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/pages/backendPage.jsp";
	}
}
