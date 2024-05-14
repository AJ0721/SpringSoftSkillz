package com.softskillz.courseorder.model.bean;

import java.util.Date;


import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


//@Entity
//@Table(name = "teacher")
//@Component
public class TeacherBean2  {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer teacher_id;
	private String teacher_first_name;
	private String teacher_last_name;
	private Date teacher_registration_date;
	private String teacher_gender;
	private Date teacher_birth;
	private String teacher_mobile;
	private String teacher_email;
	private String teacher_password;
	private String teacher_country;
	private String teacher_photo;
	private String subject;
	private String experience;
	private String status;
	private String teacher_education;
	private String certification;
	private String teachTime;
	private String strength;
	private Integer teacher_forum_status;
	private Integer teacher_course_status;
	private String teacher_id_formatted;
	private Integer user_type;

//	// 可以不要
//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "teacherBean2")
//	private Set<CourseBean2> courseBeans = new HashSet<>();

	public TeacherBean2() {

	}

	public Integer getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(Integer teacher_id) {
		this.teacher_id = teacher_id;
	}

	public String getTeacher_first_name() {
		return teacher_first_name;
	}

	public void setTeacher_first_name(String teacher_first_name) {
		this.teacher_first_name = teacher_first_name;
	}

	public String getTeacher_last_name() {
		return teacher_last_name;
	}

	public void setTeacher_last_name(String teacher_last_name) {
		this.teacher_last_name = teacher_last_name;
	}

	public Date getTeacher_registration_date() {
		return teacher_registration_date;
	}

	public void setTeacher_registration_date(Date teacher_registration_date) {
		this.teacher_registration_date = teacher_registration_date;
	}

	public String getTeacher_gender() {
		return teacher_gender;
	}

	public void setTeacher_gender(String teacher_gender) {
		this.teacher_gender = teacher_gender;
	}

	public Date getTeacher_birth() {
		return teacher_birth;
	}

	public void setTeacher_birth(Date teacher_birth) {
		this.teacher_birth = teacher_birth;
	}

	public String getTeacher_mobile() {
		return teacher_mobile;
	}

	public void setTeacher_mobile(String teacher_mobile) {
		this.teacher_mobile = teacher_mobile;
	}

	public String getTeacher_email() {
		return teacher_email;
	}

	public void setTeacher_email(String teacher_email) {
		this.teacher_email = teacher_email;
	}

	public String getTeacher_password() {
		return teacher_password;
	}

	public void setTeacher_password(String teacher_password) {
		this.teacher_password = teacher_password;
	}

	public String getTeacher_country() {
		return teacher_country;
	}

	public void setTeacher_country(String teacher_country) {
		this.teacher_country = teacher_country;
	}

	public String getTeacher_photo() {
		return teacher_photo;
	}

	public void setTeacher_photo(String teacher_photo) {
		this.teacher_photo = teacher_photo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTeacher_education() {
		return teacher_education;
	}

	public void setTeacher_education(String teacher_education) {
		this.teacher_education = teacher_education;
	}

	public String getCertification() {
		return certification;
	}

	public void setCertification(String certification) {
		this.certification = certification;
	}

	public String getTeachTime() {
		return teachTime;
	}

	public void setTeachTime(String teachTime) {
		this.teachTime = teachTime;
	}

	public String getStrength() {
		return strength;
	}

	public void setStrength(String strength) {
		this.strength = strength;
	}

	public Integer getTeacher_forum_status() {
		return teacher_forum_status;
	}

	public void setTeacher_forum_status(Integer teacher_forum_status) {
		this.teacher_forum_status = teacher_forum_status;
	}

	public Integer getTeacher_course_status() {
		return teacher_course_status;
	}

	public void setTeacher_course_status(Integer teacher_course_status) {
		this.teacher_course_status = teacher_course_status;
	}

	public String getTeacher_id_formatted() {
		return teacher_id_formatted;
	}

	public void setTeacher_id_formatted(String teacher_id_formatted) {
		this.teacher_id_formatted = teacher_id_formatted;
	}

	public Integer getUser_type() {
		return user_type;
	}

	public void setUser_type(Integer user_type) {
		this.user_type = user_type;
	}

//	public Set<CourseBean2> getCourseBeans() {
//		return courseBeans;
//	}
//
//	public void setCourseBeans(Set<CourseBean2> courseBeans) {
//		this.courseBeans = courseBeans;
//	}

	@Override
	public String toString() {
		return "TeacherBean2 [teacher_id=" + teacher_id + ", teacher_first_name=" + teacher_first_name
				+ ", teacher_last_name=" + teacher_last_name + ", teacher_registration_date="
				+ teacher_registration_date + ", teacher_gender=" + teacher_gender + ", teacher_birth=" + teacher_birth
				+ ", teacher_mobile=" + teacher_mobile + ", teacher_email=" + teacher_email + ", teacher_password="
				+ teacher_password + ", teacher_country=" + teacher_country + ", teacher_photo=" + teacher_photo
				+ ", subject=" + subject + ", experience=" + experience + ", status=" + status + ", teacher_education="
				+ teacher_education + ", certification=" + certification + ", teachTime=" + teachTime + ", strength="
				+ strength + ", teacher_forum_status=" + teacher_forum_status + ", teacher_course_status="
				+ teacher_course_status + ", teacher_id_formatted=" + teacher_id_formatted + ", user_type=" + user_type
				+ "]";
	}
	
	
}
