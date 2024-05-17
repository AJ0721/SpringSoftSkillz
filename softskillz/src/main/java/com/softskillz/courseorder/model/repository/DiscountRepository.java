package com.softskillz.courseorder.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.softskillz.courseorder.model.bean.DiscountBean;

public interface DiscountRepository extends JpaRepository<DiscountBean, String> {

}
