package com.softskillz.courseorder.model.bean;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


//@Entity
//@Table(name = "student")
public class Student implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer student_id;
	private String student_first_name;
	private String student_last_name;
	private String student_username;
	private String student_nickname;
	private Date student_registration_date;
	private String student_gender;
	private Date student_birth;
	private String student_mobile;
	private String student_email;
	private String student_password;
	private String student_country;
	private String student_photo;
	private String student_education;
	private Integer student_forum_status;
	private Integer student_course_status;
	private String first_language;
	private String learning_frequency;
	private Integer user_type;

	public Student() {
	}

	public Integer getStudent_id() {
		return student_id;
	}

	public void setStudent_id(Integer student_id) {
		this.student_id = student_id;
	}

	public String getStudent_first_name() {
		return student_first_name;
	}

	public void setStudent_first_name(String student_first_name) {
		this.student_first_name = student_first_name;
	}

	public String getStudent_last_name() {
		return student_last_name;
	}

	public void setStudent_last_name(String student_last_name) {
		this.student_last_name = student_last_name;
	}

	public String getStudent_username() {
		return student_username;
	}

	public void setStudent_username(String student_username) {
		this.student_username = student_username;
	}

	public String getStudent_nickname() {
		return student_nickname;
	}

	public void setStudent_nickname(String student_nickname) {
		this.student_nickname = student_nickname;
	}

	public Date getStudent_registration_date() {
		return student_registration_date;
	}

	public void setStudent_registration_date(Date student_registration_date) {
		this.student_registration_date = student_registration_date;
	}

	public String getStudent_gender() {
		return student_gender;
	}

	public void setStudent_gender(String student_gender) {
		this.student_gender = student_gender;
	}

	public Date getStudent_birth() {
		return student_birth;
	}

	public void setStudent_birth(Date student_birth) {
		this.student_birth = student_birth;
	}

	public String getStudent_mobile() {
		return student_mobile;
	}

	public void setStudent_mobile(String student_mobile) {
		this.student_mobile = student_mobile;
	}

	public String getStudent_email() {
		return student_email;
	}

	public void setStudent_email(String student_email) {
		this.student_email = student_email;
	}

	public String getStudent_password() {
		return student_password;
	}

	public void setStudent_password(String student_password) {
		this.student_password = student_password;
	}

	public String getStudent_country() {
		return student_country;
	}

	public void setStudent_country(String student_country) {
		this.student_country = student_country;
	}

	public String getStudent_photo() {
		return student_photo;
	}

	public void setStudent_photo(String student_photo) {
		this.student_photo = student_photo;
	}

	public String getStudent_education() {
		return student_education;
	}

	public void setStudent_education(String student_education) {
		this.student_education = student_education;
	}

	public Integer getStudent_forum_status() {
		return student_forum_status;
	}

	public void setStudent_forum_status(Integer student_forum_status) {
		this.student_forum_status = student_forum_status;
	}

	public Integer getStudent_course_status() {
		return student_course_status;
	}

	public void setStudent_course_status(Integer student_course_status) {
		this.student_course_status = student_course_status;
	}

	public String getFirst_language() {
		return first_language;
	}

	public void setFirst_language(String first_language) {
		this.first_language = first_language;
	}

	public String getLearning_frequency() {
		return learning_frequency;
	}

	public void setLearning_frequency(String learning_frequency) {
		this.learning_frequency = learning_frequency;
	}

	public Integer getUser_type() {
		return user_type;
	}

	public void setUser_type(Integer user_type) {
		this.user_type = user_type;
	}

}