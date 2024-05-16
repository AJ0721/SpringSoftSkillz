package com.softskillz.coursechatdemo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.coursechatdemo.model.ChatHistory;
import com.softskillz.coursechatdemo.model.ChatHistoryServiceImpl;
import com.softskillz.coursechatdemo.model.ChatRoom;
import com.softskillz.coursechatdemo.model.ChatRoomServiceImpl;
import com.softskillz.coursechatdemo.model.ChatRoomUser;
import com.softskillz.courseorder.model.service.impl.StudentServiceImpl;
import com.softskillz.courseorder.model.service.impl.TeacherServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatRoomServiceImpl crService;

	@Autowired
	private ChatHistoryServiceImpl chService;

	@Autowired
	private StudentServiceImpl stService;

	@Autowired
	private TeacherServiceImpl tService;

	@GetMapping("/coursechat.do")
	public String courseChat() {
		return "/dist/chat/coursechat.html";
	}
	
	
	@GetMapping("/teacherList/{userID}")
	@ResponseBody
	public List<ChatRoomUser> charList(@PathVariable("userID") String userID) {
		System.out.println(userID);
		List<ChatRoom> chatRoomList = crService.chatRoomList(userID);
		List<ChatRoomUser> chatList = new ArrayList<>();

		for (ChatRoom cr : chatRoomList) {
			if (userID.equals(cr.getUser1())) {
				System.out.println("u2:" + cr.getUser2());
				TeacherBean teacher = tService.findByFormatID(cr.getUser2());
				ChatRoomUser user = new ChatRoomUser(cr.getUser2(), teacher.getTeacherPhoto());
				chatList.add(user);
			} else {
				System.out.println("u1:" + cr.getUser1());
				TeacherBean teacher = tService.findByFormatID(cr.getUser1());
				ChatRoomUser user = new ChatRoomUser(cr.getUser1(), teacher.getTeacherPhoto());
				chatList.add(user);
			}
		}
		System.out.println(chatList);
		return chatList;
	}

	@GetMapping("/studentList/{userID}")
	@ResponseBody
	public List<ChatRoomUser> charSList(@PathVariable("userID") String userID) {
		System.out.println(userID);
		List<ChatRoom> chatRoomList = crService.chatRoomList(userID);
		List<ChatRoomUser> chatList = new ArrayList<>();

		for (ChatRoom cr : chatRoomList) {
			if (userID.equals(cr.getUser1())) {
				System.out.println("u2:" + cr.getUser2());
				StudentBean student = stService.findStudentByFormatID(cr.getUser2());
				ChatRoomUser user = new ChatRoomUser(cr.getUser2(), student.getStudentPhoto());
				chatList.add(user);
			} else {
				System.out.println("u1:" + cr.getUser1());
				StudentBean student = stService.findStudentByFormatID(cr.getUser1());
				ChatRoomUser user = new ChatRoomUser(cr.getUser1(), student.getStudentPhoto());
				chatList.add(user);
			}
		}
		System.out.println(chatList);
		return chatList;
	}

	@GetMapping("/chatroom/{userID}")
	@ResponseBody
	public ChatRoomUser findUser(@PathVariable("userID") String userID) {
		System.out.println(userID);
		ChatRoomUser user = new ChatRoomUser();
		StudentBean studentBean = stService.findStudentByFormatID(userID);
		user.setUserID(studentBean.getStudentIdFormatted());
		user.setUserPhoto(studentBean.getStudentPhoto());
		return user;

	}

	@GetMapping("/getUser")
	@ResponseBody
	public ChatRoomUser getUserID(HttpSession session) {
		StudentBean student = (StudentBean) session.getAttribute("student");
		ChatRoomUser user = new ChatRoomUser();
		user.setUserID(student.getStudentIdFormatted());
		user.setUserPhoto(student.getStudentPhoto());
		return user;
	}

	@GetMapping("/getTeacherID")
	@ResponseBody
	public ChatRoomUser getTeacherID(HttpSession session) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacher");
		ChatRoomUser user = new ChatRoomUser();
		user.setUserID(teacher.getTeacherIdFormatted());
		user.setUserPhoto(teacher.getTeacherPhoto());
		return user;
	}

	@GetMapping("/teachercr/{userID}")
	@ResponseBody
	public ChatRoomUser getTeacher(@PathVariable("userID") String userID) {
		TeacherBean teacherBean = tService.findByFormatID(userID);
		ChatRoomUser user = new ChatRoomUser();
		user.setUserID(teacherBean.getTeacherIdFormatted());
		user.setUserPhoto(teacherBean.getTeacherPhoto());
		return user;
	}

	@GetMapping
	@ResponseBody
	public Page<ChatRoom> getChatRoom(@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "lastTime") String sort,
			@RequestParam(value = "direction", defaultValue = "ASC") String sortDirection) {
		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<ChatRoom> pageChatroom = crService.chatRoomListPage(pageable);
		return pageChatroom;
	}

	@GetMapping("/{chatid}")
	@ResponseBody
	public Page<ChatHistory> getHistory(@PathVariable("chatid")String chatRoomID, @RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "10") Integer size,
			@RequestParam(value = "sort", defaultValue = "sendTime") String sort,
			@RequestParam(value = "direction", defaultValue = "ASC") String sortDirection) {
		System.out.println(chatRoomID);
		
		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page-1,size,Sort.by(direction,sort));
		Page<ChatHistory> pageHistory = chService.getHistory(pageable,chatRoomID);
		return pageHistory;
	}
}
