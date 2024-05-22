package com.softskillz.productorder.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderItem;
import com.softskillz.productorder.model.OrderService;
import com.softskillz.productorder.model.ProductCartItem;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
@SessionAttributes(names = {"order"})
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    // 顯示搜尋框頁面
    @GetMapping
    public String showSearchPage() {
        return "/order/jsp/searchOrder.jsp"; // searchOrder.jsp 是搜尋框頁面
    }

    // 根據訂單 ID 顯示單個訂單的詳情頁面，使用查詢參數接收訂單ID
    @GetMapping("/search")
    public String getOrderById(@RequestParam("orderId") int orderId, Model model) {
        Order order = orderService.getById(orderId);
        if (order != null) {
            model.addAttribute("order", order);
            return "/dist/productorder/getOrderDetails.jsp"; // getOrder.jsp 是顯示訂單詳情的頁面
        } else {
            model.addAttribute("message", "訂單未找到");
            return "/dist/productorder/searchOrder.jsp"; // 如果找不到訂單，重定向回搜尋頁面並顯示訊息
        }
    }

    // 顯示所有訂單的頁面
    @GetMapping("/all")
    public String getOrderAll(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "/dist/productorder/getOrderAll.jsp"; // getOrderAll.jsp 是顯示所有訂單的頁面
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("order", new Order()); // Adding an empty Order object to avoid errors in the form
        return "/dist/productorder/insertOrder.jsp"; // insertOrder.jsp is the form page for creating orders
    }
    
    @PostMapping("/createOrder")
    public Order cccccc(@RequestParam String grandTotal){
    	System.out.println(grandTotal);
    	
    	
    	return null;
    	
    	
    	
    }
    @PostMapping("/create")
    public Order createOrder(@RequestBody Order order, HttpSession session) {
        // 假設我們從購物車中獲取產品列表
        List<ProductCartItem> cartItems = (List<ProductCartItem>) session.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Shopping cart is empty");
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

        // 在 session 中存儲訂單和訂單項目
        session.setAttribute("order", newOrder);
        session.setAttribute("orderItems", orderItems);

        // 清空購物車
        session.removeAttribute("cartItems");

        return newOrder; // 返回創建的訂單作為 JSON
    }
    
    // 查詢更新訂單的資料并返回JSON
    @GetMapping("/searchforupdate/{orderId}")
    public ResponseEntity<?> getOrderByIdForUpdate(@PathVariable("orderId") int orderId) {
        Order order = orderService.getById(orderId);
        if (order != null) {
            return ResponseEntity.ok(order); // 返回订单数据的JSON格式
        } else {
            return ResponseEntity.notFound().build(); // 如果订单未找到，返回404状态码
        }
    }

    // 更新訂單
    @PutMapping("/update")
    @ResponseBody
    public String updateOrder(@RequestParam("order_id") Integer orderId,
                              @RequestParam("student_id") Integer studentId,
                              @RequestParam("coupon_id") Integer couponId,
                              @RequestParam("order_date") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime orderDate,
                              @RequestParam("total_amount") Integer totalAmount,
                              @RequestParam("order_status") String orderStatus,
                              @RequestParam("payment_method") String paymentMethod,
                              @RequestParam("shipment_date") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime shipmentDate,
                              @RequestParam("shipment_status") String shipmentStatus,
                              @RequestParam("shipping_address") String shippingAddress,
                              RedirectAttributes redirectAttributes) {

        // 使用实例调用getById方法
        Order order = orderService.getById(orderId);
        if (order != null) {
            order.setStudentId(studentId);
            order.setCouponId(couponId);
            order.setOrderDate(orderDate);
            order.setTotalAmount(totalAmount);
            order.setOrderStatus(orderStatus);
            order.setPaymentMethod(paymentMethod);
            order.setShipmentDate(shipmentDate);
            order.setShipmentStatus(shipmentStatus);
            order.setShippingAddress(shippingAddress);

            orderService.updateOrder(order);
            redirectAttributes.addFlashAttribute("successMessage", "訂單更新成功！");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "訂單未找到！");
        }
        return "redirect:/order/all";
    }

    // 處理刪除訂單的請求
    @DeleteMapping("/delete/{orderId}")
    public String deleteOrder(@PathVariable int orderId, Model model) {
        orderService.deleteOrder(orderId);
        return "redirect:/order/all"; // 刪除後重定向到訂單列表頁面
    }

    @GetMapping("/orderHistory")
    public String orderHistory(Model model) {
        // 獲取會員訂單歷史紀錄
        // model.addAttribute("orders", orderService.getOrdersByUser(userId));
        return "elearning/productorder/orderhistory.html";
    }
}
