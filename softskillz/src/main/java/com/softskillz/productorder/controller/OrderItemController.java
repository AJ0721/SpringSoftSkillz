package com.softskillz.productorder.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.productorder.model.OrderItem;
import com.softskillz.productorder.model.OrderItemService;

@RestController
@RequestMapping("/orderItems")
public class OrderItemController {

    @Autowired
    private OrderItemService orderItemService;

    // 獲取所有訂單項目
    @GetMapping
    public ResponseEntity<List<OrderItem>> getAllOrderItems() {
        List<OrderItem> orderItems = orderItemService.findAllOrderItems();
        return new ResponseEntity<>(orderItems, HttpStatus.OK);
    }

    // 根據 ID 獲取單個訂單項目
    @GetMapping("/{id}")
    public ResponseEntity<OrderItem> getOrderItemById(@PathVariable Integer id) {
        OrderItem orderItem = orderItemService.findOrderItemById(id);
        if (orderItem != null) {
            return new ResponseEntity<>(orderItem, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // 建立新訂單
    @PostMapping
    public ResponseEntity<OrderItem> createOrderItem(@RequestBody OrderItem orderItem) {
        OrderItem newOrderItem = orderItemService.createOrderItem(orderItem);
        return new ResponseEntity<>(newOrderItem, HttpStatus.CREATED);
    }

    // 更新訂單項目
    @PutMapping("/{id}")
    public ResponseEntity<OrderItem> updateOrderItem(@PathVariable Integer id, @RequestBody OrderItem orderItemDetails) {
        OrderItem updatedOrderItem = orderItemService.updateOrderItem(id, orderItemDetails);
        if (updatedOrderItem != null) {
            return new ResponseEntity<>(updatedOrderItem, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // 刪除訂單項目
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteOrderItem(@PathVariable Integer id) {
        try {
            orderItemService.deleteOrderItem(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
