package com.softskillz.productorder.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    // 創建新訂單項目
    public OrderItem createOrderItem(OrderItem orderItem) {
        return orderItemRepository.save(orderItem);
    }

    // 讀取所有訂單項目
    public List<OrderItem> findAllOrderItems() {
        return orderItemRepository.findAll();
    }

    // 根據 ID 讀取單個訂單項目
    public OrderItem findOrderItemById(Integer id) {
        Optional<OrderItem> orderItem = orderItemRepository.findById(id);
        return orderItem.orElse(null);
    }

    // 更新訂單項目
    public OrderItem updateOrderItem(Integer id, OrderItem orderItemDetails) {
        OrderItem orderItem = findOrderItemById(id);
        if (orderItem != null) {
            orderItem.setOrder_id(orderItemDetails.getOrder_id());
            orderItem.setProduct_id(orderItemDetails.getProduct_id());
            orderItem.setQuantity(orderItemDetails.getQuantity());
            orderItem.setProduct_price(orderItemDetails.getProduct_price());
            orderItem.setSub_total(orderItemDetails.getSub_total());
            return orderItemRepository.save(orderItem);
        }
        return null;
    }

    // 刪除訂單項目
    public void deleteOrderItem(Integer id) {
        orderItemRepository.deleteById(id);
    }
}
