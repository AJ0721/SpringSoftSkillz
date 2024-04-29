package com.softskillz.courseorder.model.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.bean.CourseBean2;
import com.softskillz.courseorder.model.repository.CourseRepositoryS;
import com.softskillz.courseorder.model.service.CourseService;


@Service
@Transactional
public class CourseServiceImpl implements CourseService {

	@Autowired
	private CourseRepositoryS cRepo;

	@Override
	public List<Course2> getAllCourse() {
		List<CourseBean2> resultList = cRepo.findAll();
		List<Course2> courses = new ArrayList<Course2>();
		for (CourseBean2 c : resultList) {
			Course2 course2 = new Course2();
			course2.setCourseID(c.getCourseID());
			course2.setTeacherName(c.getTeacherBean().getTeacherLastName() + c.getTeacherBean().getTeacherFirstName());
			course2.setTeacherPhoto(c.getTeacherBean().getTeacherPhoto());
			course2.setCourseName(c.getCourseName());
			course2.setCourseInfo(c.getCourseInfo());
			course2.setCourseCategory(c.getCourseCategory());
			course2.setPrice(c.getCoursePrice());
			courses.add(course2);
		}
		return courses;

	}

	@Override
	public Course2 getCourseById(Integer id) {
		Optional<CourseBean2> op1 = cRepo.findById(id);
		Course2 course2 = new Course2();
		if (op1.isPresent()) {
			CourseBean2 resultBean = op1.get();
			course2.setCourseID(resultBean.getCourseID());
			course2.setTeacherName(resultBean.getTeacherBean().getTeacherLastName()
					+ resultBean.getTeacherBean().getTeacherFirstName());
			course2.setTeacherPhoto(resultBean.getTeacherBean().getTeacherPhoto());
			course2.setCourseName(resultBean.getCourseName());
			course2.setCourseInfo(resultBean.getCourseInfo());
			course2.setCourseCategory(resultBean.getCourseCategory());
			course2.setPrice(resultBean.getCoursePrice());
		}
		return course2;
	}

}
