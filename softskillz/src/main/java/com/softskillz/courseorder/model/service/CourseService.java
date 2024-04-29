package com.softskillz.courseorder.model.service;

import java.util.List;

import com.softskillz.courseorder.model.bean.Course2;


public interface CourseService {
	
	List<Course2> getAllCourse();
	Course2 getCourseById(Integer id);
}
