package com.softskillz.courseorder.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.softskillz.courseorder.model.bean.DiscountBean;

public interface DiscountService {
	
	DiscountBean addDiscount(DiscountBean discountBean);
	
	void deleteDiscount(String disID);
	
	DiscountBean updateDiscount(DiscountBean discountBean);
	
	Map<String, Double> getDiscount();
	
	List<DiscountBean> allDiscount();
	
	Page<DiscountBean> getDiscountPage(Pageable pageable);
	
	DiscountBean getByID(String disID);
}
