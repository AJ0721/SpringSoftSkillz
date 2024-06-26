package com.softskillz.courseorder.model.bean.test;

public class Products {
	private String id;
	private String name;
	private Integer quantity;
	private Integer price;

	public Products() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Products(String id, String name, Integer quantity, Integer price) {
		super();
		this.id = id;
		this.name = name;
		this.quantity = quantity;
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Products [id=" + id + ", name=" + name + ", quantity=" + quantity + ", price=" + price + "]";
	}

}
