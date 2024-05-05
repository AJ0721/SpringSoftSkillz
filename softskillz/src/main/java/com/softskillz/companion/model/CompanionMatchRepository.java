package com.softskillz.companion.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanionMatchRepository extends JpaRepository<CompanionMatchBean, Integer> {
//	public List<CompanionMatchBean> findByStudentAId(Integer studentAId);
	public List<CompanionMatchBean> findByCompanionAId(CompanionBean companionAId);
}
