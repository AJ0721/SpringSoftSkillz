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
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
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

import java.io.IOException;
import java.util.Map;

@Slf4j
@Controller
public class LinePayController {

    private static final String CHANNEL_ID = "2005240710";
    private static final String CHANNEL_SECRET = "5bc37ed2718a69e0eb4227a716f44636";
    private static final String LINE_PAY_URL = "https://sandbox-api-pay.line.me/v2/payments/request";
    private static final String CONFIRM_URL = "http://localhost:8080/LinePayConV2";

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private OrderService orderService;


    /**
     * 發送付款請求到 Line Pay
     *
     * @param requestBody 請求的參數，包含 total 金額
     * @param session HTTP 會話物件
     * @return 返回 Line Pay 付款頁面的 URL
     */
    @PostMapping(path = "/LinePayReqV2", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> requestPayment(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
        Integer total = requestBody.get("total");
        Integer orderId = (Integer) session.getAttribute("orderId");
        session.setAttribute("total", total);

        LinePayRequest linePayRequest = new LinePayRequest(total, "TWD", String.valueOf(orderId), "商品", CONFIRM_URL);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String requestJson = objectMapper.writeValueAsString(linePayRequest);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.add("X-LINE-ChannelId", CHANNEL_ID);
            headers.add("X-LINE-ChannelSecret", CHANNEL_SECRET);

            HttpEntity<String> requestEntity = new HttpEntity<>(requestJson, headers);
            ResponseEntity<String> responseEntity = restTemplate.exchange(LINE_PAY_URL, HttpMethod.POST, requestEntity,
                    String.class);

            JsonNode jsonResponse = objectMapper.readTree(responseEntity.getBody());
            String returnCode = jsonResponse.get("returnCode").asText();
            //log.info("Line Pay 回應：{}", jsonResponse);

            if (returnCode.equals("0000")) {
                String paymentUrl = jsonResponse.get("info").get("paymentUrl").get("web").asText();
                return ResponseEntity.ok(paymentUrl);
            } else {
                //log.error("呼叫 Line Pay API 失敗，錯誤碼：{}", returnCode);
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("呼叫 Line Pay API 失敗");
            }
        } catch (IOException e) {
            //log.error("序列化 LinePayRequest 失敗", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("序列化 LinePayRequest 失敗");
        }
    }


    /**
     * 接收 Line Pay 的付款確認通知
     *
     * @param transactionId 交易 ID
     * @param session HTTP 會話物件
     * @param model Spring MVC 的 Model
     * @return 返回訂單詳情頁面
     */
    @GetMapping("/LinePayConV2")
    public String confirmPayment(@RequestParam("transactionId") String transactionId, HttpSession session,
            Model model) {
        //log.info("確認付款，交易編號：{}", transactionId);

        Integer total = (Integer) session.getAttribute("total");
        String confirmUrl = String.format("https://sandbox-api-pay.line.me/v2/payments/%s/confirm", transactionId);
        LinePayConfirmation confirmation = new LinePayConfirmation(total, "TWD");

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String confirmationJson = objectMapper.writeValueAsString(confirmation);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.add("X-LINE-ChannelId", CHANNEL_ID);
            headers.add("X-LINE-ChannelSecret", CHANNEL_SECRET);

            HttpEntity<String> requestEntity = new HttpEntity<>(confirmationJson, headers);
            //log.info("向 Line Pay 發送確認請求...");
            ResponseEntity<String> responseEntity = restTemplate.exchange(confirmUrl, HttpMethod.POST, requestEntity,
                    String.class);

            JsonNode jsonResponse = objectMapper.readTree(responseEntity.getBody());
            String returnCode = jsonResponse.get("returnCode").asText();
            //log.info("Line Pay 回應：{}", returnCode);

            if (returnCode.equals("0000")) {
                Integer orderId = (Integer) session.getAttribute("orderId");
                Order order = orderService.findOrderById(orderId);
                if (order != null) {
                    order.setOrderStatus("支付成功");
                    Order updatedOrder = orderService.updateOrder(order);
                    model.addAttribute("order", updatedOrder);
                    session.removeAttribute("cart");
                    session.removeAttribute("orderId");
                    session.removeAttribute("total");
                    //log.info("付款成功，訂單編號：{}", orderId);
                } else {
                    //log.warn("訂單不存在，訂單編號：{}", orderId);
                }
            } else {
                //log.error("付款失敗，錯誤碼：{}", returnCode);
            }
        } catch (IOException e) {
            //log.error("序列化 LinePayConfirmation 失敗", e);
        }
        return "/elearning/productorder/orderdetail.html";
    }

}
