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
public class CompanionDAO implements CompanionDAOInterface {

	@Autowired
	private SessionFactory factory;
	
	// 新增
	@Override
	public CompanionBean insert(CompanionBean comBean) {
		Session session = factory.openSession();
//		String hql = "from CompanionBean c where c.studentId =:sid";

		try {
//			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class).setParameter("sid", comBean.getStudentId());

//			CompanionBean result = query.getSingleResult();
//			System.out.println(result);
			// 這裡的result如果是null，會丟出NoResultException，但hibernate的似乎不會?
//			if (result == null) {
				session.persist(comBean);
				session.flush();
				session.close();
				return comBean;
//			回傳給Demo的result，讓Demo來判斷資料有沒有進去
				
//			} else {
//		下面是else的概念
//				return null;
//			}
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}
//		                                                               這個方法只能抓資料表中PK的值
//		                                                               要查其他的都只能用query去抓
//		CompanionBean companionBean = session.get(CompanionBean.class, comBean.getStudentId());
	
	// 新增
	@Override
	public CompanionBean insertCompanion(Integer companionId, String companionLearningInterest) {
		Session session = factory.openSession();
		
		String hql = "from CompanionBean c where c.companionId !=:id and c.companionLearningInterest =:interest";
		
		try {
			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class)
					.setParameter("id", companionId)
					.setParameter("interest", companionLearningInterest);
			CompanionBean result = query.getSingleResult();
			
			CompanionMatchBean companionMatch = new CompanionMatchBean();
			companionMatch.setStudentAId(result.getCompanionId());
			companionMatch.setStudentBId(companionId);
			System.out.println(companionId);
			System.out.println(result.getCompanionId());
			
			session.merge(companionMatch);
			session.flush();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}
	
	// 查詢單筆 利用編號
	@Override
	public CompanionBean selectById(Integer companionId) {
//		CompanyBean companyBean = session.get(CompanyBean.class, id);
//		return companyBean;
		Session session = factory.openSession();
		
		String hql = "from CompanionBean c where c.companionId =:id";
		
		try {
			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class)
					.setParameter("id", companionId);
			
			CompanionBean result = query.getSingleResult();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}

	// 查詢單筆 利用姓名
	@Override
	public CompanionBean selectByName(String companionUsername) {
//		CompanyBean companyBean = session.get(CompanyBean.class, id);
//		return companyBean;
		Session session = factory.openSession();
		
		String hql = "from CompanionBean c where c.companionUsername =:name";
		
		try {
			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class)
					.setParameter("name", companionUsername);
			
			CompanionBean result = query.getSingleResult();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}
	
	// 查詢單筆 利用姓名
	@Override
	public CompanionBean selectMatchById(Integer companionId) {
//		CompanyBean companyBean = session.get(CompanyBean.class, id);
//		return companyBean;
		Session session = factory.openSession();
		
		String hql = "from CompanionMatchBean c where c.companionAId =:id";
		
		try {
			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class)
					.setParameter("id", companionId);
			
			CompanionBean result = query.getSingleResult();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}
	
	// 查詢單筆 利用興趣
	@Override
	public List<CompanionBean> selectByInterest(String companionInterest, String companionUsername) {
		Session session = factory.openSession();
		
		String hql = "from CompanionBean c where c.companionLearningInterest =:interest and c.companionUsername !=:name";
		
		try {
			Query<CompanionBean> query = session.createQuery(hql, CompanionBean.class)
					.setParameter("interest", companionInterest)
					.setParameter("name", companionUsername);
			List<CompanionBean> result = query.getResultList();
			session.close();

			return result;
			
		} catch (NoResultException e) {
			System.out.println(e);
			return null;
		}
	}
	
	@Override
	public List<CompanionBean> selectAll() {
		Session session = factory.openSession();
		Query<CompanionBean> query = session.createQuery("from CompanionBean", CompanionBean.class);
//我們在操作的是Entity 非table 講義ppt 143
		List<CompanionBean> result = query.getResultList();
		return result;
	}

	@Override
	public CompanionBean updateOne(CompanionBean comBean) {
		
		Session session = factory.openSession();
		CompanionBean companionBean = session.get(CompanionBean.class, comBean.getCompanionId());
		try {
			if (companionBean != null) {
				companionBean.setCompanionId(comBean.getCompanionId());
				companionBean.setStudentId(comBean.getStudentId());
				companionBean.setCompanionUsername(comBean.getCompanionUsername());
				companionBean.setCompanionGender(comBean.getCompanionGender());
				companionBean.setCompanionBirth(comBean.getCompanionBirth());
				companionBean.setCompanionFirstLanguage(comBean.getCompanionFirstLanguage());
				companionBean.setCompanionSpeakingLanguage(comBean.getCompanionSpeakingLanguage());
				companionBean.setCompanionLearningInterest(comBean.getCompanionLearningInterest());
				companionBean.setCompanionLearningFrequency(comBean.getCompanionLearningFrequency());
				companionBean.setCompanionPhoto(comBean.getCompanionPhoto());
				session.merge(companionBean);
				session.flush();
				session.close();

				return companionBean;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public boolean deleteOne(Integer companionId) {
		
		Session session = factory.openSession();
//        session.beginTransaction();
		CompanionBean companyBean = session.get(CompanionBean.class, companionId);
		if(companyBean != null) {
			session.remove(companyBean);
//            session.getTransaction().commit();
			session.flush();
			session.close();

			return true;
		}
//		factory.getCurrentSession().getTransaction().rollback();

		return false;
	}

}
