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
@Table(name = "t_forgotpwd")
@Component
public class TeacherNewPwdBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer tokenId;

	@Column(name = "t_id")
	private Integer tId;

	@Column(name = "token")
	private String token;

	@Column(name = "teacher_registration_date")
	private LocalDateTime teacherRegistrationDate;

	public TeacherNewPwdBean() {
	}

	public TeacherNewPwdBean(Integer tId, String token, LocalDateTime teacherRegistrationDate) {
		this.tId = tId;
		this.token = token;
		this.teacherRegistrationDate = teacherRegistrationDate;
	}
	
	public Integer getTokenId() {
		return tokenId;
	}

	public void setTokenId(Integer tokenId) {
		this.tokenId = tokenId;
	}

	public Integer gettId() {
		return tId;
	}

	public void settId(Integer tId) {
		this.tId = tId;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public LocalDateTime getTeacherRegistrationDate() {
		return teacherRegistrationDate;
	}

	public void setTeacherRegistrationDate(LocalDateTime teacherRegistrationDate) {
		this.teacherRegistrationDate = teacherRegistrationDate;
	}
	
}
