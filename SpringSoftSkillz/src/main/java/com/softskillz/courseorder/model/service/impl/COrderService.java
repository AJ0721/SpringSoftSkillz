package com.softskillz.courseorder.model.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.dao.OrderDaoInterface;
import com.softskillz.courseorder.model.service.OrderServiceInterface;
import com.softskillz.util.Util;


@Service
@Transactional
public class COrderService implements OrderServiceInterface {
	
	@Autowired
	private OrderDaoInterface dao;

	@Override
	public void insertORD(CorderBean orderBean, Map<Integer, CartItem> cart) {

		ItemBean itemBean = null;
		Set<ItemBean> orderItems = new HashSet<>();
		for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
			itemBean = new ItemBean();
			itemBean.setOrderID(orderBean.getOrderID());
			itemBean.setCourseID(entry.getValue().getCourse().getCourseID());
			itemBean.setCoursePrice(entry.getValue().getCourse().getPrice());
			itemBean.setQty(entry.getValue().getQuantity());
			itemBean.setItemStatus(0);
			orderItems.add(itemBean);
		}
		orderBean.setStatus("已付款");
		orderBean.setOrderItem(orderItems);
		dao.insertORD(orderBean);

	}

	@Override
	public void deleteORD(String orderID) {
		dao.deleteORD(orderID);
	}

	@Override
	public void cancelORD(String orderID) {
		CorderBean order = dao.selectORD(orderID);
		if (!order.getStatus().equals("已付款")) {
			return;
		} else {
			dao.cancelORD(orderID, "已取消");
		}
	}

	@Override
	public List<Order> selsctUserAllORD(Integer studentID) {
		List<CorderBean> orders = dao.selsctUserAllORD(studentID);
		List<Order> orders2 = new ArrayList<>();
		Order order = null;
		for (CorderBean o : orders) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders2.add(order);
		}

		return orders2;
	}

	@Override
	public List<Order> adminSelectAll() {
		List<CorderBean> orders = dao.adminSelectAll();
		List<Order> orders2 = new ArrayList<>();
		Order order = null;
		for (CorderBean o : orders) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders2.add(order);
		}
		return orders2;
	}

	@Override
	public List<Order> adminSelectByDate(String date1String, String date2String) {

		List<CorderBean> orders = null;

		Date date1 = Util.dateUtil(date1String);
		Long oneday = (long) (24 * 60 * 60 * 1000);
		if (date2String.isEmpty()) {
			Date date2 = new Date(date1.getTime() + oneday);
			orders = dao.adminSelectByDate(date1, date2);
		} else {
			Date date2 = Util.dateUtil(date2String);
			date2 = new Date(date2.getTime() + oneday);
			orders = dao.adminSelectByDate(date1, date2);
		}
		List<Order> orders2 = new ArrayList<>();
		Order order = null;
		for (CorderBean o : orders) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders2.add(order);
		}
		return orders2;

	}

	@Override
	public CorderBean selectByID(String orderID) {
		return dao.selectORD(orderID);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void adminCancelORD(String orderID) {
		dao.cancelORD(orderID, "已取消");
	}

	@Override
	public List<ItemInfo> getItem(String orderID) {
		CorderBean corderBean = dao.selectORDitem(orderID);
		Set<ItemBean> items = corderBean.getOrderItem();
		List<ItemInfo> items2 = new ArrayList<>();
		for (ItemBean i : items) {
			ItemInfo item = new ItemInfo();
			item.setOrderID(i.getOrderID());
			item.setTeacherName(i.getCourseBean().getTeacherBean().getTeacherLastName()
					+ i.getCourseBean().getTeacherBean().getTeacherFirstName());
			item.setCourseName(i.getCourseBean().getCourseName());
			item.setCourseCategory(i.getCourseBean().getCourseCategory());
			item.setCoursePrice(i.getCoursePrice());
			item.setQty(i.getQty());
			item.setStatus(i.getItemStatus());
			items2.add(item);
		}
		return items2;
	}

}
