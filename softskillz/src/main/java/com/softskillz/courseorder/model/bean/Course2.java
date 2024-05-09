package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

public class Course2 implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer courseID;
	private String teacherID;
	private String teacherName;
	private String teacherPhoto;
	private String courseName;
	private String courseInfo;
	private String courseCategory;
	private Integer price;

	public Course2() {
		super();
	}

	public Course2(Integer courseID, String teacherName, String teacherPhoto, String courseName, String courseInfo,
			String courseCategory, Integer price) {
		super();
		this.courseID = courseID;
		this.teacherName = teacherName;
		this.teacherPhoto = teacherPhoto;
		this.courseName = courseName;
		this.courseInfo = courseInfo;
		this.courseCategory = courseCategory;
		this.price = price;
	}

	public Integer getCourseID() {
		return courseID;
	}

	public void setCourseID(Integer courseID) {
		this.courseID = courseID;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getTeacherPhoto() {
		return teacherPhoto;
	}

	public void setTeacherPhoto(String teacherPhoto) {
		this.teacherPhoto = teacherPhoto;
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

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getTeacherID() {
		return teacherID;
	}

	public void setTeacherID(String teacherID) {
		this.teacherID = teacherID;
	}

	@Override
	public String toString() {
		return "Course2 [courseID=" + courseID + ", teacherName=" + teacherName + ", teacherPhoto=" + teacherPhoto
				+ ", courseName=" + courseName + ", courseInfo=" + courseInfo + ", course_category=" + courseCategory + ", price="
				+ price + "]";
	}

}
