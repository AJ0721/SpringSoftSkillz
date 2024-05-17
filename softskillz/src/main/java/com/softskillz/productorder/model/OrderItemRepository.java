package com.softskillz.productorder.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {
	

	//List<OrderItem> findByOrder_id(Integer order_id);

}
