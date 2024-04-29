package com.softskillz.courseorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.courseorder.model.service.impl.StudentServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {

	@Autowired
	private StudentServiceImpl stuService;
	@GetMapping("/Login.do")
	public String processAction() {
		return "courseorder/Login.html";
	}

	@PostMapping("/studentLogin")
	public String studentLogin(@RequestParam("account") String account, @RequestParam("pwd") String pwd, Model m ,HttpSession session) {
		StudentBean studentBean = stuService.loginSimulation(account, pwd);
		System.out.println(studentBean);
		if (studentBean!= null) {
			session.setAttribute("student",studentBean);
			return "redirect:/courses/course.do";
		}else {
			return "redirect:Login.do";
		}
	}
	
	@GetMapping("/Logout")
	public String studentLogout(Model m , SessionStatus status) {
		
		
		status.setComplete();
		
		return "redirect:LoginSimulation.html";
	}
	
}
