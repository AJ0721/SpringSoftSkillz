package com.softskillz.course.model;

import java.io.Serializable;

/**
 * CourseDTO is a data transfer object used to transfer data between layers
 * without exposing entity models directly.
 */
public class CourseDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer courseID;
	private Integer teacherID;
	private String courseName;
	private String courseInfo;
	private String courseCategory;
	private Integer coursePrice;
	private String teacherUserName; // Assume you want to display the teacher's name with the course

	// Constructors
	public CourseDTO() {
	}

	public CourseDTO(Integer courseID, Integer teacherID, String courseName, String courseInfo, String courseCategory,
			Integer coursePrice, String teacherUserName) {
		this.courseID = courseID;
		this.teacherID = teacherID;
		this.courseName = courseName;
		this.courseInfo = courseInfo;
		this.courseCategory = courseCategory;
		this.coursePrice = coursePrice;
		this.teacherUserName = teacherUserName;
	}

	// Getters and Setters
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

	public String getTeacherUserName() {
		return teacherUserName;
	}

	public void setTeacherUserName(String teacherUserName) {
		this.teacherUserName = teacherUserName;
	}

	// Additional methods can be added as necessary, such as toString(), equals(),
	// hashCode(), etc.
}
