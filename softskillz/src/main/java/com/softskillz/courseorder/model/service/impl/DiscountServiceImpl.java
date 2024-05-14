package com.softskillz.courseorder.model.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.softskillz.courseorder.model.bean.DiscountBean;
import com.softskillz.courseorder.model.repository.DiscountRepository;
import com.softskillz.courseorder.model.service.DiscountService;

@Service
public class DiscountServiceImpl implements DiscountService {

	private Map<Integer, Double> discountMap;

	@Autowired
	private DiscountRepository disRepo;

	@Override
	@CacheEvict(value = "discountMap", allEntries = true)
	public DiscountBean addDiscount(DiscountBean discountBean) {
		return disRepo.save(discountBean);
	}

	@Override
	@CacheEvict(value = "discountMap", key = "#disID")
	public void deleteDiscount(Integer disID) {
		disRepo.deleteById(disID);
	}

	@Override
	@CacheEvict(value = "discountMap", allEntries = true)
	public DiscountBean updateDiscount(DiscountBean discountBean) {
		return disRepo.save(discountBean);
	}

	@Override
	@Cacheable("discountMap")
	public Map<Integer, Double> getDiscount() {

		List<DiscountBean> discountList = disRepo.findAll();
		if (discountMap == null) {
			discountMap = new HashMap<Integer, Double>();
		}
		for (DiscountBean d : discountList) {
			discountMap.put(d.getDisID(), d.getDisPercent());
		}

		return discountMap;
	}

	@Override
	public List<DiscountBean> allDiscount() {
		return disRepo.findAll();
	}

	@Override
	public Page<DiscountBean> getDiscountPage(Pageable pageable) {
		Page<DiscountBean> page = disRepo.findAll(pageable);
		return page;
	}

	@Override
	public DiscountBean getByID(Integer disID) {

		DiscountBean discountBean = disRepo.findById(disID).get();
		return discountBean;
	}

}
