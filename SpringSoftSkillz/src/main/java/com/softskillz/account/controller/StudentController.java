package com.softskillz.account.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.softskillz.account.model.InterfaceStudentDao;
import com.softskillz.account.model.InterfaceStudentService;
import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.StudentDao;

@Controller
@SessionAttributes(names = { "student" })
public class StudentController {

	@Autowired
	private InterfaceStudentDao dao;

	@GetMapping("/Login.do")
	public String processAction() {
		return "pages/Login";
	}

	@PostMapping("/studentLogin")
	public String studentLogin(@RequestParam("account") String account, @RequestParam("pwd") String pwd, Model m) {
		StudentBean studentBean = dao.studentLogin(account, pwd);
		if (studentBean!= null) {
			m.addAttribute("student",studentBean);
			return "redirect:course.do";
		}else {
			return "redirect:Login.do";
		}
	}
	
	@GetMapping("/Logout")
	public String studentLogout(Model m , SessionStatus status) {
		
		
		m.getAttribute("student");
		status.isComplete();
		
		return "redirect:LoginSimulation.html";
	}
	
}
