package com.softskillz.account.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.NoResultException;

@Transactional
@Repository
public class StudentDao implements InterfaceStudentDao {

	@Autowired
	private SessionFactory factory;

	@Override
	public StudentBean studentLogin(String account, String pwd) {
		Session session = factory.openSession();
		String hql = "from StudentBean s where s.studentUsername = :acc AND s.studentPassword = :pwd";
		StudentBean studentBean = session.createQuery(hql, StudentBean.class).setParameter("acc", account)
				.setParameter("pwd", pwd).uniqueResult();

		return studentBean;
	}

	@Override
	// login authentication
	public StudentBean authenticateStudent(String studentUsername, String studentPassword) {
		String hql = "FROM StudentBean WHERE studentUsername = :username AND studentPassword = :password";
		try (Session session = factory.openSession()) {
			Query<StudentBean> query = session.createQuery(hql, StudentBean.class)
					.setParameter("username", studentUsername).setParameter("password", studentPassword);

			StudentBean student = query.uniqueResult();
			return student;
		} catch (NoResultException e) {
			e.printStackTrace();
		}
		return null;

	}

	@Override
	// read student data
	public StudentBean getStudentById(int studentId) {
		StudentBean student = null;
		String hql = "FROM StudentBean WHERE studentId = :studentId;";

		try {
			Session session = factory.openSession();

			Query<StudentBean> query = session.createQuery(hql, StudentBean.class).setParameter("studentId", studentId);

			student = query.getSingleResult();
			session.close();

			return student;

		} catch (NoResultException e) {
			e.printStackTrace();
		}
		return null;
	}
}
