package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.order.model.OrderService;
import com.softskillz.order.model.OrderBean;

@Controller
@RequestMapping("/updateOrder1")
public class UpdateOrderController1 {

    @Autowired
    private OrderService orderService;
    
    @PostMapping("/update")
    public String updateOrderPage() {
     return "/order/updateOrder1";
    }
    @PostMapping("/updated")
    public String updateOrder(@RequestParam("order_id") Integer orderId, Model model) {
        OrderBean order = orderService.getOrderById(orderId);
        if (order != null) {
            model.addAttribute("order", order);
            return "/order/updateOrder2"; 
        } else {
            return "/order/updateOrder2";
        }
   }
}
