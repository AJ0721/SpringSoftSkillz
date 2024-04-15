package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.softskillz.order.model.OrderService;
import com.softskillz.order.model.OrderBean;

import java.util.List;

@Controller
@RequestMapping("/showAllOrder")
public class GetOrderAllController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/selectAllOrder")
    public String getAllOrders(Model model) {
        List<OrderBean> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "/order/getOrderAll"; 
    }
}
