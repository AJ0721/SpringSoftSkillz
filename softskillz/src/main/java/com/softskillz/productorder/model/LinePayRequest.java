package com.softskillz.productorder.model;

import java.io.Serializable;

public class LinePayRequest implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer amount;
    private String currency;
    private String orderId;
    private String productName;
    private String confirmUrl;

    // Constructor
    public LinePayRequest(Integer amount, String currency, String orderId, String productName, String confirmUrl) {
        this.amount = amount;
        this.currency = currency;
        this.orderId = orderId;
        this.productName = productName;
        this.confirmUrl = confirmUrl;
    }

    // Getters and Setters
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
}
