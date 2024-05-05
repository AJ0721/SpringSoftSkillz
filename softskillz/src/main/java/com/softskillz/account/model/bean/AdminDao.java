package com.softskillz.account.model.bean;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class AdminDao {

	@Autowired
	private SessionFactory factory;

	// 新增
	public AdminBean insert(AdminBean adminBean) {
		Session session = factory.openSession();

		if (adminBean != null) {
			session.persist(adminBean);
			session.flush();
		}
		session.close();
		return adminBean;
	}

//	public AdminBean update(AdminBean adminBean) {
//		Session session = factory.openSession();
//
//		if (adminBean != null) {
//			session.merge(adminBean);
//			session.flush();
//		}
//		session.close();
//		return adminBean;
//	}

	public AdminBean update(Integer id, Integer level) {
		Session session = factory.openSession();
		// session去資料庫拿id
		AdminBean resultBean = session.get(AdminBean.class, id);

		// resultBean != null就是可以更新
		if (resultBean != null) {
			resultBean.setAdminLevel(level);
			// session.merge(resultBean);
			session.flush();
		}
		session.close();
		return resultBean;
	}

	// 登入查詢帳號密碼
	public boolean checkLogin(AdminBean adminBean) {
		Session session = factory.openSession();
		String hqlstr = "from AdminBean where adminAccount=:user and adminPassword=:pwd";
		Query<AdminBean> query = session.createQuery(hqlstr, AdminBean.class);
		session.createQuery(hqlstr, AdminBean.class);
		query.setParameter("user", adminBean.getAdminAccount());
		query.setParameter("pwd", adminBean.getAdminPassword());
		AdminBean resultBean = query.uniqueResult();

		session.close();

		if (resultBean != null) {
			return true;
		}
		return false;
	}

	// 查詢單筆
	public AdminBean findById(Integer id) {
		Session session = factory.openSession();
		AdminBean resultBean = session.get(AdminBean.class, id);
		session.close();
		return resultBean;
	}

	// 查詢
	public List<AdminBean> findAll() {
		Session session = factory.openSession();
		String hqlstr = "from AdminBean";
		Query<AdminBean> query = session.createQuery(hqlstr, AdminBean.class);
		List<AdminBean> lists = query.list();
		session.close();
		return lists;
	}

	public boolean deleteById(Integer adminId) {
		Session session = factory.openSession();
		AdminBean resultBean = session.get(AdminBean.class, adminId);

		if (resultBean != null) {
			session.remove(resultBean);
			session.flush();
			session.close();
			return true;
		}
		session.close();
		return false;
	}

}
