package com.softskillz.companion.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class CompanionService {
	
	@Autowired
	private CompanionRepository companionRepos;
	
	public CompanionBean insert(CompanionBean companionBean) {
		return companionRepos.save(companionBean);
	}
	
	public CompanionBean update(CompanionBean companionBean) {
		return companionRepos.save(companionBean);
	}
	
	public void deleteById(Integer id) {
		companionRepos.deleteById(id);
	}
	
	public CompanionBean getById(Integer id) {
		Optional<CompanionBean> op1 = companionRepos.findById(id);
		
		if(op1.isPresent()) {
			return op1.get();
		}
		
		return null;
	}
	
	public CompanionBean getByName(String companionUsername) {
		Optional<CompanionBean> op1 = companionRepos.findBycompanionUsername(companionUsername);
		
		if(op1.isPresent()) {
			return op1.get();
		}
		
		return null;
	}
	
	public List<CompanionBean> getByInterest(String companionLearningInterest, String companionUsername) {
//		Optional<CompanionBean> op1 = companionRepos.findBycompanionLearningInterest(companionLearningInterest, companionUsername);
		return companionRepos.findByLearningInterestAndUsername(companionLearningInterest, companionUsername);
		
//		if(op1.isPresent()) {
//			return op1.get();
//		}
//		
//		return null;
	}
	
	public List<CompanionBean> getAll() {
		return companionRepos.findAll();
	}

	public Page<CompanionBean> findAllByPage(Pageable pageable){
		return companionRepos.findAll(pageable);
	}
}
