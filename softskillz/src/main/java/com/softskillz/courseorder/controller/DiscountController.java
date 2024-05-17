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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.courseorder.model.bean.DiscountBean;
import com.softskillz.courseorder.model.service.impl.DiscountServiceImpl;

@Controller
@RequestMapping("/coursediscount")
public class DiscountController {

	@Autowired
	private DiscountServiceImpl disService;

	@GetMapping("/discount.do")
	public String processAction() {
		return "/dist/courseorder/backcoursediscount.html";
	}

	@GetMapping("/testd")
	@ResponseBody
	public Map<String, Double> getDiscount() {
		Map<String, Double> discount = disService.getDiscount();
//		System.out.println(discount);
		return discount;
	}

//	@GetMapping
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
	public String deleteDis(@PathVariable("disID") String disID) {
		disService.deleteDiscount(disID);
		return "";
	}

	
	@GetMapping
	@ResponseBody
	public Page<DiscountBean> getDiscountPage(@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "disPercent") String sort,
			@RequestParam(value = "direction", defaultValue = "DESC") String sortDirection) {

		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<DiscountBean> discountPage = disService.getDiscountPage(pageable);
		return discountPage;

	}
	
	@GetMapping("/{disID}")
	@ResponseBody
	public DiscountBean getDis(@PathVariable("disID") String disID) {
		return disService.getByID(disID);
	}

}
