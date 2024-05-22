package com.softskillz.courseorder.model.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "corder")
@Component
public class CorderBean implements Serializable, Delayed {

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

	@Column(name = "cancel_date")
	private Date cancelDate;

	@Column(name = "discount_id", columnDefinition = "")
	private String disNo;

	@Column(name = "discount_percent")
	private Double disPercent;

	@Column(name = "after_price")
	private Integer afterPrice;

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

	public Date getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
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

	public Set<ItemBean> getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(Set<ItemBean> orderItem) {
		this.orderItem = orderItem;
	}

	@PrePersist
	public void prePersist() {

		if (this.method == null) {
			this.method = "未付款";
		}

		if (this.disNo == null) {
			this.disNo = "無";
		}
		
		if (this.disPercent == null) {
			this.disPercent = 100.0;
		}
		if (this.afterPrice == null) {
			this.afterPrice = orderPrice;
		}
	}

	@Override
	public String toString() {
		return "CorderBean [orderID=" + orderID + ", studentID=" + studentID + ", orderPrice=" + orderPrice
				+ ", orderDate=" + orderDate + ", cancelDate=" + cancelDate + ", disNo=" + disNo + ", disPercent="
				+ disPercent + ", afterPrice=" + afterPrice + ", method=" + method + ", status=" + status
				+ ", orderItem=" + orderItem + "]";
	}

	@Override
	public long getDelay(TimeUnit unit) {
		long remainingTime = (cancelDate.getTime()) - System.currentTimeMillis();
		return unit.convert(remainingTime, TimeUnit.MILLISECONDS);
	}

	@Override
	public int compareTo(Delayed o) {
		if (o instanceof CorderBean) {
			CorderBean other = (CorderBean) o;
			return Long.compare(getDelay(TimeUnit.MILLISECONDS), other.getDelay(TimeUnit.MILLISECONDS));
		}
		return 0;
	}

	@Override
	public int hashCode() {
		return Objects.hash(orderID);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		CorderBean other = (CorderBean) obj;
		return Objects.equals(orderID, other.orderID);
	}
}
