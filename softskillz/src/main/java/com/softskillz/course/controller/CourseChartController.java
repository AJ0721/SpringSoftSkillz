package com.softskillz.course.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.course.model.CourseRepository;

@RestController
@RequestMapping("/api/course")
public class CourseChartController {

	@Autowired
	private CourseRepository courseRepository;

	@GetMapping("/courseCount")
	public List<Object[]> getCourseCategoryCount() { 
		return courseRepository.countCoursesByCategory();
	}
}
