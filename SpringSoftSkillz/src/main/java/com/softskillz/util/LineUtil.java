package com.softskillz.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;

import com.softskillz.courseorder.model.bean.CartItem;
import com.softskillz.courseorder.model.bean.ConfirmItem;
import com.softskillz.courseorder.model.bean.RequestItem;
import com.softskillz.courseorder.model.bean.test.Item;
import com.softskillz.courseorder.model.bean.test.Packages;
import com.softskillz.courseorder.model.bean.test.Products;
import com.softskillz.courseorder.model.bean.test.RedirectUrls;

public class LineUtil {

	public static String getOrderID(Long orderTime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String formattedTime = sdf.format(orderTime);
		String orderID = "order" + formattedTime;

		return orderID;
	}

	public static RequestItem doResItem(String productName, Integer total, String currency, String orderID,
			String confirmUrl) {
		RequestItem item = new RequestItem();
		item.setProductName(productName);
		item.setAmount(total);
		item.setCurrency(currency);
		item.setOrderId(orderID);
		item.setConfirmUrl(confirmUrl);
		return item;
	}

	public static ConfirmItem doConfirmItem(RequestItem requestItem) {
		ConfirmItem confirmItem = new ConfirmItem();
		confirmItem.setAmount(requestItem.getAmount());
		confirmItem.setCurrency(requestItem.getCurrency());

		return confirmItem;
	}

	public static String toBase64String(byte[] bytes) {
		byte[] byteArray = Base64.encodeBase64(bytes);
		return new String(byteArray);
	}

	public static String encrypt(final String keys, final String data) {
		return toBase64String(
				HmacUtils.getInitializedMac(HmacAlgorithms.HMAC_SHA_256, keys.getBytes()).doFinal(data.getBytes()));
	}

	public static HttpHeaders getHeaders(String channelId ,String nonce,String signature) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("X-LINE-ChannelId", channelId);
		headers.set("X-LINE-Authorization-Nonce", nonce);
		headers.set("X-LINE-Authorization", signature);
		return headers;
	}

	public static Item getItem(Map<Integer, CartItem> cart, String orderID, Integer total) {
		System.out.println(total);
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl("");
		redirectUrls.setConfirmUrl("http://localhost:8080/SpringSoftSkillz/LinePayCon");

		List<Products> productList = new ArrayList<Products>();
		Products products = new Products();
		Integer subtotal = 0;
		for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
			products.setId(entry.getValue().getCourse().getCourseID().toString());
			products.setName(entry.getValue().getCourse().getCourseName());
			products.setQuantity(entry.getValue().getQuantity());
			products.setPrice(entry.getValue().getCourse().getPrice());
			productList.add(products);
			subtotal += entry.getValue().getCourse().getPrice()*entry.getValue().getQuantity();
			System.out.println(entry.getValue().getCourse().getPrice());
		}
		Packages packages = new Packages();
		packages.setId("1");
		packages.setAmount(subtotal);
		packages.setProducts(productList);
		List<Packages> packagesList = new ArrayList<Packages>();
		packagesList.add(packages);
		System.out.println(subtotal);
		Item item = new Item();
		item.setAmount(total);
		item.setCurrency("TWD");
		item.setOrderId(orderID);
		item.setPackages(packagesList);
		item.setRedirectUrls(redirectUrls);

		return item;
	}
	
}
