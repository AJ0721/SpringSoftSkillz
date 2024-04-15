package com.softskillz.courseorder.model.bean.test;

import java.util.List;

public class Item {
	private Integer amount;
	private String currency;
	private String orderId;
	private List<Packages> packages;
	private RedirectUrls redirectUrls;

	public Item(Integer amount, String currency, String orderId, List<Packages> packages, RedirectUrls redirectUrls) {
		super();
		this.amount = amount;
		this.currency = currency;
		this.orderId = orderId;
		this.packages = packages;
		this.redirectUrls = redirectUrls;
	}

	public Item() {
		super();
		// TODO Auto-generated constructor stub
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

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public List<Packages> getPackages() {
		return packages;
	}

	public void setPackages(List<Packages> packages) {
		this.packages = packages;
	}

	public RedirectUrls getRedirectUrls() {
		return redirectUrls;
	}

	public void setRedirectUrls(RedirectUrls redirectUrls) {
		this.redirectUrls = redirectUrls;
	}

	@Override
	public String toString() {
		return "Item [amount=" + amount + ", currency=" + currency + ", orderId=" + orderId + ", packages=" + packages
				+ ", redirectUrls=" + redirectUrls + "]";
	}

}
