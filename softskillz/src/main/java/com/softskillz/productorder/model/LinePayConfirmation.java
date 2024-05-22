package com.softskillz.productorder.model;

import java.io.Serializable;

public class LinePayConfirmation implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer amount;
    private String currency;

    // Constructor
    public LinePayConfirmation(Integer amount, String currency) {
        this.amount = amount;
        this.currency = currency;
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
}
