package com.softskillz.productorder.model;

import java.io.Serializable;

import com.softskillz.mall.model.Product;


public class ProductCartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private Product product; 
    private Integer quantity; 

    public ProductCartItem() {
    }

    public ProductCartItem(Product product, Integer quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductCartItem{" +
               "product=" + product +
               ", quantity=" + quantity +
               '}';
    }
}
