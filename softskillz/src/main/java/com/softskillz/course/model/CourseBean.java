package com.softskillz.course.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.studentreservation.model.StudentReservationBean;

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
@Table(name = "course")
@Component
public class CourseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "course_id")
	private Integer courseID;

	@Column(name = "teacher_id")
	private Integer teacherID;

	@Column(name = "course_name")
	private String courseName;

	@Column(name = "course_info")
	private String courseInfo;

	@Column(name = "course_category")
	private String courseCategory;

	@Column(name = "course_price")
	private Integer coursePrice;

	@JoinColumn(name = "teacher_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	@JsonBackReference("course-teacher")
	private TeacherBean teacherBean;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseBean", cascade = CascadeType.ALL)
	@JsonManagedReference("course-studentReservation")
	private Set<StudentReservationBean> studentReservationBean = new HashSet<StudentReservationBean>();

	public CourseBean() {
	}

	public CourseBean(Integer courseID, Integer teacherID, String courseName, String courseInfo, String courseCategory,
			Integer coursePrice) {
		super();
		this.courseID = courseID;
		this.teacherID = teacherID;
		this.courseName = courseName;
		this.courseInfo = courseInfo;
		this.courseCategory = courseCategory;
		this.coursePrice = coursePrice;
	}

	public CourseBean(Integer teacherID, String courseName, String courseInfo, String courseCategory,
			Integer coursePrice) {
		super();
		this.teacherID = teacherID;
		this.courseName = courseName;
		this.courseInfo = courseInfo;
		this.courseCategory = courseCategory;
		this.coursePrice = coursePrice;
	}

	public Integer getCourseID() {
		return courseID;
	}

	public void setCourseID(Integer courseID) {
		this.courseID = courseID;
	}

	public Integer getTeacherID() {
		return teacherID;
	}

	public void setTeacherID(Integer teacherID) {
		this.teacherID = teacherID;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseInfo() {
		return courseInfo;
	}

	public void setCourseInfo(String courseInfo) {
		this.courseInfo = courseInfo;
	}

	public String getCourseCategory() {
		return courseCategory;
	}

	public void setCourseCategory(String courseCategory) {
		this.courseCategory = courseCategory;
	}

	public Integer getCoursePrice() {
		return coursePrice;
	}

	public void setCoursePrice(Integer coursePrice) {
		this.coursePrice = coursePrice;
	}

	public TeacherBean getTeacherBean() {
		return teacherBean;
	}

	public void setTeacherBean(TeacherBean teacherBean) {
		this.teacherBean = teacherBean;
	}

}