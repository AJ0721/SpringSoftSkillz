package com.softskillz.forum.model;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.wls.shaded.org.apache.bcel.generic.RETURN;

import org.hibernate.query.Query;

@Repository
@Transactional
public class ForumCategoryDao {

	@Autowired
	SessionFactory sessionFactory;

	public Set<ForumCategoryBean> getAllCategories() {
		Session session = sessionFactory.openSession();
		try {
			String hql = "FROM ForumCategoryBean ORDER BY forumCategoryId ASC";
			Query<ForumCategoryBean> categoryBeans = session.createQuery(hql, ForumCategoryBean.class);
			List<ForumCategoryBean> resultList = categoryBeans.getResultList();
			return new LinkedHashSet<ForumCategoryBean>(resultList);
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return new LinkedHashSet<>();
	}

	public ForumCategoryBean getCategoryById(int forumCategoryId) {
		Session session = sessionFactory.openSession();

		try {
			ForumCategoryBean forumCategoryBean = session.get(ForumCategoryBean.class, forumCategoryId);
			return forumCategoryBean;
		} catch (Exception exception) {
		} finally {
			session.close();
		}
		return null;
	}

}
