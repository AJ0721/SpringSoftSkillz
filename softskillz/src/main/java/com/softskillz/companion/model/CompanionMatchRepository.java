package com.softskillz.companion.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CompanionMatchRepository extends JpaRepository<CompanionMatchBean, Integer> {
//	public List<CompanionMatchBean> findByStudentAId(Integer studentAId);
	public List<CompanionMatchBean> findByCompanionAId(CompanionBean companionAId);
}
