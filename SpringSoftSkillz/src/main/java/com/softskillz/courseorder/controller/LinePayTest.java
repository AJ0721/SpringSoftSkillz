package com.softskillz.courseorder.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.HmacUtils;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.test.Citem;
import com.softskillz.courseorder.model.bean.test.Item;
import com.softskillz.courseorder.model.bean.test.Packages;
import com.softskillz.courseorder.model.bean.test.Products;
import com.softskillz.courseorder.model.bean.test.RedirectUrls;
import com.softskillz.util.LineUtil;

@Controller
@SessionAttributes(names = { "cart", "total", "orderID" })
public class LinePayTest {

	@Autowired
	private RestTemplate restTemplate;

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
		JsonNode jsonResponse = om1.readTree(repEntity.getBody());
		String returnCode = jsonResponse.get("returnCode").asText();
		if (returnCode == "0000") {
			url = jsonResponse.get("info").get("paymentUrl").asText();
		}

		return repEntity;
	}

	@GetMapping("/LinePayCon")
	public String confirm(@RequestParam("transactionId") String transactionId, Model m)
			throws JsonProcessingException {
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

		return "redirect:doOrder";
	}



}
