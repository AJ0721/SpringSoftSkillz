package com.softskillz.courseorder.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.service.impl.CourseOrderServiceImpl;



@Controller
@SessionAttributes(names = { "orders", "date" })
@RequestMapping("/adminorder")
public class AdminOrderController {

	@Autowired
	private CourseOrderServiceImpl coService;

	@GetMapping("/adorder.do")
	public String processAction() {
		return "courseorder/admin/adminorder.html";
	}

	@GetMapping
	@ResponseBody
	public List<Order> getOrders(Model m) {

		List<Order> orders = coService.getAllORD();
//		m.addAttribute("orders", orders);
		return orders;
	}

	@GetMapping("/{d1}/{d2}")
	@ResponseBody
	public List<Order> selectOrderByDate(@PathVariable("d1") String date1,@PathVariable(value = "d2",required = false) String date2) {

		List<Order> orders = coService.getOrderByDate(date1, date2);
		return orders;
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

	@GetMapping("/{oid}")
	public String adminOrderInfo(@PathVariable("oid") String orderID, Model m) {
		System.out.println("orderID" + orderID);
		List<ItemInfo> items = coService.getItem(orderID);
		System.out.println(items);
		m.addAttribute("items", items);
		return "courseorder/admin/AdminOInfo.jsp";
	}
}