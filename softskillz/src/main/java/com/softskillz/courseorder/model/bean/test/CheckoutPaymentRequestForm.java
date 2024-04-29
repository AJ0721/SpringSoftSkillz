package com.softskillz.courseorder.model.bean.test;

import java.math.BigDecimal;
import java.util.List;

public class CheckoutPaymentRequestForm {
	private BigDecimal amount;
	private String currency;
	private String orderId;
	private List<ProductPackageForm> packages;
	private RedirectUrls redirectUrls;

	public CheckoutPaymentRequestForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CheckoutPaymentRequestForm(BigDecimal amount, String currency, String orderId,
			List<ProductPackageForm> packages, RedirectUrls redirectUrls) {
		super();
		this.amount = amount;
		this.currency = currency;
		this.orderId = orderId;
		this.packages = packages;
		this.redirectUrls = redirectUrls;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
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

	public List<ProductPackageForm> getPackages() {
		return packages;
	}

	public void setPackages(List<ProductPackageForm> packages) {
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
		return "CheckoutPaymentRequestForm [amount=" + amount + ", currency=" + currency + ", orderId=" + orderId
				+ ", packages=" + packages + ", redirectUrls=" + redirectUrls + "]";
	}

}
