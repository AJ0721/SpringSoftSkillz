package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.order.model.OrderBean;
import com.softskillz.order.model.OrderService;

@Controller
@RequestMapping("/showOrder")
public class GetOrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/getOrder")
    public String getOrder() {
       
        return "/order/getOrder"; 
    }

    @PostMapping("/selectOrder")
    public String getOrder(@RequestParam("order_id") String orderIdStr, Model model) {
        if (orderIdStr != null && !orderIdStr.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderBean order = orderService.getOrderById(orderId);
                if (order != null) {
                    model.addAttribute("order", order);
                    return "/order/getOrderDetails"; 
                } else {
                    model.addAttribute("error", "No order found with ID: " + orderId);
                    return "/order/getOrder"; 
                }
            } catch (NumberFormatException e) {
                model.addAttribute("error", "Order ID is not a valid number: " + orderIdStr);
                return "order/getOrder"; 
            }
        } else {
            model.addAttribute("error", "Order ID parameter is missing");
            return "order/getOrder"; 
        }
    }
}
