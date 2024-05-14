package com.softskillz.courseorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.courseorder.model.service.impl.TeacherServiceImpl;

import jakarta.servlet.http.HttpSession;
@Controller
public class TeacherControllerS {

	@Autowired
	private TeacherServiceImpl tService;
	
	@GetMapping("/TeacherLog")
	public String teacherLogin(HttpSession session ) {
		TeacherBean teacher = tService.loginSimulation("123456", "123456");
		System.out.println("登入成功:"+teacher.getTeacherIdFormatted());
		session.setAttribute("teacher", teacher);
		return "/courseorder/html/testteacherpage.html";
	}
}
