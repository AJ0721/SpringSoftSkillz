package com.softskillz.courseorder.model.bean;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;

public class Order implements Serializable {

	private static final long serialVersionUID = 1L;
	private String orderID;
	private Integer studentID;
	private Integer orderPrice;
	private Date orderDate;
	private Date cancelDate;
	private String disNo;
	private Double disPercent;
	private Integer afterPrice;
	private String paymentMethod;
	private String orderStatus;

	public Order() {
		super();
	}

	public Order(String orderID, Integer studentID, Integer orderPrice, Date orderDate, Date cancelDate, String disNo,
			Double disPercent, Integer afterPrice, String paymentMethod, String orderStatus) {
		super();
		this.orderID = orderID;
		this.studentID = studentID;
		this.orderPrice = orderPrice;
		this.orderDate = orderDate;
		this.cancelDate = cancelDate;
		this.disNo = disNo;
		this.disPercent = disPercent;
		this.afterPrice = afterPrice;
		this.paymentMethod = paymentMethod;
		this.orderStatus = orderStatus;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public Integer getStudentID() {
		return studentID;
	}

	public void setStudentID(Integer studentID) {
		this.studentID = studentID;
	}

	public Integer getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(Integer orderPrice) {
		this.orderPrice = orderPrice;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Date getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getDisNo() {
		return disNo;
	}

	public void setDisNo(String disNo) {
		this.disNo = disNo;
	}

	public Double getDisPercent() {
		return disPercent;
	}

	public void setDisPercent(Double disPercent) {
		this.disPercent = disPercent;
	}

	public Integer getAfterPrice() {
		return afterPrice;
	}

	public void setAfterPrice(Integer afterPrice) {
		this.afterPrice = afterPrice;
	}

	@Override
	public String toString() {
		return "Order [orderID=" + orderID + ", studentID=" + studentID + ", orderPrice=" + orderPrice + ", orderDate="
				+ orderDate + ", cancelDate=" + cancelDate + ", disNo=" + disNo + ", disPercent=" + disPercent
				+ ", afterPrice=" + afterPrice + ", paymentMethod=" + paymentMethod + ", orderStatus=" + orderStatus
				+ "]";
	}

}
