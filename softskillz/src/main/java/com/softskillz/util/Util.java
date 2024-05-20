package com.softskillz.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.course.model.CourseBean;
import com.softskillz.coursechatdemo.model.ChatHistory;
import com.softskillz.coursechatdemo.model.ChatRoom;
import com.softskillz.coursechatdemo.model.ChatRoomUser;
import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.service.impl.StudentServiceImpl;
import com.softskillz.courseorder.model.service.impl.TeacherServiceImpl;

public class Util {
	@Autowired
	private StudentServiceImpl stService;

	@Autowired
	private TeacherServiceImpl tService;

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

	public static Double getDiscountRate(Integer quantity) {
		Double discountRate = null;
		switch (quantity) {
		case 1:
			discountRate = 100.0;
			break;
		case 5:
			discountRate = 95.0;
			break;
		case 10:
			discountRate = 90.0;
			break;
		case 20:
			discountRate = 85.0;
			break;

		}
		return discountRate;
	}

	public static Map<String, Object> systemMessage(String receiveUser, String msg) throws JsonProcessingException {
		Map<String, Object> smap = new HashMap<>();
		String chatRoomId = generateChatRoomId("system", receiveUser);
		Date date = new Date();
		ChatRoom chatRoom = new ChatRoom(chatRoomId, "system", receiveUser, date);
		ChatHistory chatHistory = new ChatHistory(chatRoomId, "system", msg, date);
		smap.put("chatRoom", chatRoom);
		smap.put("chatHistory", chatHistory);
		return smap;
	}

	public static String generateChatRoomId(String user1, String user2) {
		if (user1.equals("system")) {
			return "system_" + user2;
		} else if (user2.equals("system")) {
			return "system_" + user1;
		} else if (user1.compareTo(user2) < 0) {
			return user1 + "_" + user2;
		} else {
			return user2 + "_" + user1;
		}
	}

	public static Course2 getCourse(CourseBean courseBean) {
		Course2 course = new Course2();
		course.setCourseID(courseBean.getCourseID());
		course.setTeacherID(courseBean.getTeacherBean().getTeacherIdFormatted());
		course.setTeacherName(
				courseBean.getTeacherBean().getTeacherLastName() + courseBean.getTeacherBean().getTeacherFirstName());
		course.setTeacherPhoto(courseBean.getTeacherBean().getTeacherPhoto());
		course.setCourseName(courseBean.getCourseName());
		course.setCourseInfo(courseBean.getCourseInfo());
		course.setCourseCategory(courseBean.getCourseCategory());
		course.setPrice(courseBean.getCoursePrice());
		return course;
	}

}
