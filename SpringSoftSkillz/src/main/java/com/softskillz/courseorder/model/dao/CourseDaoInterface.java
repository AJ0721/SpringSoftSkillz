package com.softskillz.courseorder.model.dao;

import java.util.List;


import com.softskillz.course.model.CourseBean;

public interface CourseDaoInterface {

	List<CourseBean> selectCourse();
	CourseBean selectCourseByID(Integer courseID);
}
