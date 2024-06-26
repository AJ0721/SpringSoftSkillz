package com.softskillz.courseorder.model.bean;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "corderitem")
@Component
public class ItemBean {



	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "item_id")
	private Integer itemID;

	@Column(name = "order_id")
	private String orderID;

	@Column(name = "course_id")
	private Integer courseID;

	@Column(name = "course_price")
	private Integer coursePrice;

	@Column(name = "qty")
	private Integer qty;

	@Column(name = "discount_percent")
	private Double disPercent;

	@Column(name = "after_price")
	private Integer disPrice;

	@Column(name = "subtotal")
	private Integer subtotal;

	@Column(name = "item_status")
	private Integer itemStatus;

	@JoinColumn(name = "order_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private CorderBean corderBean;

	@JoinColumn(name = "course_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private CourseBean2 courseBean2;

	public ItemBean() {
		super();
	}

	public Integer getItemID() {
		return itemID;
	}

	public void setItemID(Integer itemID) {
		this.itemID = itemID;
	}

	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}

	public Integer getCourseID() {
		return courseID;
	}

	public void setCourseID(Integer courseID) {
		this.courseID = courseID;
	}

	public Integer getCoursePrice() {
		return coursePrice;
	}

	public void setCoursePrice(Integer coursePrice) {
		this.coursePrice = coursePrice;
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

	public Integer getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(Integer itemStatus) {
		this.itemStatus = itemStatus;
	}

	public CorderBean getOrderBean() {
		return corderBean;
	}

	public void setOrderBean(CorderBean corderBean) {
		this.corderBean = corderBean;
	}

	public CourseBean2 getCourseBean() {
		return courseBean2;
	}

	public void setCourseBean(CourseBean2 courseBean2) {
		this.courseBean2 = courseBean2;
	}

	@Override
	public String toString() {
		return "ItemBean [itemID=" + itemID + ", orderID=" + orderID + ", courseID=" + courseID + ", coursePrice="
				+ coursePrice + ", qty=" + qty + ", disPercent=" + disPercent + ", disPrice=" + disPrice + ", subtotal="
				+ subtotal + ", itemStatus=" + itemStatus + "]";
	}
}
