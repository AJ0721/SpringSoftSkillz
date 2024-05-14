package com.softskillz.companion.model;

import java.util.Date;

import com.softskillz.account.model.bean.StudentBean;

import jakarta.persistence.Column;

public class CompanionDTO {
	private Integer companionId;
	
    private String companionFirstLanguage;
    
	private String companionSpeakingLanguage;
	
	private String companionLearningInterest;
	
	private String companionLearningFrequency;
	
	private String companionAboutMe;
	
	private StudentBean studentBeanID;

    public static CompanionDTO fromCompanionBean(CompanionBean companionBean) {
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
        companionDTO.setStudentPhoto(companionBean.getStudentBeanID().getStudentPhoto());
        return companionDTO;
    }
	
	public Integer getCompanionId() {
		return companionId;
	}

	public void setCompanionId(Integer companionId) {
		this.companionId = companionId;
	}

	public String getCompanionFirstLanguage() {
		return companionFirstLanguage;
	}

	public void setCompanionFirstLanguage(String companionFirstLanguage) {
		this.companionFirstLanguage = companionFirstLanguage;
	}

	public String getCompanionSpeakingLanguage() {
		return companionSpeakingLanguage;
	}

	public void setCompanionSpeakingLanguage(String companionSpeakingLanguage) {
		this.companionSpeakingLanguage = companionSpeakingLanguage;
	}

	public String getCompanionLearningInterest() {
		return companionLearningInterest;
	}

	public void setCompanionLearningInterest(String companionLearningInterest) {
		this.companionLearningInterest = companionLearningInterest;
	}

	public String getCompanionLearningFrequency() {
		return companionLearningFrequency;
	}

	public void setCompanionLearningFrequency(String companionLearningFrequency) {
		this.companionLearningFrequency = companionLearningFrequency;
	}

	public String getCompanionAboutMe() {
		return companionAboutMe;
	}

	public void setCompanionAboutMe(String companionAboutMe) {
		this.companionAboutMe = companionAboutMe;
	}


	public StudentBean getStudentBean() {
		return studentBeanID;
	}

	public void setStudentBean(StudentBean studentBean) {
		this.studentBeanID = studentBean;
	}
	
	public Integer getStudentId() {
        return studentBeanID != null ? studentBeanID.getStudentId() : null;
    }

    public void setStudentId(Integer studentId) {
        if (studentBeanID == null) {
            studentBeanID = new StudentBean();
        }
        studentBeanID.setStudentId(studentId);
    }

    public String getStudentNickname() {
        return studentBeanID != null ? studentBeanID.getStudentNickname() : null;
    }

    public void setStudentNickname(String studentNickname) {
        if (studentBeanID == null) {
            studentBeanID = new StudentBean();
        }
        studentBeanID.setStudentNickname(studentNickname);
    }

    public String getStudentGender() {
        return studentBeanID != null ? studentBeanID.getStudentGender() : null;
    }

    public void setStudentGender(String studentGender) {
        if (studentBeanID == null) {
            studentBeanID = new StudentBean();
        }
        studentBeanID.setStudentGender(studentGender);
    }

    public Date getStudentBirth() {
        return studentBeanID != null ? studentBeanID.getStudentBirth() : null;
    }

    public void setStudentBirth(Date studentBirth) {
        if (studentBeanID == null) {
            studentBeanID = new StudentBean();
        }
        studentBeanID.setStudentBirth(studentBirth);
    }

    public String getStudentPhoto() {
        return studentBeanID != null ? studentBeanID.getStudentPhoto() : null;
    }

    public void setStudentPhoto(String studentPhoto) {
        if (studentBeanID == null) {
            studentBeanID = new StudentBean();
        }
        studentBeanID.setStudentPhoto(studentPhoto);
    }
	
}
