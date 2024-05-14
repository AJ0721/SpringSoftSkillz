package com.softskillz.course.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.service.TeacherService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;

@Controller
@RequestMapping("/courseFront")
public class CourseFrontController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherService teacherService;

	// 加載頁面
	@GetMapping("/selectAllPage")
	public String loadCoursesPage() {
		return "elearning/course/courseSelectPage.html"; // 返回頁面的名稱，注意不要加.html或.jsp，確保配置正確
	}

	// AJAX 請求所有課程資料
	@GetMapping("/selectAllCourses")
	@ResponseBody // 指明返回的是 JSON 數據
	public ResponseEntity<List<CourseBean>> getAllCourses() {
		List<CourseBean> courses = courseService.findAllCourses();
		return ResponseEntity.ok(courses); // 返回包含課程列表的 ResponseEntity
	}

}