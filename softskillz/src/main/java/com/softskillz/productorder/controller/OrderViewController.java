package com.softskillz.productorder.controller;

import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderItem;
import com.softskillz.productorder.model.OrderService;
import com.softskillz.productorder.model.ProductCartItem;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/order")
public class OrderViewController {

    private final OrderService orderService;

    public OrderViewController(OrderService orderService) {
        this.orderService = orderService;
    }

    // 顯示搜尋框頁面
    @GetMapping("/searchorder")
    public String showSearchPage() {
        return "/elearning/productorder/searchorder.html"; // 修改為 searchorder.html 頁面
    }

    // 根據訂單ID顯示單個訂單的詳情頁面，使用查詢參數接收訂單ID
    @GetMapping("/search")
    public String getOrderById(@RequestParam("orderId") int orderId, Model model) {
        Order order = orderService.getById(orderId);
        if (order != null) {
            model.addAttribute("order", order);
            return "/elearning/productorder/orderdetail.html"; // 修改為 orderdetail.html 頁面
        } else {
            model.addAttribute("message", "訂單未找到");
            return "redirect:/mall/frontend"; // 如果找不到訂單，重定向到商城頁面
        }
    }

    // 顯示所有訂單的頁面
    @GetMapping("/all")
    public String getOrderAll(Model model) {
        List<Order> orders = orderService.getAllOrders();
        for (Order cat : orders) {
            System.out.println("order: " + cat);
            System.out.println("order item: " + cat.getOrderId());
        }
        model.addAttribute("orders", orders);
        return "/dist/productorder/getOrderAll.jsp"; // getOrderAll.jsp 是顯示所有訂單的頁面
    }

    @GetMapping("/createPage")
    public String showCreateForm(Model model) {
        model.addAttribute("order", new Order());
        return "/dist/productorder/insertOrder.jsp"; // 指向你的表單頁面的路徑
    }

    @PostMapping("/create")
    public String createOrder(Order order, HttpSession session, Model model) {
        List<ProductCartItem> cartItems = (List<ProductCartItem>) session.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
            model.addAttribute("message", "購物車是空的");
            return "dist/productorder/insertOrder.jsp";
        }

        // 創建訂單項目
        Set<OrderItem> orderItems = cartItems.stream().map(cartItem -> {
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProduct().getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setProductPrice(cartItem.getProduct().getProductPrice().intValue());
            orderItem.setSubTotal(cartItem.getProduct().getProductPrice().intValue() * cartItem.getQuantity());
            orderItem.setOrder(order); // 設置訂單關聯
            return orderItem;
        }).collect(Collectors.toSet());

        order.setOrderItems(orderItems);

        // 計算訂單的總金額
        int totalAmount = orderItems.stream()
                .mapToInt(OrderItem::getSubTotal)
                .sum();
        order.setTotalAmount(totalAmount);

        // 設置當前日期時間為訂單日期
        order.setOrderDate(LocalDateTime.now());

        // 設置其他需要的屬性
        if (order.getOrderStatus() == null) {
            order.setOrderStatus("未付款");
        }
        if (order.getShipmentStatus() == null) {
            order.setShipmentStatus("未出貨");
        }

        Order newOrder = orderService.insertOrder(order);

        // 在session中存儲訂單和訂單項目
        session.setAttribute("order", newOrder);
        session.setAttribute("orderItems", orderItems);

        // 清空購物車
        session.removeAttribute("cartItems");

        // 添加所有訂單到模型中以便在 getOrderAll.jsp 顯示
        List<Order> orders = orderService.getAllOrders();

        model.addAttribute("orders", orders);

        // 重定向到顯示所有訂單的頁面
        return "redirect:/order/all";
    }

    //抓取訂單詳情資料的方法
    @GetMapping("/order/{orderId}")
    public String getOrderItemsByOrderId(@PathVariable("orderId") Integer orderId, Model model) {
        System.out.println("orderId: " + orderId);
        Order order = orderService.findOrderById(orderId);
        model.addAttribute("order", order);
        return "/elearning/productorder/orderdetail.html";
    }
}
