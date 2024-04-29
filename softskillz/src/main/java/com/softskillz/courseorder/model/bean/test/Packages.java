package com.softskillz.courseorder.model.bean.test;

import java.util.List;

public class Packages {
	private String id;
	private Integer amount;
	private List<Products> products;

	public Packages() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Packages(String id, Integer amount, List<Products> products) {
		super();
		this.id = id;
		this.amount = amount;
		this.products = products;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public List<Products> getProducts() {
		return products;
	}

	public void setProducts(List<Products> products) {
		this.products = products;
	}

	@Override
	public String toString() {
		return "Packages [id=" + id + ", amount=" + amount + ", products=" + products + "]";
	}

}
