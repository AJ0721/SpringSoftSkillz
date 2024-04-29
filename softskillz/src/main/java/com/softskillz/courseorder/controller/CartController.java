package com.softskillz.courseorder.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.service.impl.CourseServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("coursecart")
public class CartController {

	@Autowired
	private CourseServiceImpl cService;

	@GetMapping("/Cart.do")
	public String processAction() {
		return "courseorder/jsp/Cart2.jsp";
	}

	@PostMapping("/addToCart")
	public String addToCart(@RequestBody Map<String, Integer> map, Model m, HttpSession session) {

		System.out.println(map);
		Course2 course = cService.getCourseById(map.get("cid"));
		Integer quantity = map.get("quantity");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
		if (cart == null) {
			cart = new HashMap<Integer, CartItem>();
		}
		CartItem cartItem = new CartItem();
		cartItem.setCourse(course);
		;
		cartItem.setQuantity(quantity);
		cart.put(cart.size(), cartItem);
		session.setAttribute("cart", cart);
		return "redirect:Cart.do";
	}

	@PostMapping("/updateCart")
	public String updateCart(@RequestBody Map<String, Integer> map, Model m, HttpSession session) {
		Integer cartItemId = map.get("cartItemId");
		Integer quantity = map.get("quantity");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
		quantity = quantity / cart.get(cartItemId).getCourse().getPrice();
		CartItem cartItem = cart.get(cartItemId);
		cartItem.setQuantity(quantity);
		cart.put(cartItemId, cartItem);
		session.setAttribute("cart", cart);
		return "redirect:Cart.do";
	}

	@PostMapping("/removeCart")
	public String removeCart(@RequestBody Map<String, Integer> map, Model m,HttpSession session) {
		Integer cartItemId = map.get("cartItemId");
		System.out.println(cartItemId);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
		cart.remove(cartItemId);
		session.setAttribute("cart", cart);
		return "redirect:Cart.do";

	}

	@GetMapping("/clearCart")
	public String clearCart(SessionStatus status,HttpSession session) {
		session.removeAttribute("cart");
		status.setComplete();
		return "redirect:Cart.do";
	}
}
