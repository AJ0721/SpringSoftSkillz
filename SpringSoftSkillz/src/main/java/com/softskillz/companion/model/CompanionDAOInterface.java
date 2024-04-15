package com.softskillz.companion.model;

import java.util.List;


public interface CompanionDAOInterface {
	CompanionBean insert(CompanionBean comBean);

	CompanionBean insertCompanion(Integer companionId, String companionLearningInterest);
	
	CompanionBean selectById(Integer companionId);

	CompanionBean selectByName(String companionUsername);
	
	CompanionBean selectMatchById(Integer companionId);
	
	List<CompanionBean> selectByInterest(String companionInterest, String companionUsername);
	
	List<CompanionBean> selectAll();

	CompanionBean updateOne(CompanionBean comBean);

	boolean deleteOne(Integer companionId);
}
