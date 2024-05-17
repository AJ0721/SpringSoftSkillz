package com.softskillz.courseorder.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.CorderBean;
import com.softskillz.courseorder.model.bean.DiscountBean;
import com.softskillz.courseorder.model.bean.ItemInfo;
import com.softskillz.courseorder.model.bean.test.Citem;
import com.softskillz.courseorder.model.bean.test.Item;
import com.softskillz.courseorder.model.service.impl.CourseOrderServiceImpl;
import com.softskillz.courseorder.model.service.impl.DiscountServiceImpl;
import com.softskillz.util.LineUtil;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LinePayTest {

	@Autowired
	private RestTemplate restTemplate;
	
	@Autowired
	private CourseOrderServiceImpl coService;
	
	@Autowired
	private DiscountServiceImpl disService;
	
	private static final String ChannelSecret = "4a91e36157b573b652b027d2b69935cb";
	private static final String ChannelId = "2003913073";

	@PostMapping(path = "/LinePayReq", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> reqest(@RequestBody Map<String, Integer> map, Model m)
			throws JsonProcessingException {
		Integer total = map.get("total");
		m.addAttribute("total", total);
		String url = null;
		String orderID = LineUtil.getOrderID(System.currentTimeMillis());
		m.addAttribute("orderID", orderID);
		Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart");
		String reqUrl = "https://sandbox-api-pay.line.me/v3/payments/request";
		String requestUri = "/v3/payments/request";
		String nonce = UUID.randomUUID().toString();
		ObjectMapper om1 = new ObjectMapper();
		Item item = LineUtil.getItem(cart, orderID, total);
		String jsonStr = om1.writeValueAsString(item);
		String signature = LineUtil.encrypt(ChannelSecret, ChannelSecret + requestUri + jsonStr + nonce);

		HttpHeaders headers = LineUtil.getHeaders(ChannelId, nonce, signature);
		HttpEntity<Item> reqEntity = new HttpEntity<>(item, headers);
		ResponseEntity<String> repEntity = restTemplate.exchange(reqUrl, HttpMethod.POST, reqEntity, String.class);
		System.out.println("jjjjjjjj"+repEntity.getBody());
		JsonNode jsonResponse = om1.readTree(repEntity.getBody());
		System.out.println("kkkkkkkkkkk"+jsonResponse);
		String returnCode = jsonResponse.get("returnCode").asText();
		if (returnCode.equals("0000")) {
			url = jsonResponse.get("info").get("paymentUrl").get("web").toString();
			System.out.println("re"+jsonResponse.get("returnCode").asText());
			System.out.println("in"+jsonResponse.get("info").get("paymentUrl").get("web").toString());
			System.out.println("url= "+url);
		}
		return ResponseEntity.ok().body(url);
	}

	@GetMapping("/LinePayCon")
	public String confirm(@RequestParam("transactionId") String transactionId, Model m,SessionStatus status) throws JsonProcessingException {
		Integer total = (Integer) m.getAttribute("total");
		String conUrl = "https://sandbox-api-pay.line.me/v3/payments/" + transactionId + "/confirm";
		Citem citem = new Citem();
		citem.setAmount(total);
		citem.setCurrency("TWD");

		ObjectMapper om1 = new ObjectMapper();
		String jsonStr = om1.writeValueAsString(citem);
		String requestUri = "/v3/payments/" + transactionId + "/confirm";
		String nonce = UUID.randomUUID().toString();
		String signature = LineUtil.encrypt(ChannelSecret, ChannelSecret + requestUri + jsonStr + nonce);
		HttpHeaders headers = LineUtil.getHeaders(ChannelId, nonce, signature);
		
		HttpEntity<Citem> reqEntity = new HttpEntity<>(citem, headers);
		
		ResponseEntity<String> repEntity = restTemplate.exchange(conUrl, HttpMethod.POST, reqEntity, String.class);
		
		
		System.out.println("--");
		JsonNode jsonResponse = om1.readTree(repEntity.getBody());
		String returnCode = jsonResponse.get("returnCode").asText();
		if (returnCode.equals("0000") ){
			System.out.println("0000000");
			Map<Integer, CartItem> cart = (Map<Integer, CartItem>) m.getAttribute("cart");
			String orderID = (String) m.getAttribute("orderID");
			CorderBean corderBean = new CorderBean();
			corderBean.setOrderID(orderID);
			corderBean.setStudentID(1);// 從session要使用者資料
			corderBean.setOrderDate(new Date(System.currentTimeMillis()));
			corderBean.setOrderPrice(total);
			corderBean.setMethod("Line Pay");
			corderBean.setStatus("已付款");
			coService.insertORD(corderBean, cart);
			status.setComplete();
		}
		return "forward:/courseorder/order.do";
	}
	
	@PostMapping(path = "/LinePayReqAfter/{oid}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> reqestByOrder(@PathVariable("oid") String orderID,@RequestParam("dis")String disID,HttpSession session)
			throws JsonProcessingException {
		System.out.println(orderID);
		DiscountBean discount = disService.getByID(disID);
		System.out.println("dis:"+discount);
		session.setAttribute("discount",discount);
		List<ItemInfo> orederItem = coService.getItem(orderID);
		Item item = LineUtil.getItemByOrder(orederItem,discount.getDisPercent());
		String url = null;
		String reqUrl = "https://sandbox-api-pay.line.me/v3/payments/request";
		String requestUri = "/v3/payments/request";
		String nonce = UUID.randomUUID().toString();
		ObjectMapper om1 = new ObjectMapper();
		String jsonStr = om1.writeValueAsString(item);
		String signature = LineUtil.encrypt(ChannelSecret, ChannelSecret + requestUri + jsonStr + nonce);

		HttpHeaders headers = LineUtil.getHeaders(ChannelId, nonce, signature);
		HttpEntity<Item> reqEntity = new HttpEntity<>(item, headers);
		ResponseEntity<String> repEntity = restTemplate.exchange(reqUrl, HttpMethod.POST, reqEntity, String.class);
		System.out.println("jjjjjjjj"+repEntity.getBody());
		JsonNode jsonResponse = om1.readTree(repEntity.getBody());
		System.out.println("kkkkkkkkkkk"+jsonResponse);
		String returnCode = jsonResponse.get("returnCode").asText();
		if (returnCode.equals("0000")) {
			url = jsonResponse.get("info").get("paymentUrl").get("web").toString();
			System.out.println("re"+jsonResponse.get("returnCode").asText());
			System.out.println("in"+jsonResponse.get("info").get("paymentUrl").get("web").toString());
			System.out.println("url= "+url);
		}
		return ResponseEntity.ok().body(url);
	}
	
	@GetMapping("/LinePayConByOrder")
	public String confirmByOrder(@RequestParam("transactionId") String transactionId,@RequestParam("orderId") String orderID,HttpSession session) throws JsonProcessingException {
		Integer orderPrice = coService.getORDByID(orderID).getOrderPrice();
		DiscountBean discount = (DiscountBean) session.getAttribute("discount");
		Double price= Math.ceil((orderPrice*discount.getDisPercent()/100));
		System.out.println(price);

		String conUrl = "https://sandbox-api-pay.line.me/v3/payments/" + transactionId + "/confirm";
		Citem citem = new Citem();
		citem.setAmount(price.intValue());
		citem.setCurrency("TWD");

		ObjectMapper om1 = new ObjectMapper();
		String jsonStr = om1.writeValueAsString(citem);
		String requestUri = "/v3/payments/" + transactionId + "/confirm";
		String nonce = UUID.randomUUID().toString();
		String signature = LineUtil.encrypt(ChannelSecret, ChannelSecret + requestUri + jsonStr + nonce);
		HttpHeaders headers = LineUtil.getHeaders(ChannelId, nonce, signature);
		
		HttpEntity<Citem> reqEntity = new HttpEntity<>(citem, headers);
		
		ResponseEntity<String> repEntity = restTemplate.exchange(conUrl, HttpMethod.POST, reqEntity, String.class);
		
		
		System.out.println("--");
		JsonNode jsonResponse = om1.readTree(repEntity.getBody());
		String returnCode = jsonResponse.get("returnCode").asText();
		System.out.println("123123");
		System.out.println(jsonResponse);
		if (returnCode.equals("0000") ){
			System.out.println("你好");
			coService.payOrder(orderID, "已付款", "LinePay",discount);
			session.removeAttribute("discount");
		}
		return "forward:/courseorder/order.do";
	}
}
