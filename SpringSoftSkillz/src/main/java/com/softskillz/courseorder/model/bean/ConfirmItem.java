package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

public class ConfirmItem implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer amount;
	private String currency;

	public ConfirmItem() {
		super();
	}

	public ConfirmItem(Integer amount, String currency) {
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

	@Override
	public String toString() {
		return "ConfirmItem [amount=" + amount + ", currency=" + currency + "]";
	}

}
