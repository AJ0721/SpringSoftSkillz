package com.softskillz.courseorder.model.bean.test;

import java.math.BigDecimal;
import java.util.List;

public class ProductPackageForm {

	private String id;
	private String name;
	private BigDecimal amount;
	private List<ProductForm> products;
	private RedirectUrls redirectUrls;

	public ProductPackageForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductPackageForm(String id, String name, BigDecimal amount, List<ProductForm> products,
			RedirectUrls redirectUrls) {
		super();
		this.id = id;
		this.name = name;
		this.amount = amount;
		this.products = products;
		this.redirectUrls = redirectUrls;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public List<ProductForm> getProducts() {
		return products;
	}

	public void setProducts(List<ProductForm> products) {
		this.products = products;
	}

	@Override
	public String toString() {
		return "ProductPackageForm [id=" + id + ", name=" + name + ", amount=" + amount + ", products=" + products
				+ "]";
	}

	public RedirectUrls getRedirectUrls() {
		return redirectUrls;
	}

	public void setRedirectUrls(RedirectUrls redirectUrls) {
		this.redirectUrls = redirectUrls;
	}

}
