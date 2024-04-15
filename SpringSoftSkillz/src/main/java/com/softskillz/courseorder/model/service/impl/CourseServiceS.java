package com.softskillz.courseorder.model.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.course.model.CourseBean;
import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.dao.CourseDaoInterface;
import com.softskillz.courseorder.model.service.CourseServiceInterface;

@Service
@Transactional
public class CourseServiceS implements CourseServiceInterface {


	@Autowired
	private CourseDaoInterface dao;

	@Override
	public List<Course2> selectCourse() {

		List<CourseBean> courseList = dao.selectCourse();
		System.out.println(courseList);
		List<Course2> courses = new ArrayList<Course2>();

		for (CourseBean c : courseList) {
			Course2 course2 = new Course2();
			course2.setCourseID(c.getCourseID());
			course2.setTeacherName(
					c.getTeacherBean().getTeacherLastName() + c.getTeacherBean().getTeacherFirstName());
			course2.setTeacherPhoto(c.getTeacherBean().getTeacherPhoto());
			course2.setCourseName(c.getCourseName());
			course2.setCourseInfo(c.getCourseInfo());
			course2.setCourseCategory(c.getCourseCategory());
			course2.setPrice(c.getCoursePrice());
			courses.add(course2);
		}
//		logger.debug("Debug message");
		return courses;

	}

	@Override
	public Course2 selectCourseByID(Integer courseID) {
		CourseBean courseBean2 = dao.selectCourseByID(courseID);
		Course2 course2 = new Course2();
		course2.setCourseID(courseBean2.getCourseID());
		course2.setTeacherName(courseBean2.getTeacherBean().getTeacherLastName()
				+ courseBean2.getTeacherBean().getTeacherFirstName());
		course2.setTeacherPhoto(courseBean2.getTeacherBean().getTeacherPhoto());
		course2.setCourseName(courseBean2.getCourseName());
		course2.setCourseInfo(courseBean2.getCourseInfo());
		course2.setCourseCategory(courseBean2.getCourseCategory());
		course2.setPrice(courseBean2.getCoursePrice());
		return course2;

	}
	

}
