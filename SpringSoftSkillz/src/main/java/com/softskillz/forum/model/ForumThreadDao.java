package com.softskillz.forum.model;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Repository
@Transactional
public class ForumThreadDao implements InterfaceForumThreadDao {

	@Autowired
	private SessionFactory sessionFactory;

	// select all threads by keyword
	public List<ForumThreadBean> selectThreadsByKeyword(String keyword) {

		String hql = "FROM ForumThreadBean WHERE threadTitle LIKE :keyword OR threadContent LIKE :keyword ORDER BY threadCreatedTime DESC";

		try (Session session = sessionFactory.openSession()) {

			return session.createQuery(hql, ForumThreadBean.class).setParameter("keyword", "%" + keyword + "%")
					.getResultList();

		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return new ArrayList<ForumThreadBean>();
	}

	// select all threads
	public List<ForumThreadBean> selectAllThreads() {

		String hql = "FROM forumThreadBean;";

		try (Session session = sessionFactory.openSession()) {
			return session.createQuery(hql, ForumThreadBean.class).getResultList();

		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return new ArrayList<ForumThreadBean>();
	}

	public ForumThreadBean selectThreadById(int threadId) {

		try (Session session = sessionFactory.openSession()) {
			ForumThreadBean thread = session.get(ForumThreadBean.class, threadId);
			return thread;
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<ForumThreadBean> selectThreadsByStudentId(Integer studentId) {

		String hql = "FROM ForumThreadBean WHERE studentBean.studentId=:studentId  ORDER BY threadCreatedTime DESC";
		Session session = sessionFactory.openSession();

		try {

			List<ForumThreadBean> threads = session.createQuery(hql, ForumThreadBean.class)
					.setParameter("studentId", studentId).getResultList();

			return threads;

		} catch (HibernateException e) {

			System.out.println("in catch");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;

	}

	public List<ForumThreadBean> selectThreadsByTeacherId(Integer teacherId) {

		String hql = "FROM ForumThreadBean WHERE teacherBean.teacherId=:teacherId  ORDER BY threadCreatedTime DESC";
		Session session = null;
		try {
			session = sessionFactory.openSession();
			List<ForumThreadBean> threads = session.createQuery(hql, ForumThreadBean.class)
					.setParameter("teacherId", teacherId).getResultList();

			return threads;

		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public boolean deleteThread(ForumThreadBean thread) {

		Session session = sessionFactory.openSession();
		try {
			
			session.remove(thread);
			session.flush();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return false;
	}



	public void updateThread(ForumThreadBean thread) {

		try (Session session = sessionFactory.openSession()) {

			session.merge(thread);
			session.flush();

		} catch (HibernateException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void insertThread(ForumThreadBean thread, Integer studentId, Integer teacherId) {
		// TODO Auto-generated method stub
		
	}

	// upload image/video/audio in thread

}
