package com.softskillz.order.model;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderDao orderDao;

    // 保存或更新订单
    public void insertOrder(OrderBean order) {
        orderDao.insertOrder(order); // 这里假设insertOrder方法实际上执行的是保存或更新操作
    }

    // 根据ID删除订单
    public void deleteOrderById(Integer orderId) {
        orderDao.deleteOrder(orderId);
    }

    // 根据ID获取订单
    public OrderBean getOrderById(Integer orderId) {
        return orderDao.selectOrderById(orderId);
    }

    // 更新订单
    public void updateOrder(OrderBean order) {
        orderDao.updateOrder(order);
    }

    // 获取所有订单
    public List<OrderBean> getAllOrders() {
        return orderDao.selectAllOrders();
    }
}
