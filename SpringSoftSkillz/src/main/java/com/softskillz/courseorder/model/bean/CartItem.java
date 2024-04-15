package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

public class CartItem implements Serializable {

	private static final long serialVersionUID = 1L;
	private Course2 course;
	private Integer quantity;

	public CartItem() {
		super();
	}

	public CartItem(Course2 course, Integer quantity) {
		super();
		this.course = course;
		this.quantity = quantity;
	}

	public Course2 getCourse() {
		return course;
	}

	public void setCourse(Course2 course) {
		this.course = course;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "CartItem [course=" + course + ", quantity=" + quantity + "]";
	}
}
