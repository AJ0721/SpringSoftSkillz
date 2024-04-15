package com.softskillz.courseorder.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.service.OrderServiceInterface;
import com.softskillz.util.LineUtil;

@Controller
@SessionAttributes(names = { "cart", "orders", "orderID", "total" })
public class OrderController {

	@Autowired
	private OrderServiceInterface service;

	@GetMapping("/order.do")
	public String processAction() {
		return "courseorder/jsp/MyOrder";
	}

	// line pay
	@PostMapping("/addToOrder")
	public String addToOrder(@RequestParam("total") Integer total) {
		return "";
	}

	@GetMapping("/doOrder")
	public String doOrder(Model m, SessionStatus status) {
		Integer total = (Integer) m.getAttribute("total");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart");
		String orderID = (String) m.getAttribute("orderID");
		CorderBean corderBean = new CorderBean();
		corderBean.setOrderID(orderID);
		corderBean.setStudentID(1);// 從session要使用者資料
		corderBean.setOrderDate(new Date(System.currentTimeMillis()));
		corderBean.setOrderPrice(total);
		corderBean.setMethod("Line Pay");
		corderBean.setStatus("已付款");
		service.insertORD(corderBean, cart);
		status.setComplete();
		return "redirect:getOrder";
	}

	@GetMapping("/getOrder")
	public String getOrder(Model m) {
//		m.getAttribute("student");
		Integer studentID = 1 ;//先頂著
		List<Order> orders = service.selsctUserAllORD(studentID);
		m.addAttribute("orders", orders);
		return "redirect:order.do";
	}

	@PostMapping("/cancelOrder")
	public String cancelOrder(@RequestBody Map<String, String> map) {
		String orderID = map.get("orderID");
		service.cancelORD(orderID);
		return "redirect:getOrder";
	}

	@GetMapping("/doOrderInfo")
	public String doOrderInfo(@RequestParam("orderID") String orderID, Model m) {
		System.out.println("orderID" + orderID);
		List<ItemInfo> items = service.getItem(orderID);
		System.out.println(items);
		m.addAttribute("items", items);
		return "courseorder/jsp/ItemInfo";
	}

}
