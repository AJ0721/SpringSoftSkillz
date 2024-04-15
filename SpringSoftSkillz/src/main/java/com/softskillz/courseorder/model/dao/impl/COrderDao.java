package com.softskillz.courseorder.model.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.MutationQuery;
import org.hibernate.query.Query;
import org.hibernate.query.SelectionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.dao.OrderDaoInterface;

@Repository
@Transactional
public class COrderDao implements OrderDaoInterface {

	@Autowired
	private SessionFactory factory;

	@Override
	public void insertORD(CorderBean orderBean) {
		Session session = factory.openSession();
		session.persist(orderBean);
		session.flush();
		session.close();
	}

	@Override
	public void deleteORD(String orderID) {
		Session session = factory.openSession();
		String hql = " FROM CorderBean o WHERE o.orderID = :oid";
		Query<CorderBean> query = session.createQuery(hql, CorderBean.class).setParameter("oid", orderID);
		CorderBean order = query.getSingleResult();
		session.remove(order);
		session.flush();
		session.close();
	}

	@Override
	public void cancelORD(String orderID, String status) {
		Session session = factory.openSession();
		String sql = "UPDATE corder SET order_status = :ss WHERE order_id = :oid";//sql 原生子句
		session.createNativeQuery(sql, CorderBean.class).setParameter("ss", status).setParameter("oid", orderID).executeUpdate();
		session.close();
	}

	@Override
	public List<CorderBean> selsctUserAllORD(Integer studentID) {
		Session session = factory.openSession();
		String hql = "from CorderBean o where o.studentID = :sid";
		Query<CorderBean> query = session.createQuery(hql, CorderBean.class).setParameter("sid", studentID);
		List<CorderBean> resultList = query.getResultList();
		session.close();

		return resultList;

	}

	@Override
	public List<CorderBean> adminSelectAll() {

		Session session = factory.openSession();
		String hql = "from CorderBean ";
		List<CorderBean> resultList = session.createQuery(hql, CorderBean.class).getResultList();
		session.close();

		return resultList;
	}

	@Override
	public List<CorderBean> adminSelectByDate(Date date1, Date date2) {

		Session session = factory.openSession();
		String hql = "from CorderBean o where o.orderDate >= :date1 AND o.orderDate < :date2";
		List<CorderBean> resultList = session.createQuery(hql, CorderBean.class).setParameter("date1", date1)
				.setParameter("date2", date2).getResultList();
		session.close();

		return resultList;
	}

	@Override
	public CorderBean selectORD(String orderID) {

		String hql = "from CorderBean o where o.orderID = :oid";
		Session session = factory.openSession();
		Query<CorderBean> query = session.createQuery(hql, CorderBean.class).setParameter("oid", orderID);
		CorderBean order = query.uniqueResult();
		session.close();
		return order;
	}
	
	@Override
	public CorderBean selectORDitem(String orderID) {
		String hql = "from CorderBean o LEFT JOIN FETCH o.orderItem oi LEFT JOIN FETCH oi.courseBean c LEFT JOIN FETCH c.teacherBean where o.orderID = :oid";
		Session session = factory.openSession();
		Query<CorderBean> query = session.createQuery(hql, CorderBean.class).setParameter("oid", orderID);
		CorderBean order = query.uniqueResult();
		System.out.println(order);
		session.close();
		return order;
	}
}
