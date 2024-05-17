package com.softskillz.courseorder.model.bean;

import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.softskillz.account.model.bean.TeacherBean;

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
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
public class CourseBean2  {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "course_id")
	private Integer courseID;

//	@Column(name = "teacher_id")
//	private Integer teacherID;

	@Column(name = "course_name")
	private String courseName;

	@Column(name = "course_info")
	private String courseInfo;

	@Column(name = "course_category")
	private String courseCategory;

	@Column(name = "course_price")
	private Integer coursePrice;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "courseBean2")
	private Set<ItemBean> orderItem = new HashSet<ItemBean>();

	@JoinColumn(name = "teacher_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private  TeacherBean teacherBean;



	public CourseBean2() {
	}

	public Integer getCourseID() {
		return courseID;
	}

	public void setCourseID(Integer courseID) {
		this.courseID = courseID;
	}

//	public Integer getTeacherID() {
//		return teacherID;
//	}
//
//	public void setTeacherID(Integer teacherID) {
//		this.teacherID = teacherID;
//	}

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

	public Set<ItemBean> getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(Set<ItemBean> orderItem) {
		this.orderItem = orderItem;
	}

	public TeacherBean getTeacherBean() {
		return teacherBean;
	}

	public void setTeacherBean(TeacherBean teacherBean) {
		this.teacherBean = teacherBean;
	}


}
