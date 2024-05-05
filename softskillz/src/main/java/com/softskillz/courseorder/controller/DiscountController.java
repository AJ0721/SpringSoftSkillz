package com.softskillz.courseorder.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.courseorder.model.bean.DiscountBean;
import com.softskillz.courseorder.model.service.impl.DiscountServiceImpl;

@Controller
@RequestMapping("/coursediscount")
public class DiscountController {

	@Autowired
	private DiscountServiceImpl disService;

	@GetMapping("/test")
	public String processAction() {
		return "/courseorder/admin/coursediscount.html";
	}

	@GetMapping("/testd")
	@ResponseBody
	public Map<Integer, Double> getDiscount() {
		Map<Integer, Double> discount = disService.getDiscount();
//		System.out.println(discount);
		return discount;
	}

	@GetMapping
	@ResponseBody
	public List<DiscountBean> allDiscount() {
		List<DiscountBean> discountList = disService.allDiscount();
		return discountList;
	}

	@PostMapping
	@ResponseBody
	public DiscountBean addDiscount(@RequestBody DiscountBean discountBean) {
		System.out.println(discountBean);
		DiscountBean resultBean = disService.addDiscount(discountBean);
//		System.out.println(addDiscount);
		return resultBean;
	}

	@PutMapping
	@ResponseBody
	public DiscountBean updateDis(@RequestBody DiscountBean discountBean) {
		DiscountBean resultBean = disService.updateDiscount(discountBean);
		return resultBean;
	}

	@DeleteMapping("/{disID}")
	@ResponseBody
	public String deleteDis(@PathVariable("disID") Integer disID) {
		disService.deleteDiscount(disID);
		return "";
	}

}
