package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

import jakarta.persistence.Column;

public class ItemInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	private String orderID;
	private String teacherName;
	private Integer courseID;
	private String courseName;
	private String courseCategory;
	private Integer coursePrice;
	private Integer qty;
	private Double disPercent;
	private Integer disPrice;
	private Integer subtotal;
	private Integer status;

	public ItemInfo() {
		super();
	}

	public ItemInfo(String orderID, String teacherName, Integer courseID, String courseName, String courseCategory,
			Integer coursePrice, Integer qty, Double disPercent, Integer disPrice, Integer subtotal, Integer status) {
		super();
		this.orderID = orderID;
		this.teacherName = teacherName;
		this.courseID = courseID;
		this.courseName = courseName;
		this.courseCategory = courseCategory;
		this.coursePrice = coursePrice;
		this.qty = qty;
		this.disPercent = disPercent;
		this.disPrice = disPrice;
		this.subtotal = subtotal;
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

	public Double getDisPercent() {
		return disPercent;
	}

	public void setDisPercent(Double disPercent) {
		this.disPercent = disPercent;
	}

	public Integer getDisPrice() {
		return disPrice;
	}

	public void setDisPrice(Integer disPrice) {
		this.disPrice = disPrice;
	}

	public Integer getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(Integer subtotal) {
		this.subtotal = subtotal;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getCourseID() {
		return courseID;
	}

	public void setCourseID(Integer courseID) {
		this.courseID = courseID;
	}

	@Override
	public String toString() {
		return "ItemInfo [orderID=" + orderID + ", teacherName=" + teacherName + ", courseName=" + courseName
				+ ", courseCategory=" + courseCategory + ", price=" + coursePrice + ", qty=" + qty + ", status="
				+ status + "]";
	}

}
