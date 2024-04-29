package com.softskillz.companion.model;

import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "learning_companion")
@Component
public class CompanionBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "companion_id")
	private Integer companionId;
	
	@Column(name = "student_id")
	private Integer studentId;
	
	@Column(name = "companion_username")
	private String companionUsername;
	
	@Column(name = "companion_gender")
	private String companionGender;
	
	@Column(name = "companion_birth")
	private String companionBirth;
	
	@Column(name = "companion_first_language")
	private String companionFirstLanguage;
	
	@Column(name = "companion_speaking_language")
	private String companionSpeakingLanguage;
	
	@Column(name = "companion_learning_interest")
	private String companionLearningInterest;
	
	@Column(name = "companion_learning_frequency")
	private String companionLearningFrequency;
	
	@Column(name = "companion_photo")
	private String companionPhoto;

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "companionAId", cascade = CascadeType.ALL)
	private Set<CompanionMatchBean> companionMatchA;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "companionBId", cascade = CascadeType.ALL)
	private Set<CompanionMatchBean> companionMatchB;

	
	public CompanionBean() {
	}
	
	public CompanionBean(Integer companionId, Integer studentId, String companionUsername, String companionGender,
			String companionBirth, String companionFirstLanguage, String companionSpeakingLanguage,
			String companionLearningInterest, String companionLearningFrequency, String companionPhoto) {
		super();
		this.companionId = companionId;
		this.studentId = studentId;
		this.companionUsername = companionUsername;
		this.companionGender = companionGender;
		this.companionBirth = companionBirth;
		this.companionFirstLanguage = companionFirstLanguage;
		this.companionSpeakingLanguage = companionSpeakingLanguage;
		this.companionLearningInterest = companionLearningInterest;
		this.companionLearningFrequency = companionLearningFrequency;
		this.companionPhoto = companionPhoto;
	}



	public Integer getCompanionId() {
		return companionId;
	}

	public void setCompanionId(Integer companionId) {
		this.companionId = companionId;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public String getCompanionUsername() {
		return companionUsername;
	}

	public void setCompanionUsername(String companionUsername) {
		this.companionUsername = companionUsername;
	}

	public String getCompanionGender() {
		return companionGender;
	}

	public void setCompanionGender(String companionGender) {
		this.companionGender = companionGender;
	}

	public String getCompanionBirth() {
		return companionBirth;
	}

	public void setCompanionBirth(String companionBirth) {
		this.companionBirth = companionBirth;
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

	public String getCompanionPhoto() {
		return companionPhoto;
	}

	public void setCompanionPhoto(String companionPhoto) {
		this.companionPhoto = companionPhoto;
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

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CompanionBean [companionId=");
		builder.append(companionId);
		builder.append(", studentId=");
		builder.append(studentId);
		builder.append(", companionUsername=");
		builder.append(companionUsername);
		builder.append(", companionGender=");
		builder.append(companionGender);
		builder.append(", companionBirth=");
		builder.append(companionBirth);
		builder.append(", companionFirstLanguage=");
		builder.append(companionFirstLanguage);
		builder.append(", companionSpeakingLanguage=");
		builder.append(companionSpeakingLanguage);
		builder.append(", companionLearningInterest=");
		builder.append(companionLearningInterest);
		builder.append(", companionLearningFrequency=");
		builder.append(companionLearningFrequency);
		builder.append(", companionPhoto=");
		builder.append(companionPhoto);
		builder.append("]");
		return builder.toString();
	}


}
