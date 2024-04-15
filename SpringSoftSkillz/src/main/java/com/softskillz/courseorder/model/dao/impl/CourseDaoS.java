package com.softskillz.courseorder.model.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.course.model.CourseBean;
import com.softskillz.courseorder.model.dao.CourseDaoInterface;

@Repository
public class CourseDaoS implements CourseDaoInterface {

	@Autowired
	private SessionFactory factory;

	@Override
	@Transactional
	public List<CourseBean> selectCourse() {
		Session session = factory.openSession();
		String hal = "FROM CourseBean c LEFT JOIN FETCH c.teacherBean";
		Query<CourseBean> query = session.createQuery(hal, CourseBean.class);
		List<CourseBean> courseList = query.getResultList();
		session.close();
		return courseList;
	}

	@Override
	@Transactional
	public CourseBean selectCourseByID(Integer courseID) {
		Session session = factory.openSession();
		String hal = "FROM CourseBean c LEFT JOIN FETCH c.teacherBean WHERE c.courseID = :cid";
		Query<CourseBean> query = session.createQuery(hal, CourseBean.class).setParameter("cid", courseID);
		CourseBean courseBean = query.getSingleResult();
		session.close();	
		return courseBean;
	}

}
