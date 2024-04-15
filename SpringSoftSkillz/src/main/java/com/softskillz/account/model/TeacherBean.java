package com.softskillz.account.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.softskillz.forum.model.ForumPostBean;
import com.softskillz.forum.model.ForumThreadBean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "teacher")
@Component
public class TeacherBean implements Serializable {

	private static final long serialVersionUID = 1L;

	public TeacherBean() {

	}

	// 有id
	public TeacherBean(Integer teacherId, String teacherFirstName, String teacherLastName, String teacherUserName,
			Date teacherRegistrationDate, String teacherGender, Date teacherBirth, String teacherMobile,
			String teacherEmail, String teacherPassword, String teacherCountry, String subject, String experience,
			String status, String teacherEducation, String certification, String teachTime, String strength,
			Integer teacherForumStatus, Integer teacherCourseStatus
			, String teacherIdFormatted
			) {
		this.teacherId = teacherId;
		this.teacherFirstName = teacherFirstName;
		this.teacherLastName = teacherLastName;
		this.teacherUserName = teacherUserName;
		this.teacherRegistrationDate = teacherRegistrationDate;
		this.teacherGender = teacherGender;
		this.teacherBirth = teacherBirth;
		this.teacherMobile = teacherMobile;
		this.teacherEmail = teacherEmail;
		this.teacherPassword = teacherPassword;
		this.teacherCountry = teacherCountry;
		this.subject = subject;
		this.experience = experience;
		this.status = status;
		this.teacherEducation = teacherEducation;
		this.certification = certification;
		this.teachTime = teachTime;
		this.strength = strength;
		this.teacherForumStatus = teacherForumStatus;
		this.teacherCourseStatus = teacherCourseStatus;
		this.teacherIdFormatted = teacherIdFormatted;
	}

	// 沒有id
	public TeacherBean(String teacherFirstName, String teacherLastName, String teacherUserName,
			Date teacherRegistrationDate, String teacherGender, Date teacherBirth, String teacherMobile,
			String teacherEmail, String teacherPassword, String teacherCountry, String subject, String experience,
			String status, String teacherEducation, String certification, String teachTime, String strength,
			Integer teacherForumStatus, Integer teacherCourseStatus
			, String teacherIdFormatted
			) {
		this.teacherFirstName = teacherFirstName;
		this.teacherLastName = teacherLastName;
		this.teacherUserName = teacherUserName;
		this.teacherRegistrationDate = teacherRegistrationDate;
		this.teacherGender = teacherGender;
		this.teacherBirth = teacherBirth;
		this.teacherMobile = teacherMobile;
		this.teacherEmail = teacherEmail;
		this.teacherPassword = teacherPassword;
		this.teacherCountry = teacherCountry;
		this.subject = subject;
		this.experience = experience;
		this.status = status;
		this.teacherEducation = teacherEducation;
		this.certification = certification;
		this.teachTime = teachTime;
		this.strength = strength;
		this.teacherForumStatus = teacherForumStatus;
		this.teacherCourseStatus = teacherCourseStatus;
		this.teacherIdFormatted = teacherIdFormatted;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "teacher_id")
	private Integer teacherId;

	// 任萱forum
	@OneToMany(mappedBy = "teacherBean")
	private Set<ForumThreadBean> threads = new LinkedHashSet<>();

	@OneToMany(mappedBy = "teacherBean")
	private List<ForumPostBean> posts = new ArrayList<>();

	@Column(name = "teacher_first_name")
	private String teacherFirstName;

	@Column(name = "teacher_last_name")
	private String teacherLastName;

	@Column(name = "teacher_username")
	private String teacherUserName;

	@Column(name = "teacher_registration_date")
	private Date teacherRegistrationDate;

	@Column(name = "teacher_gender")
	private String teacherGender;

	@Column(name = "teacher_birth")
	private Date teacherBirth;

	@Column(name = "teacher_mobile")
	private String teacherMobile;

	@Column(name = "teacher_email")
	private String teacherEmail;

