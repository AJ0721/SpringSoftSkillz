package com.softskillz.courseorder.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.service.impl.CourseOrderServiceImpl;

@Controller
@RequestMapping("/adminorder")
public class AdminOrderController {

	@Autowired
	private CourseOrderServiceImpl coService;

	@GetMapping("/adorder.do")
	public String processAction() {
		return "/dist/courseorder/backcourseorder.html";
	}

	@ResponseBody
	public List<Order> getOrders(Model m) {

		List<Order> orders = coService.getAllORD();
		return orders;
	}

	@GetMapping("/{d1}/{d2}")
	@ResponseBody
	public Page<Order> selectOrderByDate(@PathVariable("d1") String date1,
			@PathVariable(value = "d2", required = false) String date2,
			@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "orderDate") String sort,
			@RequestParam(value = "direction", defaultValue = "ASC") String sortDirection) {
		System.out.println("d1:" + date1);
		System.out.println("d2:" + date2);

		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<Order> pageOrder = coService.getPageOrderByDate(pageable, date1, date2);
		System.out.println(pageOrder.getContent());
		return pageOrder;
	}

	@GetMapping("/clearDate")
	public String clearDate(Model m, SessionStatus status) {
		m.getAttribute("date");
		status.setComplete();
		return "forward:/adminorder";
	}

	@PutMapping("/{oid}")
	@ResponseBody
	public String cancelORD(@PathVariable("oid") String orderID, Model m) {
		Integer count = coService.adminUpdateOrder(orderID, "已取消");
		Map<String, String> dateMap = (Map<String, String>) m.getAttribute("date");
		if (dateMap != null) {
			List<Order> orders = coService.getOrderByDate(dateMap.get("date1"), dateMap.get("date2"));
			m.addAttribute("orders", orders);
		} else {
			List<Order> orders = coService.getAllORD();
			m.addAttribute("orders", orders);
		}
		return count.toString();
	}

	
	@DeleteMapping("/{oid}")
	@ResponseBody
	public String deleteORD(@PathVariable("oid") String orderID, Model m) {
		coService.deleteByID(orderID);
		Map<String, String> dateMap = (Map<String, String>) m.getAttribute("date");
		if (dateMap != null) {
			List<Order> orders = coService.getOrderByDate(dateMap.get("date1"), dateMap.get("date2"));
			m.addAttribute("orders", orders);
		} else {
			List<Order> orders = coService.getAllORD();
			m.addAttribute("orders", orders);
		}
		return "ok";
	}
	
	
	@GetMapping("pending")
	@ResponseBody
	public Page<Order> pagePendingOrder(@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "orderDate") String sort,
			@RequestParam(value = "direction", defaultValue = "ASC") String sortDirection,
			@RequestParam(value = "status", defaultValue = "待處理") String status) {
		System.out.println(status);
		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<Order> pageOrder = coService.getPageByStatus(pageable,status);
		System.out.println(pageOrder.getContent());
		return pageOrder;
	}

	@GetMapping("/{oid}")
	@ResponseBody
	public List<ItemInfo> adminOrderInfo(@PathVariable("oid") String orderID, Model m) {
		System.out.println("orderID:" + orderID);
		List<ItemInfo> items = coService.getItem(orderID);
		System.out.println(items);
		m.addAttribute("items", items);
		return items;
	}

	@GetMapping
	@ResponseBody
	public Page<Order> pageOrder(@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "orderDate") String sort,
			@RequestParam(value = "direction", defaultValue = "ASC") String sortDirection) {

		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<Order> pageOrder = coService.getPageOrder(pageable);
		System.out.println(pageOrder.getContent());
		return pageOrder;
	}



}
