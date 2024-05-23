package com.softskillz.productorder.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.productorder.model.LinePayConfirmation;
import com.softskillz.productorder.model.LinePayRequest;
import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
import org.springframework.web.servlet.HandlerMapping;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
@Controller
public class LinePayController {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private OrderService orderService;

    private static final String ChannelId = "2005240710";
    private static final String ChannelSecret = "5bc37ed2718a69e0eb4227a716f44636";
    private static final String LINE_PAY_URL = "https://sandbox-api-pay.line.me/v2/payments/request";

    private static final AtomicInteger counter = new AtomicInteger(1); // Simple counter for generating order IDs
    @Qualifier("stompWebSocketHandlerMapping")
    @Autowired
    private HandlerMapping stompWebSocketHandlerMapping;

    @PostMapping(path = "/LinePayReqV2", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> requestPayment(@RequestBody Map<String, Integer> map, HttpSession session)
            throws IOException {
        Integer total = map.get("total");
        Integer orderId = map.get("orderId");
        session.setAttribute("total", total);
        session.setAttribute("orderId", orderId);

        LinePayRequest item = new LinePayRequest(total, "TWD", String.valueOf(orderId), "商品",
                "http://localhost:8080/LinePayConV2");

        ObjectMapper om = new ObjectMapper();
        String jsonStr = om.writeValueAsString(item);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("X-LINE-ChannelId", ChannelId);
        headers.add("X-LINE-ChannelSecret", ChannelSecret);

        HttpEntity<String> reqEntity = new HttpEntity<>(jsonStr, headers);
        ResponseEntity<String> repEntity = restTemplate.exchange(LINE_PAY_URL, HttpMethod.POST, reqEntity,
                String.class);

        JsonNode jsonResponse = om.readTree(repEntity.getBody());
        String returnCode = jsonResponse.get("returnCode").asText();
        System.out.println("r:" + jsonResponse);
        String url = null;
        if (returnCode.equals("0000")) {
            url = jsonResponse.get("info").get("paymentUrl").get("web").asText();
        }
        return ResponseEntity.ok().body(url);
    }

    @GetMapping("/LinePayConV2")
    public String confirmPayment(@RequestParam("transactionId") String transactionId, HttpSession session, Model model)
            throws IOException {
        System.out.println("11111111111111");

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
        System.out.println("123123213213");
        ResponseEntity<String> repEntity = restTemplate.exchange(conUrl, HttpMethod.POST, reqEntity, String.class);
        JsonNode jsonResponse = om.readTree(repEntity.getBody());
        String returnCode = jsonResponse.get("returnCode").asText();
        System.out.println(returnCode);

        if (returnCode.equals("0000")) {
            Integer orderId = (Integer) session.getAttribute("orderId");
            Order order = orderService.findOrderById(orderId);
            if (order != null) {
                order.setOrderStatus("支付成功");
                Order order2 = orderService.updateOrder(order);
                model.addAttribute("order", order2);
                session.removeAttribute("cart");
                session.removeAttribute("orderId");
                session.removeAttribute("total");
                System.out.println("0000");
            }
        }
        return "/elearning/productorder/orderdetail.html";
    }
}
