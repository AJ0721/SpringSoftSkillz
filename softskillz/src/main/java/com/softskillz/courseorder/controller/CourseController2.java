package com.softskillz.courseorder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.service.impl.CourseServiceImpl;



@Controller
@RequestMapping("/courses")
public class CourseController2 {

	@Autowired
	private CourseServiceImpl cService;

	@GetMapping("/course.do")
	public String processAction() {
		return "/courseorder/html/course.html";
	}

	@GetMapping
	@ResponseBody
	public List<Course2> getAllCourse() {
		return cService.getAllCourse();
	}

	@GetMapping("/{courseID}")
	public String getCourseById(@PathVariable("courseID") Integer courseID, Model m) {
		Course2 course = cService.getCourseById(courseID);
		System.out.println(course.getTeacherID());
		m.addAttribute("course", course);
		return "courseorder/jsp/CourseDetail.jsp";
	}

}
