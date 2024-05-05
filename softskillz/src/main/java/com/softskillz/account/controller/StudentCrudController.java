package com.softskillz.account.controller;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/student")
public class StudentCrudController {

	// 登入
	// 網址頁登入一定要用get方法
	@GetMapping("/student-loginPage")
	public String StudentLoginAction() {
		return "account/student/StudentLoginFront.jsp";
	}
	
	// 管理員頁面
	@GetMapping("/student-account")
	public String StudentCrudPage() {
		return "account/student/StudentCrudPage.jsp";
	}

	// 查詢全部
	@GetMapping("/StudentSelectAll")
	public String processFindAllAction(Model m) {
		List<StudentBean> students = StudentService.findAllStudents();
		System.out.println(students);
		m.addAttribute("student", students);

		return "/account/student/StudentCrudPage.jsp";
	}
	
	
	
}
