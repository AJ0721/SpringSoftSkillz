package com.softskillz.studentschedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/studentSchedule")
public class StudentScheduleController {

	// 學生行事曆CRUD頁面
	@GetMapping("/studentSchedulePage/studentScheduleAllPage")
	public String studentScheduleAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/studentSchedule/studentSchedulePage/studentScheduleAllPage.jsp";
	}

}
