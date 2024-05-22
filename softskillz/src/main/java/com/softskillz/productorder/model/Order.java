package com.softskillz.productorder.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "orders")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;//後端

    @Column(name = "student_id")
    private Integer studentId;//後端

    @Column(name = "coupon_id")
    private Integer couponId;

    @Column(name = "total_amount")
    private Integer totalAmount;

    @Column(name = "order_status")
    private String orderStatus;//後端

    @Column(name = "payment_method")
    private String paymentMethod;

    @Column(name = "shipment_status")
    private String shipmentStatus;//後端

    @Column(name = "shipping_address")
    private String shippingAddress;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Column(name = "order_date")
    private LocalDateTime orderDate;//後端

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @Column(name = "shipment_date")
    private LocalDateTime shipmentDate;//後端

    @JsonManagedReference
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<OrderItem> orderItems = new HashSet<>();

    public Order() {
        super();
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Integer totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getShipmentStatus() {
        return shipmentStatus;
    }

    public void setShipmentStatus(String shipmentStatus) {
        this.shipmentStatus = shipmentStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getShipmentDate() {
        return shipmentDate;
    }

    public void setShipmentDate(LocalDateTime shipmentDate) {
        this.shipmentDate = shipmentDate;
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", studentId=" + studentId + ", couponId=" + couponId + ", totalAmount=" 
                + totalAmount + ", orderStatus=" + orderStatus + ", paymentMethod=" + paymentMethod 
                + ", shipmentStatus=" + shipmentStatus + ", shippingAddress=" + shippingAddress + ", orderDate=" 
                + orderDate + ", shipmentDate=" + shipmentDate + ", orderItems=" + orderItems + "]";
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Order other = (Order) obj;
        return Objects.equals(orderId, other.orderId);
    }
}
