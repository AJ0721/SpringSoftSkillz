package com.softskillz.companion.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CompanionMatchService {
	
	@Autowired
	private CompanionMatchRepository companionMatchRepos;
	
	public CompanionMatchBean insert(CompanionMatchBean companionMatch) {
		return companionMatchRepos.save(companionMatch);
	}
	
	public CompanionMatchBean update(CompanionMatchBean companionMatch) {
		return companionMatchRepos.save(companionMatch);
	}
	
	public CompanionMatchBean getById(Integer id) {
		Optional<CompanionMatchBean> op1 = companionMatchRepos.findById(id);
		
		if(op1.isPresent()) {
			return op1.get();
		}
		
		return null;
	}
	
//	public List<CompanionMatchBean> getByStudentAId(Integer studentAId) {
//		return companionMatchRepos.findByStudentAId(studentAId);
//}
	public List<CompanionMatchBean> getByStudentAId(CompanionBean companionAId) {
		return companionMatchRepos.findByCompanionAId(companionAId);
	}
}
