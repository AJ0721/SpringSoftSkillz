package com.softskillz.companion.model;

import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.softskillz.account.model.bean.StudentBean;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "learning_companion")
@Component
public class CompanionBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "companion_id")
	private Integer companionId;
	
//	@Column(name = "student_id")
//	private Integer studentId;
	
	@Column(name = "companion_first_language")
	private String companionFirstLanguage;
	
	@Column(name = "companion_speaking_language")
	private String companionSpeakingLanguage;
	
	@Column(name = "companion_learning_interest")
	private String companionLearningInterest;
	
	@Column(name = "companion_learning_frequency")
	private String companionLearningFrequency;
	
	@Column(name = "companion_about_me")
	private String companionAboutMe;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "companionAId", cascade = CascadeType.ALL)
	private Set<CompanionMatchBean> companionMatchA;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "companionBId", cascade = CascadeType.ALL)
	private Set<CompanionMatchBean> companionMatchB;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "student_id")
	private StudentBean studentBeanID;
	
	public CompanionBean() {
	}

	public CompanionBean(Integer companionId, String companionFirstLanguage, String companionSpeakingLanguage,
			String companionLearningInterest, String companionLearningFrequency, String companionAboutMe,
			Set<CompanionMatchBean> companionMatchA, Set<CompanionMatchBean> companionMatchB,
			StudentBean studentBeanID) {
		super();
		this.companionId = companionId;
		this.companionFirstLanguage = companionFirstLanguage;
		this.companionSpeakingLanguage = companionSpeakingLanguage;
		this.companionLearningInterest = companionLearningInterest;
		this.companionLearningFrequency = companionLearningFrequency;
		this.companionAboutMe = companionAboutMe;
		this.companionMatchA = companionMatchA;
		this.companionMatchB = companionMatchB;
		this.studentBeanID = studentBeanID;
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

	public Set<CompanionMatchBean> getCompanionMatchA() {
		return companionMatchA;
	}

	public void setCompanionMatchA(Set<CompanionMatchBean> companionMatchA) {
		this.companionMatchA = companionMatchA;
	}

	public Set<CompanionMatchBean> getCompanionMatchB() {
		return companionMatchB;
	}

	public void setCompanionMatchB(Set<CompanionMatchBean> companionMatchB) {
		this.companionMatchB = companionMatchB;
	}

	public StudentBean getStudentBeanID() {
		return studentBeanID;
	}

	public void setStudentBeanID(StudentBean studentBeanID) {
		this.studentBeanID = studentBeanID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CompanionBean [companionId=");
		builder.append(companionId);
		builder.append(", companionFirstLanguage=");
		builder.append(companionFirstLanguage);
		builder.append(", companionSpeakingLanguage=");
		builder.append(companionSpeakingLanguage);
		builder.append(", companionLearningInterest=");
		builder.append(companionLearningInterest);
		builder.append(", companionLearningFrequency=");
		builder.append(companionLearningFrequency);
		builder.append(", companionAboutMe=");
		builder.append(companionAboutMe);
		builder.append(", companionMatchA=");
		builder.append(companionMatchA);
		builder.append(", companionMatchB=");
		builder.append(companionMatchB);
		builder.append(", studentBeanID=");
		builder.append(studentBeanID);
		builder.append("]");
		return builder.toString();
	}

}
