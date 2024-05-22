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
	
	public CompanionBean getByStudentNickname(String studentNickname) {
		Optional<CompanionBean> op1 = companionRepos.findBystudentNickname(studentNickname);
		
		if(op1.isPresent()) {
			return op1.get();
		}
		
		return null;
	}
	
	public List<CompanionBean> getByMatchRequirement(
			String companionLearningInterest,
			String companionGender,
			String companionFirstLanguage,
			String companionSpeakingLanguage,
			String companionLearningFrequency,
			String companionUsername) {
		
		return companionRepos.findByMatchRequirement(
			companionLearningInterest,
			companionGender,
			companionFirstLanguage,
			companionSpeakingLanguage,
			companionLearningFrequency,
			companionUsername);
	}
	
	public List<CompanionBean> getAll() {
		return companionRepos.findAll();
	}

//	public Page<CompanionBean> findAllByPage(Pageable pageable){
//		return companionRepos.findAll(pageable);
//	}
	
	public Page<CompanionDTO> findAllByPage(Pageable pageable) {
	    Page<CompanionBean> companionPage = companionRepos.findAll(pageable);
	    return companionPage.map(this::mapToDTO);
	}

    private CompanionDTO mapToDTO(CompanionBean companionBean) {
        CompanionDTO companionDTO = new CompanionDTO();
        companionDTO.setCompanionId(companionBean.getCompanionId());
        companionDTO.setCompanionFirstLanguage(companionBean.getCompanionFirstLanguage());
        companionDTO.setCompanionSpeakingLanguage(companionBean.getCompanionSpeakingLanguage());
        companionDTO.setCompanionLearningInterest(companionBean.getCompanionLearningInterest());
        companionDTO.setCompanionLearningFrequency(companionBean.getCompanionLearningFrequency());
        companionDTO.setCompanionAboutMe(companionBean.getCompanionAboutMe());
        // 如果有其他需要映射的屬性，可以在這裡添加
        companionDTO.setStudentId(companionBean.getStudentBeanID().getStudentId());
        companionDTO.setStudentNickname(companionBean.getStudentBeanID().getStudentNickname());
        companionDTO.setStudentGender(companionBean.getStudentBeanID().getStudentGender());
        companionDTO.setStudentBirth(companionBean.getStudentBeanID().getStudentBirth());
        companionDTO.setCompanionPhoto(companionBean.getCompanionPhoto());
        return companionDTO;
    }
}
