package com.softskillz.productorder.controller;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.productorder.model.ProductCartItem;
import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderItem;
import com.softskillz.productorder.model.OrderItemService;
import com.softskillz.productorder.model.OrderService;
import com.softskillz.productorder.model.LinePayRequest;
import com.softskillz.productorder.model.LinePayConfirmation;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LinePayController {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemService orderItemService;

    private static final String ChannelId = "2005240710";
    private static final String ChannelSecret = "5bc37ed2718a69e0eb4227a716f44636";
    private static final String LINE_PAY_URL = "https://sandbox-api-pay.line.me/v2/payments/request";

    private static final AtomicInteger counter = new AtomicInteger(1); // Simple counter for generating order IDs

    @PostMapping(path = "/LinePayReqV2", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> requestPayment(@RequestBody Map<String, Integer> map, HttpSession session)
            throws JsonProcessingException {
        Integer total = map.get("total");
        session.setAttribute("total", total);
        String orderId = "ORDER-" + counter.getAndIncrement(); // Using a simple counter to generate order ID
        session.setAttribute("orderId", orderId);

        LinePayRequest item = new LinePayRequest(total, "TWD", orderId, "Product Name", "https://yourwebsite.com/LinePayConV2");

        ObjectMapper om = new ObjectMapper();
        String jsonStr = om.writeValueAsString(item);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("X-LINE-ChannelId", ChannelId);
        headers.add("X-LINE-ChannelSecret", ChannelSecret);

        HttpEntity<String> reqEntity = new HttpEntity<>(jsonStr, headers);
        ResponseEntity<String> repEntity = restTemplate.exchange(LINE_PAY_URL, HttpMethod.POST, reqEntity, String.class);

        JsonNode jsonResponse = om.readTree(repEntity.getBody());
        String returnCode = jsonResponse.get("returnCode").asText();
        String url = null;
        if (returnCode.equals("0000")) {
            url = jsonResponse.get("info").get("paymentUrl").get("web").asText();
        }
        return ResponseEntity.ok().body(url);
    }

    @GetMapping("/LinePayConV2")
    public String confirmPayment(@RequestParam("transactionId") String transactionId, HttpSession session, Model model)
            throws JsonProcessingException {
        Integer total = (Integer) session.getAttribute("total");
        String conUrl = "https://sandbox-api-pay.line.me/v2/payments/" + transactionId + "/confirm";
        LinePayConfirmation confirmItem = new LinePayConfirmation(total, "TWD");

        ObjectMapper om = new ObjectMapper();
        String jsonStr = om.writeValueAsString(confirmItem);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("X-LINE-ChannelId", ChannelId);
        headers.add("X-LINE-ChannelSecret", ChannelSecret);

        HttpEntity<String> reqEntity = new HttpEntity<>(jsonStr, headers);

        ResponseEntity<String> repEntity = restTemplate.exchange(conUrl, HttpMethod.POST, reqEntity, String.class);
        JsonNode jsonResponse = om.readTree(repEntity.getBody());
        String returnCode = jsonResponse.get("returnCode").asText();

        if (returnCode.equals("0000")) {
            Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
            Order order = new Order();
            order.setStudentId(1); // Get user data from session
            order.setOrderDate(LocalDateTime.now());
            order.setTotalAmount(total);
            order.setPaymentMethod("Line Pay");
            order.setOrderStatus("Paid");
            Order savedOrder = orderService.insertOrder(order);

            for (Map.Entry<Integer, ProductCartItem> entry : cart.entrySet()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(savedOrder.getOrderId());
                orderItem.setProductId(entry.getValue().getProduct().getProductId());
                orderItem.setQuantity(entry.getValue().getQuantity());
                orderItem.setProductPrice(entry.getValue().getProduct().getProductPrice().intValue());
                orderItem.setSubTotal(entry.getValue().getQuantity() * entry.getValue().getProduct().getProductPrice().intValue());
                orderItemService.createOrderItem(orderItem);
            }

            model.addAttribute("order", savedOrder);
            session.removeAttribute("cart");
            session.removeAttribute("orderId");
            session.removeAttribute("total");
        }

        return "orderdetail.html"; // Return the view name for the order confirmation page
    }
}