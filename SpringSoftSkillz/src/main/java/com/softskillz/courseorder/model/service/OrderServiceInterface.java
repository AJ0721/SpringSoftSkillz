package com.softskillz.courseorder.model.service;

import java.util.List;
import java.util.Map;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;


public interface OrderServiceInterface {
	public void insertORD(CorderBean orderBean,Map<Integer, CartItem> cart);

	public void deleteORD(String orderID);

	public void cancelORD(String orderID);
	
	public CorderBean selectByID(String orderID);
	
	public List<Order> selsctUserAllORD(Integer studentID);

	public List<Order> adminSelectAll();

	public List<Order> adminSelectByDate(String date1String, String date2String);
	
	public void adminCancelORD(String orderID);
	
	public List<ItemInfo> getItem(String orderID);
}
