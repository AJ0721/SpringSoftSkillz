package com.softskillz.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.softskillz.order.model.OrderBean;
import com.softskillz.order.model.OrderService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/order")
public class InsertOrderController {

    @Autowired
    private OrderService orderService;
    
    @GetMapping("/getOrder")
    public String getOrderPage() {
        // 逻辑代码
        return "/order/getOrder";
    }
    
    @PostMapping("/insert")
    public String insertOrderPage() {
     return "/order/insertOrder";
    }
    @PostMapping("/add")
    public String insertOrder(
            @RequestParam("student_id") Integer studentId,
            @RequestParam("order_date") String orderDateString,
            @RequestParam("total_amount") Integer totalAmount,
            @RequestParam("order_status") String orderStatus,
            @RequestParam("shipping_address") String shippingAddress) {

       
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm[:ss]");
        LocalDateTime orderDate = LocalDateTime.parse(orderDateString, formatter);

        OrderBean order = new OrderBean();
        order.setStudentId(studentId);
        order.setOrderDate(orderDate);
        order.setTotalAmount(totalAmount);
        order.setOrderStatus(orderStatus);
        order.setShippingAddress(shippingAddress);

        orderService.insertOrder(order);

        return "redirect:/showAllOrder/selectAllOrder";
    }
}
