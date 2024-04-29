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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.account.model.StudentBean;
import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.Order;
import com.softskillz.courseorder.model.service.impl.CourseOrderServiceImpl;
import com.softskillz.util.LineUtil;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/courseorder")
public class CourseOrderController {

	@Autowired
	private CourseOrderServiceImpl coService;

	@GetMapping("/order.do")
	public String processAction() {
		return "courseorder/html/ordertest.html";
	}

	@GetMapping("/pay")
	public String processPayAction() {
		return "courseorder/html/paypage.html";
	}

	@PostMapping
	@ResponseBody
	public String doOrder(@RequestBody Map<String, Integer> map, SessionStatus status, HttpSession session) {

		Integer studentID = 1;
		StudentBean studentBean = (StudentBean) session.getAttribute("student");

		studentID = studentBean.getStudentId();

		Long time = System.currentTimeMillis();
		Integer total = map.get("total");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
		String orderID = LineUtil.getOrderID(time);
		CorderBean corderBean = new CorderBean();
		corderBean.setOrderID(orderID);
		corderBean.setStudentID(studentID);// 從session要使用者資料
		corderBean.setOrderDate(new Date(time));
		corderBean.setCancelDate(new Date(time + 30 * 60 * 1000));
		corderBean.setOrderPrice(total);
		corderBean.setMethod("");
		corderBean.setStatus("未付款");
		coService.insertORD(corderBean, cart);
		session.removeAttribute("cart");
		return orderID;
	}

	@GetMapping
	@ResponseBody
	public List<Order> getOrder(HttpSession session) {
		Integer studentID = 1;// 先頂著
//		StudentBean studentBean = (StudentBean) session.getAttribute("student");
//		studentID = studentBean.getStudentId();
		List<Order> orders = coService.studentORD(studentID);
		return orders;
	}

	@PutMapping("/{oid}")
	@ResponseBody
	public String cancelOrder(@PathVariable("oid") String orderID) {
//		String orderID = map.get("orderID");
		Integer cancelORD = coService.cancelORD(orderID);
		return cancelORD.toString();
	}

	@GetMapping("/{oid}")
	public String doOrderInfo(@PathVariable("oid") String orderID, Model m) {
		String orderStatus = coService.getORDByID(orderID).getOrderStatus();
		m.addAttribute("status", orderStatus);
		List<ItemInfo> items = coService.getItem(orderID);
		System.out.println(items);
		m.addAttribute("items", items);
		return "courseorder/jsp/ItemInfo.jsp";
	}

	@GetMapping("/payitem/{oid}")
	@ResponseBody
	public List<ItemInfo> getItem(@PathVariable("oid") String orderID) {
		List<ItemInfo> items = coService.getItem(orderID);
		return items;
	}

}