	@Column(name = "teacher_password")
	private String teacherPassword;

	@Column(name = "teacher_country")
	private String teacherCountry;

	@Column(name = "subject")
	private String subject;

	@Column(name = "experience")
	private String experience;

	@Column(name = "status")
	private String status;

	@Column(name = "teacher_education")
	private String teacherEducation;

	@Column(name = "certification")
	private String certification;

	@Column(name = "teach_time")
	private String teachTime;

	@Column(name = "strength")
	private String strength;

	@Column(name = "teacher_forum_status")
	private Integer teacherForumStatus;

	@Column(name = "teacher_course_status")
	private Integer teacherCourseStatus;

	@Column(name = "teacher_id_formatted")
	private String teacherIdFormatted;
	
	@Column(name = "teacher_photo")
	private String teacherPhoto;
	
	public String getTeacherPhoto() {
		return teacherPhoto;
	}

	public void setTeacherPhoto(String teacherPhoto) {
		this.teacherPhoto = teacherPhoto;
	}

	// 任萱forum getter/setter
	

	public List<ForumPostBean> getPosts() {
		return posts;
	}

	public Set<ForumThreadBean> getThreads() {
		return threads;
	}

	public void setThreads(Set<ForumThreadBean> threads) {
		this.threads = threads;
	}

	public void setPosts(List<ForumPostBean> posts) {
		this.posts = posts;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherFirstName() {
		return teacherFirstName;
	}

	public void setTeacherFirstName(String teacherFirstName) {
		this.teacherFirstName = teacherFirstName;
	}

	public String getTeacherLastName() {
		return teacherLastName;
	}

	public void setTeacherLastName(String teacherLastName) {
		this.teacherLastName = teacherLastName;
	}

	public String getTeacherUserName() {
		return teacherUserName;
	}

	public void setTeacherUserName(String teacherUserName) {
		this.teacherUserName = teacherUserName;
	}

	public Date getTeacherRegistrationDate() {
		return teacherRegistrationDate;
	}

	public void setTeacherRegistrationDate(Date teacherRegistrationDate) {
		this.teacherRegistrationDate = teacherRegistrationDate;
	}

	public String getTeacherGender() {
		return teacherGender;
	}

	public void setTeacherGender(String teacherGender) {
		this.teacherGender = teacherGender;
	}

	public Date getTeacherBirth() {
		return teacherBirth;
	}

	public void setTeacherBirth(Date teacherBirth) {
		this.teacherBirth = teacherBirth;
	}

	public String getTeacherMobile() {
		return teacherMobile;
	}

	public void setTeacherMobile(String teacherMobile) {
		this.teacherMobile = teacherMobile;
	}

	public String getTeacherEmail() {
		return teacherEmail;
	}

	public void setTeacherEmail(String teacherEmail) {
		this.teacherEmail = teacherEmail;
	}

	public String getTeacherPassword() {
		return teacherPassword;
	}

	public void setTeacherPassword(String teacherPassword) {
		this.teacherPassword = teacherPassword;
	}

	public String getTeacherCountry() {
		return teacherCountry;
	}

	public void setTeacherCountry(String teacherCountry) {
		this.teacherCountry = teacherCountry;
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

	public String getTeacherEducation() {
		return teacherEducation;
	}

	public void setTeacherEducation(String teacherEducation) {
		this.teacherEducation = teacherEducation;
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

	public Integer getTeacherForumStatus() {
		return teacherForumStatus;
	}

	public void setTeacherForumStatus(Integer teacherForumStatus) {
		this.teacherForumStatus = teacherForumStatus;
	}

	public Integer getTeacherCourseStatus() {
		return teacherCourseStatus;
	}

	public void setTeacherCourseStatus(Integer teacherCourseStatus) {
		this.teacherCourseStatus = teacherCourseStatus;
	}

	public String getTeacherIdFormatted() {
		return teacherIdFormatted;
	}

	public void setTeacherIdFormatted(String teacherIdFormatted) {
		this.teacherIdFormatted = teacherIdFormatted;
	}
}