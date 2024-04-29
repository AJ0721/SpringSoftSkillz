package com.softskillz.productorder.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer order_id;
    private Integer student_id;
    private Integer total_amount;
    private String order_status;
    private String payment_method;
    private String shipment_status;
    private String shipping_address;
    
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime order_date;
   
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime shipment_date;

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public Integer getStudent_id() {
		return student_id;
	}

	public void setStudent_id(Integer student_id) {
		this.student_id = student_id;
	}

	public Integer getTotal_amount() {
		return total_amount;
	}

	public void setTotal_amount(Integer total_amount) {
		this.total_amount = total_amount;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getPayment_method() {
		return payment_method;
	}

	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}

	public String getShipment_status() {
		return shipment_status;
	}

	public void setShipment_status(String shipment_status) {
		this.shipment_status = shipment_status;
	}

	public String getShipping_address() {
		return shipping_address;
	}

	public void setShipping_address(String shipping_address) {
		this.shipping_address = shipping_address;
	}

	public LocalDateTime getOrder_date() {
		return order_date;
	}

	public void setOrder_date(LocalDateTime order_date) {
		this.order_date = order_date;
	}

	public LocalDateTime getShipment_date() {
		return shipment_date;
	}

	public void setShipment_date(LocalDateTime shipment_date) {
		this.shipment_date = shipment_date;
	}
	
}	
	
