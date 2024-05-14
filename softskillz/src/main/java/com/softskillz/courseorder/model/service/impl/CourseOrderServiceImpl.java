package com.softskillz.courseorder.model.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.locks.ReentrantLock;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.repository.CourseOrderReporistory;
import com.softskillz.courseorder.model.service.CourseOrderService;
import com.softskillz.util.Util;

import jakarta.annotation.PostConstruct;

@Service
@Transactional
public class CourseOrderServiceImpl implements CourseOrderService {

	@Autowired
	private CourseOrderReporistory coRepo;

	@Autowired
	private DelayQueue<CorderBean> delayQueue;

	@Autowired
	private ReentrantLock lock;

	@Scheduled(fixedDelay = 1000) // 每秒检查一次
	public void processDelayedOrders() {
//		System.out.println("測試");
		lock.lock(); // 确保线程安全
		try {
			CorderBean order;
			while ((order = delayQueue.poll()) != null) {
				adminUpdateOrder(order.getOrderID(), "已取消"); // 处理超时订单
				System.out.println("取消");
			}
		} finally {
			lock.unlock(); // 释放锁
		}
	}

	@PostConstruct
	@Transactional
	public void init() {
		coRepo.updateOverdueOrder(new Date(), "已取消");
		System.out.println(new Date());
		List<CorderBean> orderList = coRepo.findNoOverdueOrder("未付款");
		delayQueue.addAll(orderList);
	}

	@Override
	public CorderBean insertORD(CorderBean order, Map<Integer, CartItem> cart) {
		ItemBean itemBean = null;
		Set<ItemBean> orderItems = new HashSet<>();
		for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
			itemBean = new ItemBean();
			itemBean.setOrderID(order.getOrderID());
			itemBean.setCourseID(entry.getValue().getCourse().getCourseID());
			itemBean.setCoursePrice(entry.getValue().getCourse().getPrice());
			itemBean.setQty(entry.getValue().getQuantity());
			itemBean.setItemStatus(0);
			orderItems.add(itemBean);
		}
		order.setOrderItem(orderItems);
		CorderBean corderBean = coRepo.save(order);
		delayQueue.add(corderBean);
		return corderBean;

	}

	@Override
	public List<Order> getAllORD() {
		List<CorderBean> resultList = coRepo.findAll();
		List<Order> orders = new ArrayList<Order>();
		Order order = null;
		for (CorderBean o : resultList) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setCancelDate(o.getCancelDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders.add(order);
		}

		return orders;
	}

	@Override
	public Order getORDByID(String orderID) {
		CorderBean resultBean = coRepo.findById(orderID).get();

		Order order = new Order();
		order.setOrderID(resultBean.getOrderID());
		order.setStudentID(resultBean.getStudentID());
		order.setOrderPrice(resultBean.getOrderPrice());
		order.setOrderDate(resultBean.getOrderDate());
		order.setCancelDate(resultBean.getCancelDate());
		order.setPaymentMethod(resultBean.getMethod());
		order.setOrderStatus(resultBean.getStatus());
		return order;
	}

	@Override
	public Integer cancelORD(String orderID) {
		return coRepo.cancelORD(orderID);
	}

	@Override
	public void deleteByID(String orderID) {
		coRepo.deleteById(orderID);
	}

	@Override
	public List<Order> studentORD(Integer studentID) {
		List<CorderBean> resultList = coRepo.findByStudentID(studentID);
		List<Order> orders = new ArrayList<Order>();
		Order order = null;
		for (CorderBean o : resultList) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setCancelDate(o.getCancelDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders.add(order);
		}

		return orders;
	}

	@Override
	public List<ItemInfo> getItem(String orderID) {
		CorderBean corderBean = coRepo.findById(orderID).get();
		Set<ItemBean> orderItem = corderBean.getOrderItem();
		List<ItemInfo> items = new ArrayList<>();
		for (ItemBean i : orderItem) {
			ItemInfo item = new ItemInfo();
			item.setOrderID(i.getOrderID());
			item.setTeacherName(i.getCourseBean().getTeacherBean().getTeacherLastName()
					+ i.getCourseBean().getTeacherBean().getTeacherFirstName());
			item.setCourseName(i.getCourseBean().getCourseName());
			item.setCourseCategory(i.getCourseBean().getCourseCategory());
			item.setCoursePrice(i.getCoursePrice());
			item.setQty(i.getQty());
			item.setStatus(i.getItemStatus());
			item.setCourseID(i.getCourseID());
			items.add(item);
		}
		return items;
	}

	@Override
	public List<Order> getOrderByDate(String date1String, String date2String) {
		List<CorderBean> orders = null;

		Date date1 = Util.dateUtil(date1String);
		Long oneday = (long) (24 * 60 * 60 * 1000);
		if (date2String.isEmpty()) {
			Date date2 = new Date(date1.getTime() + oneday);
			orders = coRepo.getOrderByDate(date1, date2);
		} else {
			Date date2 = Util.dateUtil(date2String);
			date2 = new Date(date2.getTime());
			orders = coRepo.getOrderByDate(date1, date2);
		}
		List<Order> orders2 = new ArrayList<>();
		Order order = null;
		for (CorderBean o : orders) {
			order = new Order();
			order.setOrderID(o.getOrderID());
			order.setStudentID(o.getStudentID());
			order.setOrderPrice(o.getOrderPrice());
			order.setOrderDate(o.getOrderDate());
			order.setCancelDate(o.getCancelDate());
			order.setPaymentMethod(o.getMethod());
			order.setOrderStatus(o.getStatus());
			orders2.add(order);
		}
		return orders2;
	}

	@Override
	public Integer adminUpdateOrder(String orderID, String status) {
		return coRepo.adminUpdateORD(orderID, status);
	}

	@Override
	public Integer payOrder(String orderID, String status, String method) {
		CorderBean corderBean = coRepo.findById(orderID).get();
		delayQueue.remove(corderBean);
		return coRepo.updateStatus(orderID, status, method);
	}

	@Override
	public Page<Order> getPageOrder(Pageable pageable) {
		Page<CorderBean> result = coRepo.findAll(pageable);
		Page<Order> page = result.map(new Function<CorderBean, Order>() {
			@Override
			public Order apply(CorderBean o) {
				Order order = new Order();
				order.setOrderID(o.getOrderID());
				order.setStudentID(o.getStudentID());
				order.setOrderPrice(o.getOrderPrice());
				order.setOrderDate(o.getOrderDate());
				order.setCancelDate(o.getCancelDate());
				order.setPaymentMethod(o.getMethod());
				order.setOrderStatus(o.getStatus());
				return order;
			}

		});
		return page;
	}

	@Override
	public Page<Order> getPageOrderByDate(Pageable pageable, String date1String, String date2String) {
		Date date1 = Util.dateUtil(date1String);
		Date date = Util.dateUtil(date2String);
		Long oneday = (long) (24 * 60 * 60 * 1000);
		Date date2 = new Date(date.getTime()+oneday);
		Page<CorderBean> result = coRepo.getPageOrderByDate(date1, date2,pageable);
		Page<Order> page = result.map(new Function<CorderBean, Order>() {
			@Override
			public Order apply(CorderBean o) {
				Order order = new Order();
				order.setOrderID(o.getOrderID());
				order.setStudentID(o.getStudentID());
				order.setOrderPrice(o.getOrderPrice());
				order.setOrderDate(o.getOrderDate());
				order.setCancelDate(o.getCancelDate());
				order.setPaymentMethod(o.getMethod());
				order.setOrderStatus(o.getStatus());
				return order;
			}
		});
		
		return page;
	}
}
