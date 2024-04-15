package com.softskillz.courseorder.model.bean;

import java.io.Serializable;
import java.util.Date;

public class Order implements Serializable {

	private static final long serialVersionUID = 1L;
	private String orderID;
	private Integer studentID;
	private Integer orderPrice;
	private Date orderDate;
	private String paymentMethod;
	private String orderStatus;

	public Order() {
		super();
	}

	public Order(String orderID, Integer studentID, Integer orderPrice, Date orderDate, String paymentMethod,
			String orderStatus) {
		super();
		this.orderID = orderID;
		this.studentID = studentID;
		this.orderPrice = orderPrice;
		this.orderDate = orderDate;
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

	@Override
	public String toString() {
		return "Order [orderID=" + orderID + ", studentID=" + studentID + ", orderPrice=" + orderPrice + ", orderDate="
				+ orderDate + ", paymentMethod=" + paymentMethod + ", orderStatus=" + orderStatus + "]";
	}

}
