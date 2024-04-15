package com.softskillz.order.model;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class OrderDao {

    @PersistenceContext
    private EntityManager entityManager;

    // 根据ID查询一份订单
    public OrderBean selectOrderById(Integer orderId) {
        return entityManager.find(OrderBean.class, orderId);
    }

    // 新增一份订单
    public void insertOrder(OrderBean order) {
        entityManager.persist(order);
    }

    // 根据ID删除一份订单
    public void deleteOrder(Integer orderId) {
        OrderBean order = entityManager.find(OrderBean.class, orderId);
        if (order != null) {
            entityManager.remove(order);
        }
    }

    // 更新订单信息
    public void updateOrder(OrderBean inputOrder) {
        OrderBean order = entityManager.find(OrderBean.class, inputOrder.getOrderId());
        if (order != null) {
            order.setStudentId(inputOrder.getStudentId());
            order.setOrderDate(inputOrder.getOrderDate());
            order.setTotalAmount(inputOrder.getTotalAmount());
            order.setOrderStatus(inputOrder.getOrderStatus());
            order.setShippingAddress(inputOrder.getShippingAddress());
            entityManager.merge(order);
        }
    }

    // 查询全部订单
    public List<OrderBean> selectAllOrders() {
        return entityManager.createQuery("FROM OrderBean", OrderBean.class).getResultList();
    }
}
