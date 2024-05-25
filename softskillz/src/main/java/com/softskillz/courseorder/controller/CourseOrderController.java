package com.softskillz.courseorder.controller;

import java.util.Date;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.account.model.bean.StudentBean;
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
	public String processAction(HttpSession session) {
		StudentBean student =(StudentBean) session.getAttribute("studentData");
		if(student == null) {
			return "forward:/student/student-loginPage";
		}
		return "/elearning/courseorder/courseorder.html";
	}

	@GetMapping("/orderdetail")
	public String processPayAction() {
		return "/elearning/courseorder/orderdetail.html";
	}

	@PostMapping("/{tot}")
	@ResponseBody
	public String doOrder(@PathVariable("tot")Integer total, HttpSession session) {

		StudentBean studentBean = (StudentBean) session.getAttribute("studentData");
//
		Integer studentID = studentBean.getStudentId();

		Long time = System.currentTimeMillis();
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("coursecart");
		String orderID = LineUtil.getOrderID(time);
		CorderBean corderBean = new CorderBean();
		corderBean.setOrderID(orderID);
		corderBean.setStudentID(studentID);// 從session要使用者資料
		corderBean.setOrderDate(new Date(time));
		corderBean.setCancelDate(new Date(time + 30 * 60 * 1000));
		corderBean.setOrderPrice(total);
		corderBean.setStatus("未付款");
		coService.insertORD(corderBean, cart);
		session.removeAttribute("coursecart");
		return orderID;
	}

//	@GetMapping
	@ResponseBody
	public List<Order> getOrder(HttpSession session) {
		StudentBean studentBean = (StudentBean) session.getAttribute("studentData");
		Integer studentID = studentBean.getStudentId();
		List<Order> orders = coService.studentORD(studentID);
		return orders;
	}

	@PutMapping("/{oid}")
	@ResponseBody
	public String cancelOrder(@PathVariable("oid") String orderID) {
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

	@GetMapping
	@ResponseBody
	public Page<Order> pageOrder(@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "orderID") String sort,
			@RequestParam(value = "direction", defaultValue = "DESC") String sortDirection,
			@RequestParam(value = "status", defaultValue = "已付款") String status,HttpSession session) {
		StudentBean studentBean = (StudentBean) session.getAttribute("studentData");
		Integer studentID = studentBean.getStudentId();
		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<Order> pageOrder = coService.getPageByStudentID(pageable, studentID, status);
		System.out.println(status);
		System.out.println(pageOrder.getContent());
		return pageOrder;
	}

	@GetMapping("/date/{d1}/{d2}")
	@ResponseBody
	public Page<Order> getPageOrderByDate(@PathVariable("d1") String date1,
			@PathVariable(value = "d2", required = false) String date2,
			@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "orderDate") String sort,
			@RequestParam(value = "direction", defaultValue = "DESC") String sortDirection,
			@RequestParam(value = "status", defaultValue = "已付款") String status,HttpSession session) {
		System.out.println("d1:" + date1);
		System.out.println("d2:" + date2);
		StudentBean studentBean = (StudentBean) session.getAttribute("studentData");
		Integer studentID = studentBean.getStudentId();
		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<Order> pageOrder = coService.getPageByStudentIDAndDate(pageable, date1, date2,studentID,status);
		System.out.println(pageOrder.getContent());
		return pageOrder;
	}


}
