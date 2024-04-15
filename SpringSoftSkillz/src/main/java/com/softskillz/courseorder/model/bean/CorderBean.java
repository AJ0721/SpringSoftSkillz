package com.softskillz.courseorder.model.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;


@Entity
@Table(name = "corder")
@Component
public class CorderBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "order_id")
	private String orderID;

	@Column(name = "student_id")
	private Integer studentID;

	@Column(name = "order_price")
	private Integer orderPrice;

	@Column(name = "order_date")
	private Date orderDate;

	@Column(name = "payment_method")
	private String method;

	@Column(name = "order_status")
	private String status;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "corderBean", cascade = CascadeType.ALL)
	private Set<ItemBean> orderItem = new HashSet<ItemBean>();

	public CorderBean() {
		super();
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

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Set<ItemBean> getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(Set<ItemBean> orderItem) {
		this.orderItem = orderItem;
	}

	@Override
	public String toString() {
		return "OrderBean [orderID=" + orderID + ", studentID=" + studentID + ", orderPrice=" + orderPrice
				+ ", orderDate=" + orderDate + ", method=" + method + ", status=" + status + ", orderItem=" + orderItem
				+ "]";
	}

}
