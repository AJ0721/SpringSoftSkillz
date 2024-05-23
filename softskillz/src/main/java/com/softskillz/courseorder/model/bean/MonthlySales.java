package com.softskillz.courseorder.model.bean;

public class MonthlySales {
    private long totalSales;  // 使用long來匹配Hibernate中的Long
    private int month;

    public MonthlySales(long totalSales, int month) {
        this.totalSales = totalSales;
        this.month = month;
    }

    // Getters and Setters
    public long getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(long totalSales) {
        this.totalSales = totalSales;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }
}