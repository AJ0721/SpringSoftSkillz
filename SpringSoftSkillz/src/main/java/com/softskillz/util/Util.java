package com.softskillz.util;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;

public class Util {

	public Util() {
	}

	public static String toBase64String(byte[] bytes) {
		byte[] byteArray = Base64.encodeBase64(bytes);
		return new String(byteArray);
	}

	public static String encrypt(final String keys, final String data) {
		return toBase64String(
				HmacUtils.getInitializedMac(HmacAlgorithms.HMAC_SHA_256, keys.getBytes()).doFinal(data.getBytes()));
	}

	public static String dateFormat(String key) {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyyMMdd").parse(key);
			String dateString = String.valueOf(date.getTime());
			return dateString;
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static final String goodKey() {
		return dateFormat("19950405");

	}

	public static boolean getExcluded(String path) {

		String[] urlString = { "/DoOrder", "/DeleteOrder", "/CancelOrder", "/GetOrder", "/AdminCanCel", "/AdminCanCel",
				"/AdminSelectOrders", "/DoOrderInfo", "/AdmonOrderInfo", "/SelectCourse", "/CourseDetail",
				"/StudentLoginS", "/AdminLoginS", "/AdminDateSetect", "/AdminClearTime", "Orders.jsp", "AdminOInfo.jsp",
				"Cart.jsp", "CourseDetail.jsp", "ItemInfo.jsp", "MyOrder.jsp", "index.html", "backendPage.html",
				"LoginSimulation.html" };
		return Arrays.asList(urlString).contains(path);

	}

	public static Date dateUtil(String dateString) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = sdf.parse(dateString);
			System.out.println(date);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getOrderID(Long orderTime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String formattedTime = sdf.format(orderTime);
		String orderID = "order" + formattedTime;
		
		return orderID;
	}
}
