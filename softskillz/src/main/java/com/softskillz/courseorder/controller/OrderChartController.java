package com.softskillz.courseorder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.courseorder.model.bean.MonthlySales;
import com.softskillz.courseorder.model.service.impl.CourseOrderServiceImpl;

@RestController
@RequestMapping("/api/orders")
public class OrderChartController {

	@Autowired
    private CourseOrderServiceImpl coService;

    @GetMapping("/monthly-sales")
    public List<MonthlySales> getMonthlySales() {
        return coService.getMonthlySales();
    }
}
