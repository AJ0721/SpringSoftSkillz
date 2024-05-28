package com.softskillz.coursechatdemo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.StudentService;
import com.softskillz.account.model.service.TeacherService;
import com.softskillz.coursechatdemo.model.ChatHistory;
import com.softskillz.coursechatdemo.model.ChatHistoryServiceImpl;
import com.softskillz.coursechatdemo.model.ChatRoom;
import com.softskillz.coursechatdemo.model.ChatRoomServiceImpl;
import com.softskillz.coursechatdemo.model.ChatRoomUser;
import com.softskillz.util.Util;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatRoomServiceImpl crService;

	@Autowired
	private ChatHistoryServiceImpl chService;

	@Autowired
	private StudentService stService;

	@Autowired
	private TeacherService tService;

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
		ChatRoomUser user = null;
		for (ChatRoom cr : chatRoomList) {
			if (userID.equals(cr.getUser1())) {
				System.out.println("u2:" + cr.getUser2());
				TeacherBean teacher = tService.findByFormatID(cr.getUser2());
				if (teacher != null) {
					user = new ChatRoomUser(cr.getUser2(),
							(teacher.getTeacherLastName() + teacher.getTeacherFirstName()), "/teacher/images/"+teacher.getTeacherPhoto());
				} else {
					user = new ChatRoomUser("system", "貓貓管理員", "/teacher/images/teacher01.jpg");
				}
				chatList.add(user);
			} else {
				System.out.println("u1:" + cr.getUser1());
				TeacherBean teacher = tService.findByFormatID(cr.getUser1());
				if (teacher != null) {
					user = new ChatRoomUser(cr.getUser1(),
							(teacher.getTeacherLastName() + teacher.getTeacherFirstName()),"/teacher/images/"+teacher.getTeacherPhoto());
				} else {
					user = new ChatRoomUser("system", "貓貓管理員", "/teacher/images/teacher01.jpg");
				}
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
		ChatRoomUser user = null;

		for (ChatRoom cr : chatRoomList) {
			if (userID.equals(cr.getUser1())) {
				System.out.println("u2:" + cr.getUser2());
				StudentBean studnet = stService.findStudentByFormatID(cr.getUser2());
				if (studnet != null) {
					user = new ChatRoomUser(cr.getUser2(),
							(studnet.getStudentLastName() + studnet.getStudentFirstName()), "/student/images/"+studnet.getStudentPhoto());
				} else {
					user = new ChatRoomUser("system", "貓貓管理員", "/teacher/images/teacher01.jpg");
				}
				chatList.add(user);
			} else {
				System.out.println("u1:" + cr.getUser1());
				StudentBean studnet = stService.findStudentByFormatID(cr.getUser1());
				if (studnet != null) {
					user = new ChatRoomUser(cr.getUser1(),
							(studnet.getStudentLastName() + studnet.getStudentFirstName()), "/student/images/"+studnet.getStudentPhoto());
				} else {
					user = new ChatRoomUser("system", "貓貓管理員", "/teacher/images/teacher01.jpg");
				}
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
		if (studentBean != null) {
			user.setUserID(studentBean.getStudentIdFormatted());
			user.setUserName(studentBean.getStudentLastName() + studentBean.getStudentFirstName());
			user.setUserPhoto("/student/images/"+studentBean.getStudentPhoto());
		} else {
			user.setUserID("system");
			user.setUserPhoto("/teacher/images/teacher01.jpg");
			user.setUserName("貓貓管理員");
		}
		return user;

	}

	@GetMapping("/getUser")
	@ResponseBody
	public ChatRoomUser getUserID(HttpSession session) {
		StudentBean student = (StudentBean) session.getAttribute("studentData");
		ChatRoomUser user = new ChatRoomUser();
		user.setUserID(student.getStudentIdFormatted());
		user.setUserPhoto("/student/images/"+student.getStudentPhoto());
		user.setUserName(student.getStudentLastName() + student.getStudentFirstName());
		return user;
	}

	@GetMapping("/getTeacherID")
	@ResponseBody
	public ChatRoomUser getTeacherID(HttpSession session) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		ChatRoomUser user = new ChatRoomUser();
		user.setUserID(teacher.getTeacherIdFormatted());
		user.setUserPhoto("/teacher/images/"+teacher.getTeacherPhoto());
		user.setUserName((teacher.getTeacherLastName() + teacher.getTeacherFirstName()));
		return user;
	}

	@GetMapping("/teachercr/{userID}")
	@ResponseBody
	public ChatRoomUser getTeacher(@PathVariable("userID") String userID) {

		TeacherBean teacherBean = tService.findByFormatID(userID);
		ChatRoomUser user = new ChatRoomUser();
		if (teacherBean != null) {
			user.setUserID(teacherBean.getTeacherIdFormatted());
			user.setUserPhoto("/teacher/images/"+teacherBean.getTeacherPhoto());
			user.setUserName((teacherBean.getTeacherLastName() + teacherBean.getTeacherFirstName()));
		} else {
			user.setUserID("system");
			user.setUserPhoto("/teacher/images/teacher01.jpg");
			user.setUserName("貓貓管理員");
		}
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
	public Page<ChatHistory> getHistory(@PathVariable("chatid") String chatRoomID,
			@RequestParam(value = "pid", defaultValue = "1") Integer page,
			@RequestParam(value = "size", defaultValue = "20") Integer size,
			@RequestParam(value = "sort", defaultValue = "sendTime") String sort,
			@RequestParam(value = "direction", defaultValue = "DESC") String sortDirection) {
		System.out.println(chatRoomID);

		Direction direction = Direction.fromString(sortDirection);
		Pageable pageable = PageRequest.of(page - 1, size, Sort.by(direction, sort));
		Page<ChatHistory> pageHistory = chService.getHistory(pageable, chatRoomID);
		return pageHistory;
	}


	@PostMapping("/sendmessage")
	@ResponseBody
	public String sendMessage(@RequestBody Map<String,String> dataMap )	throws JsonProcessingException {
		Integer studentID = Integer.parseInt(dataMap.get("studentID"));
		Integer teacherID = Integer.parseInt(dataMap.get("teacherID"));
		String msg = dataMap.get("msg");
		StudentBean student = stService.getById(studentID);
		String sformatID = student.getStudentIdFormatted();
		TeacherBean teacher = tService.findById(teacherID);
		String tformatID = teacher.getTeacherIdFormatted();
		Map<String, Object> toStudent = Util.systemMessage(sformatID, msg);
		Map<String, Object> toTeacher = Util.systemMessage(tformatID, msg);

		WebSocketChatRoom.sendMessageToUser(sformatID, toStudent);
		WebSocketChatRoom.sendMessageToUser(tformatID, toTeacher);
		return "Message sent success ";
	}
}
