package com.softskillz.productorder.controller;

import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/order")
@SessionAttributes(names = {"order"})
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping(value = "/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Order> createOrder(@RequestBody Order order) {
        // 檢查 order_date 是否為 null
        if (order.getOrderDate() == null) {
            throw new IllegalArgumentException("order_date cannot be null");
        }
        // 創建新訂單
        Order newOrder = orderService.insertOrder(order);
        return ResponseEntity.ok().body(newOrder);
    }

    // 查詢更新訂單的資料并返回JSON
    @GetMapping("/searchforupdate/{orderId}")
    public ResponseEntity<?> getOrderByIdForUpdate(@PathVariable("orderId") int orderId) {
        Order order = orderService.getById(orderId);
        if (order != null) {
            return ResponseEntity.ok(order); // 返回订单数据的JSON格式
        } else {
            return ResponseEntity.notFound().build(); // 如果订单未找到，返回404状态码
        }
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateOrder(@RequestParam("order_id") Integer orderId,
            @RequestParam("order_date") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime orderDate,
            @RequestParam("total_amount") Integer totalAmount,
            @RequestParam("order_status") String orderStatus,
            @RequestParam("payment_method") String paymentMethod,
            @RequestParam("shipment_date") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime shipmentDate,
            @RequestParam("shipment_status") String shipmentStatus,
            @RequestParam("shipping_address") String shippingAddress) {

        Order order = orderService.getById(orderId);
        if (order != null) {
            order.setOrderDate(orderDate);
            order.setTotalAmount(totalAmount);
            order.setOrderStatus(orderStatus);
            order.setPaymentMethod(paymentMethod);
            order.setShipmentDate(shipmentDate);
            order.setShipmentStatus(shipmentStatus);
            order.setShippingAddress(shippingAddress);

            orderService.updateOrder(order);
            return ResponseEntity.ok("訂單更新成功！");
        } else {
            return ResponseEntity.status(404).body("訂單未找到！");
        }
    }

    @DeleteMapping("/delete/{orderId}")
    public ResponseEntity<String> deleteOrder(@PathVariable int orderId) {
        orderService.deleteOrder(orderId);
        return ResponseEntity.ok("訂單已刪除！");
    }
}
