package com.softskillz.account.model.bean;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "s_forgotpwd")
@Component
public class StudentNewPwdBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer tokenId;

	@Column(name = "s_id")
	private Integer sId;

	@Column(name = "token")
	private String token;

	@Column(name = "student_registration_date")
	private LocalDateTime studentRegistrationDate;

	public StudentNewPwdBean() {
	}


	public Integer getTokenId() {
		return tokenId;
	}


	public void setTokenId(Integer tokenId) {
		this.tokenId = tokenId;
	}

	public Integer getsId() {
		return sId;
	}

	public void setsId(Integer sId) {
		this.sId = sId;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public LocalDateTime getStudentRegistrationDate() {
		return studentRegistrationDate;
	}

	public void setStudentRegistrationDate(LocalDateTime studentRegistrationDate) {
		this.studentRegistrationDate = studentRegistrationDate;
	}

}
