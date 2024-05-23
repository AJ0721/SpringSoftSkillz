package com.softskillz.productorder.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    // 建立新訂單
    public Order insertOrder(Order order) {
        return orderRepository.save(order);
    }

    // 讀取所有訂單
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // 根據ID讀取單個訂單
    public Order getById(Integer id) {
        Optional<Order> optional = orderRepository.findById(id);
        return optional.orElse(null);
    }

    // 根據訂單ID查找訂單
    public Order findOrderById(Integer orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.orElse(null);
    }

    // 更新訂單
    public Order updateOrder(Order orderDetails) {
        return orderRepository.save(orderDetails);
    }

    // 刪除訂單，返回是否成功刪除
    public boolean deleteOrder(Integer id) {
        if (orderRepository.existsById(id)) {
            orderRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
