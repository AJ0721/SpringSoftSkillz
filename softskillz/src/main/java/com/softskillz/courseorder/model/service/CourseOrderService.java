package com.softskillz.courseorder.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.DiscountBean;
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

	Integer adminUpdateOrder(String orderID, String status);

	CorderBean payOrder(String orderID, String status, String method,DiscountBean discount);

	Page<Order> getPageOrder(Pageable pageable);

	Page<Order> getPageOrderByDate(Pageable pageable, String date1String, String date2String);
	
	Page<Order> getPageByStudentID(Pageable pageable, Integer studentID,String status);	
	
	Page<Order> getPageByStudentIDAndDate(Pageable pageable, String date1String, String date2String, Integer studentID,String status);	
	
}
