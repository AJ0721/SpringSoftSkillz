package com.softskillz.courseorder.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.Course2;

@Controller
@SessionAttributes(names = { "cart","course" })
public class CartController {
		
	@GetMapping("/Cart.do")
	public String processAction() {
		return "courseorder/jsp/Cart";
	}
	
	@GetMapping("/addToCart")
	public String addToCart(@RequestParam("quantity") Integer quantity,Model m ) {
		
		Course2 course = (Course2) m.getAttribute("course");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart") ;
		if(cart == null) {
			cart = new HashMap<>();
		}
		CartItem cartItem = new CartItem();
		cartItem.setCourse(course);;
		cartItem.setQuantity(quantity);
		cart.put(cart.size(), cartItem);
		m.addAttribute("cart",cart);
		return "redirect:Cart.do";
	}
	
	@PostMapping("/updateCart")
	public String updateCart(@RequestBody Map<String, Integer> map , Model m) {
		Integer cartItemId = map.get("cartItemId");
		Integer quantity = map.get("quantity");
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart") ;
		quantity = quantity/cart.get(cartItemId).getCourse().getPrice();
		CartItem cartItem = cart.get(cartItemId);
		cartItem.setQuantity(quantity);
		cart.put(cartItemId, cartItem);
		m.addAttribute("cart", cart);
		return "redirect:Cart.do";
	}
	
	@PostMapping("/removeCart")
	public String removeCart(@RequestBody Map<String, Integer> map , Model m) {
		Integer cartItemId = map.get("cartItemId");
		System.out.println(cartItemId);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart") ;
		cart.remove(cartItemId);
		m.addAttribute("cart", cart);
		return "redirect:Cart.do";

	}
	
	@GetMapping("/clearCart")
	public String clearCart(SessionStatus status) {
		status.setComplete();
		return "redirect:Cart.do";
	}
}
