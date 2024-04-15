package com.softskillz.order.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity @Table(name = "orders")
@Component
public class OrderBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id")
	private Integer orderId;
	
	@Column(name = "student_id")
	private Integer studentId;
	
	@Column(name = "order_date")
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime orderDate;
	
	@Column(name = "total_amount")
	private Integer totalAmount;

	@Column(name = "order_status")
	private String orderStatus;
	
	@Column(name = "payment_method")
	private String paymentMethod;

	@Column(name = "shipment_date")
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime shipmentDate;
	
	@Column(name = "shipment_status")
	private String shipmentStatus;

	@Column(name = "shipping_address")
	private String shippingAddress;
	
//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orderBean", cascade = {CascadeType.PERSIST,CascadeType.MERGE})
//	private Set<OrderBean> orderBean = new LinkedHashSet<>();

	
	public OrderBean() {
	}
	
	public OrderBean(Integer orderId, Integer studentId, Integer couponDiscount, LocalDateTime orderDate, Integer totalAmount,
			String orderStatus, String paymentMethod, LocalDateTime shipmentDate, String shipmentStatus,
			String shippingAddress) {
		super();
		this.orderId = orderId;
		this.studentId = studentId;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.orderStatus = orderStatus;
		this.paymentMethod = paymentMethod;
		this.shipmentDate = shipmentDate;
		this.shipmentStatus = shipmentStatus;
		this.shippingAddress = shippingAddress;
	}

	public OrderBean(Integer studentId, Integer couponDiscount, LocalDateTime orderDate, Integer totalAmount,
			String orderStatus, String paymentMethod, LocalDateTime shipmentDate, String shipmentStatus,
			String shippingAddress) {
		super();
		this.studentId = studentId;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.orderStatus = orderStatus;
		this.paymentMethod = paymentMethod;
		this.shipmentDate = shipmentDate;
		this.shipmentStatus = shipmentStatus;
		this.shippingAddress = shippingAddress;
	}


	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	public Integer getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public LocalDateTime getShipmentDate() {
		return shipmentDate;
	}

	public void setShipmentDate(LocalDateTime shipmentDate) {
		this.shipmentDate = shipmentDate;
	}

	public String getShipmentStatus() {
		return shipmentStatus;
	}

	public void setShipmentStatus(String shipmentStatus) {
		this.shipmentStatus = shipmentStatus;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	@Override
	public String toString() {
		return "OrderBean [orderId=" + orderId + ", studentId=" + studentId + ", orderDate=" + orderDate
				+ ", totalAmount=" + totalAmount + ", orderStatus=" + orderStatus + ", paymentMethod=" + paymentMethod
				+ ", shipmentDate=" + shipmentDate + ", shipmentStatus=" + shipmentStatus + ", shippingAddress="
				+ shippingAddress + "]";
	}
	
	

}	