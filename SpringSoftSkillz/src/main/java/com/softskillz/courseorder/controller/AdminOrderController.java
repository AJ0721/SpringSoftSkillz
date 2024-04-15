package com.softskillz.courseorder.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.service.OrderServiceInterface;

@Controller
@SessionAttributes(names = { "orders", "date" })
public class AdminOrderController {

	@Autowired
	private OrderServiceInterface service;

	@GetMapping("/Order.admin")
	public String processAction() {
		return "courseorder/admin/Orders";
	}

	@GetMapping("/getOrders")
	public String getOrders(Model m) {
		List<Order> orders = service.adminSelectAll();
		m.addAttribute("orders", orders);
		return "redirect:Order.admin";
	}

	@PostMapping("/dateSelectOrder")
	public String selectOrderByDate(@RequestBody Map<String, String> map, Model m) {
		String date1 = map.get("date1");
		String date2 = map.get("date2");
		List<Order> orders = service.adminSelectByDate(date1, date2);
		m.addAttribute("orders", orders);
		m.addAttribute("date", map);
		return "redirect:Order.admin";
	}

	@GetMapping("/clearDate")
	public String clearDate(Model m, SessionStatus status) {
		m.getAttribute("date");
		status.setComplete();
		return "forward:getOrders";
	}

	@PostMapping("/cancelORD")
	public String cancelORD(@RequestBody Map<String, String> map, Model m) {
		service.adminCancelORD(map.get("orderID"));
		Map<String, String> dateMap = (Map<String, String>) m.getAttribute("date");
		if (dateMap != null) {
			List<Order> orders = service.adminSelectByDate(dateMap.get("date1"), dateMap.get("date2"));
			m.addAttribute("orders", orders);
		} else {
			List<Order> orders = service.adminSelectAll();
			m.addAttribute("orders", orders);
		}
		return "redirect:Order.admin";
	}

	@PostMapping("/deleteORD")
	public String deleteORD(@RequestBody Map<String, String> map, Model m) {
		System.out.println(map.get("orderID"));
		service.deleteORD(map.get("orderID"));
		Map<String, String> dateMap = (Map<String, String>) m.getAttribute("date");
		if (dateMap != null) {
			List<Order> orders = service.adminSelectByDate(dateMap.get("date1"), dateMap.get("date2"));
			m.addAttribute("orders", orders);
		} else {
			List<Order> orders = service.adminSelectAll();
			m.addAttribute("orders", orders);
		}
		return "redirect:Order.admin";
	}

	@GetMapping("/adminOrderInfo")
	public String adminOrderInfo(@RequestParam("orderID") String orderID, Model m) {
		System.out.println("orderID" + orderID);
		List<ItemInfo> items = service.getItem(orderID);
		System.out.println(items);
		m.addAttribute("items", items);
		return "courseorder/admin/AdminOInfo";
	}
}
