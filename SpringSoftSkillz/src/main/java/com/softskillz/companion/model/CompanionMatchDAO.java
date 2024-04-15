package com.softskillz.companion.model;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.persistence.NoResultException;
import jakarta.transaction.Transactional;

@Repository
@Transactional
public class CompanionMatchDAO{

	@Autowired
	private SessionFactory factory;

	// 查詢單筆 利用編號
	public CompanionMatchBean selectById(Integer studentAId) {
//		CompanyBean companyBean = session.get(CompanyBean.class, id);
//		return companyBean;
		Session session = factory.openSession();
		
		String hql = "from CompanionMatchBean cm where cm.studentAId =:id";
		
		try {
			Query<CompanionMatchBean> query = session.createQuery(hql, CompanionMatchBean.class)
					.setParameter("id", studentAId);
			
			CompanionMatchBean result = query.getSingleResult();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}

}
