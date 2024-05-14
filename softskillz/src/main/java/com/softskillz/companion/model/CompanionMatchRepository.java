package com.softskillz.companion.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CompanionMatchRepository extends JpaRepository<CompanionMatchBean, Integer> {
//	public List<CompanionMatchBean> findByStudentAId(Integer studentAId);
	public List<CompanionMatchBean> findByCompanionAId(CompanionBean companionAId);
	
	@Query("SELECT cm FROM CompanionMatchBean cm JOIN cm.companionAId c JOIN c.studentBeanID s WHERE s.studentNickname = :nickname")
	public List<CompanionMatchBean> findByMatchRequest(@Param("nickname") String studentNickname);
	
	@Query("SELECT companionBId FROM CompanionMatchBean cm JOIN cm.companionAId c JOIN c.studentBeanID s WHERE cm.matchRequest IS NOT NULL AND s.studentNickname = :nickname ")
	List<CompanionBean> findByIHaveMetCompanion(@Param("nickname") String studentNickname);
}
