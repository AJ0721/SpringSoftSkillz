package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.order.model.OrderService;

@Controller
@RequestMapping("/deleteOrder")
public class DeleteOrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/delete")
    public String deleteOrder(@RequestParam("order_id") Integer orderId) {
        orderService.deleteOrderById(orderId);

        return "redirect:/showAllOrder/selectAllOrder";
    }
}
