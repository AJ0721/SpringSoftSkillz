package com.softskillz.courseorder.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.service.impl.CourseServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/coursecart")
public class CartController {

	@Autowired
	private CourseServiceImpl cService;

	@GetMapping("/cart.do")
	public String processAction() {
		return "/elearning/courseorder/cart.html";
	}

	@GetMapping
	@ResponseBody
	public Map<Integer, CartItem> getCart(HttpSession session) {
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("coursecart");
		if (cart == null) {
			cart = new HashMap<Integer, CartItem>();
		}
		return cart;
	}

	@PostMapping("/{cid}/{qty}")
	@ResponseBody
	public String addToCart(@PathVariable("cid") Integer cid,@PathVariable("qty")Integer quantity, Model m, HttpSession session) {

		Course2 course = cService.getCourseById(cid);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("coursecart");
		if (cart == null) {
			cart = new HashMap<Integer, CartItem>();
		}
		CartItem cartItem = new CartItem();
		cartItem.setCourse(course);
		;
		cartItem.setQuantity(quantity);
		cart.put(cart.size(), cartItem);
		session.setAttribute("coursecart", cart);
		return "1";
	}

	@PutMapping("/{id}/{qty}")
	@ResponseBody
	public String updateCart(@PathVariable("id") Integer cartItemId, @PathVariable("qty") Integer quantity,
			HttpSession session) {
		System.out.println("123");
		System.out.println("id"+cartItemId);
		System.out.println("qty"+ quantity);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("coursecart");
		CartItem cartItem = cart.get(cartItemId);
		cartItem.setQuantity(quantity);
		cart.put(cartItemId, cartItem);
		session.setAttribute("coursecart", cart);
		return "";
	}

	@DeleteMapping("/{cid}")
	@ResponseBody
	public String removeCart(@PathVariable("cid") Integer cartItemId, Model m, HttpSession session) {
		System.out.println(cartItemId);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("coursecart");
		cart.remove(cartItemId);
		session.setAttribute("coursecart", cart);
		return "redirect:Cart.do";

	}

	@GetMapping("/clearCart")
	public String clearCart(SessionStatus status, HttpSession session) {
		session.removeAttribute("coursecart");
		status.setComplete();
		return "redirect:Cart.do";
	}
}
