package com.softskillz.account.model;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.account.model.InterfaceTeacherDao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import jakarta.persistence.NoResultException;

@Repository
@Transactional
public class TeacherDao implements InterfaceTeacherDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	// login authentication

	public TeacherBean authenticateTeacher(String teacherUsername, String teacherPassword) {
		String hql = "FROM TeacherBean WHERE teacherUserName = :username AND teacherPassword = :password";

		try (Session session = sessionFactory.openSession()) {

			Query<TeacherBean> query = session.createQuery(hql, TeacherBean.class)
					.setParameter("username", teacherUsername).setParameter("password", teacherPassword);

			TeacherBean teacher = query.getSingleResult();

			return teacher;

		} catch (NoResultException e) {
			e.printStackTrace();
		}
		return null; // for debugging

	}

	@Override
	// read teacher data
	public TeacherBean getTeacherById(int teacherId) {
		String hql = "FROM teacherBean WHERE teacherId = :teachertId;";

		try (Session session = sessionFactory.openSession()){

			Query<TeacherBean> query = session.createQuery(hql, TeacherBean.class).setParameter("teacherId",
					teacherId);

			TeacherBean teacher = query.getSingleResult();
			return teacher;

		} catch (NoResultException e) {
			e.printStackTrace();
		}
		return null;
	}

}
