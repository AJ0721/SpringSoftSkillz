package com.softskillz.courseorder.model.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.Course2;

public interface CourseServiceInterface {
	List<Course2> selectCourse();
	Course2 selectCourseByID(Integer courseID);
}
