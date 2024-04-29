package com.softskillz.courseorder.model.service;

import java.util.List;
import java.util.Map;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;


public interface CourseOrderService {

	CorderBean insertORD(CorderBean order, Map<Integer, CartItem> cart);

	List<Order> studentORD(Integer studentID);

	List<Order> getAllORD();

	Order getORDByID(String orderID);

	Integer cancelORD(String orderID);

	void deleteByID(String orderID);

	List<ItemInfo> getItem(String orderID);

	List<Order> getOrderByDate(String date1String, String date2String);
	
	Integer adminUpdateOrder(String orderID,String status);
	
	Integer payOrder(String orderID,String status,String method);

}
