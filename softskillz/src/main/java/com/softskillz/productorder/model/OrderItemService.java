package com.softskillz.productorder.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class OrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    // 批量創建新的訂單項目
    public void createOrderItems(List<OrderItem> orderItems) {
        orderItemRepository.saveAll(orderItems);
    }

    // 創建一個新的訂單項目
    public OrderItem createOrderItem(OrderItem orderItem) {
        return orderItemRepository.save(orderItem);
    }

    // 讀取全部訂單項目
    public List<OrderItem> findAllOrderItems() {
        return orderItemRepository.findAll();
    }

    // 根據訂單ID讀取訂單項目
    public List<OrderItem> findOrderItemsByOrderId(Integer orderId) {
        return orderItemRepository.findByOrderId(orderId);
    }

    // 根據ID讀取單個訂單項目
    public OrderItem findOrderItemById(Integer id) {
        Optional<OrderItem> orderItem = orderItemRepository.findById(id);
        return orderItem.orElse(null);
    }

    // 根據ID更新訂單項目
    public OrderItem updateOrderItem(Integer id, OrderItem orderItemDetails) {
        OrderItem orderItem = findOrderItemById(id);
        if (orderItem != null) {
            orderItem.setOrderId(orderItemDetails.getOrderId());
            orderItem.setProductId(orderItemDetails.getProductId());
            orderItem.setProductName(orderItemDetails.getProductName());
            orderItem.setQuantity(orderItemDetails.getQuantity());
            orderItem.setProductPrice(orderItemDetails.getProductPrice());
            orderItem.setSubTotal(orderItemDetails.getSubTotal());
            return orderItemRepository.save(orderItem);
        }
        return null;
    }

    // 刪除訂單項目
    public void deleteOrderItem(Integer id) {
        orderItemRepository.deleteById(id);
    }
}
