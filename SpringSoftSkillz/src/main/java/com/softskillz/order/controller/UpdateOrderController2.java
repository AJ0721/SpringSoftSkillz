package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.order.model.OrderService;
import com.softskillz.order.model.OrderBean;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/updateOrder2")
public class UpdateOrderController2 {

    @Autowired
    private OrderService orderService;

    @PostMapping("/updatePage")
    public String updateOrderPage() {
        return "/order/updateOrder2";
    }
    @PostMapping("/updated")
    public ModelAndView updateOrder(
            @RequestParam("order_id") Integer orderId,
            @RequestParam("student_id") Integer studentId,
            @RequestParam("order_date") String orderDateString,
            @RequestParam("total_amount") Integer totalAmount,
            @RequestParam("order_status") String orderStatus,
            @RequestParam("shipping_address") String shippingAddress) {
        
      
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm[:ss]");
        LocalDateTime orderDate = LocalDateTime.parse(orderDateString, formatter);
      
        OrderBean order = new OrderBean();
        order.setOrderId(orderId);
        order.setStudentId(studentId);
        order.setOrderDate(orderDate);
        order.setTotalAmount(totalAmount);
        order.setOrderStatus(orderStatus);
        order.setShippingAddress(shippingAddress);

        orderService.updateOrder(order);

        return new ModelAndView("redirect:/showAllOrder/selectAllOrder");
    }
}
