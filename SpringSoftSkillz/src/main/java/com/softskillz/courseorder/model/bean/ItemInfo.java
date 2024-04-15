package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

public class ItemInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	private String orderID;
	private String teacherName;
	private String courseName;
	private String courseCategory;
	private Integer coursePrice;
	private Integer qty;
	private Integer status;

	public ItemInfo() {
		super();
	}

	public ItemInfo(String orderID, String teacherName, String courseName, String courseCategory, Integer price,
			Integer qty, Integer status) {
		super();
		this.orderID = orderID;
		this.teacherName = teacherName;
		this.courseName = courseName;
		this.courseCategory = courseCategory;
		this.coursePrice = price;
		this.qty = qty;
		this.status = status;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
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

	public void setCoursePrice(Integer price) {
		this.coursePrice = price;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ItemInfo [orderID=" + orderID + ", teacherName=" + teacherName + ", courseName=" + courseName
				+ ", courseCategory=" + courseCategory + ", price=" + coursePrice + ", qty=" + qty + ", status=" + status
				+ "]";
	}

}
