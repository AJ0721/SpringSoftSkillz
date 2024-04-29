package com.softskillz.courseorder.model.bean.test;

public class Citem {
	private Integer amount;
	private String currency;

	public Citem() {
		super();
	}

	public Citem(Integer amount, String currency) {
		super();
		this.amount = amount;
		this.currency = currency;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

}
