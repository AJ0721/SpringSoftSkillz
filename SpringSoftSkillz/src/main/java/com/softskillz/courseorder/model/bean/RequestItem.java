package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

public class RequestItem implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer amount;
	private String currency;
	private String orderId;
	private String productName;
	private String confirmUrl;

	public RequestItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RequestItem(Integer amount, String currency, String orderId, String productName, String confirmUrl) {
		super();
		this.amount = amount;
		this.currency = currency;
		this.orderId = orderId;
		this.productName = productName;
		this.confirmUrl = confirmUrl;
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

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getConfirmUrl() {
		return confirmUrl;
	}

	public void setConfirmUrl(String confirmUrl) {
		this.confirmUrl = confirmUrl;
	}

	@Override
	public String toString() {
		return "LinePayItem [amount=" + amount + ", currency=" + currency + ", orderId=" + orderId + ", productName="
				+ productName + ", confirmUrl=" + confirmUrl + "]";
	}

}
