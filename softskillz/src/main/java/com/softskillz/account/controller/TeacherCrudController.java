package com.softskillz.account.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.TeacherService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/teacher")
public class TeacherCrudController {

	@Autowired
	private TeacherService teacherService;

	// 老師登入頁面
	@GetMapping("/teacher-loginPage")
	public String TeacherLoginPage() {
		return "/dist/account/teacher/TeacherLoginFront.jsp";
	}

	// 登入action
	@PostMapping("teacher-login")
	public String teacherLoginAction(@RequestParam("usernameOrEmail") String usernameOrEmail,
			@RequestParam("teacherPassword") String teacherPassword, HttpSession session, Model m) {

		TeacherBean teacherData = null;
		// 檢查輸入是否包含 '@'，如果有，則視為電子郵件
		if (usernameOrEmail.contains("@")) {
			teacherData = teacherService.emailCheckLogin(usernameOrEmail, teacherPassword);
		} else {
			teacherData = teacherService.usernameCheckLogin(usernameOrEmail, teacherPassword);
		}

		if (teacherData != null) {
			session.setAttribute("teacherData", teacherData);
			return "redirect:/teacherScheduleFront/schedule";
		} else {
			// redirect只能叫controller，其他時候直接輸入網址
			m.addAttribute("loginMsg", "錯誤的帳號或密碼");
			return "/dist/account/teacher/TeacherLoginFront.jsp";
		}
	}
	
	//老師後台頁面
	@GetMapping("/teacher-account")
	public String TeacherCrudPage() {
		return "/dist/account/teacher/teacherCrudPage.jsp";
	}
	
	// 登出功能
	@PostMapping("/teacher-logout")
	public String logoutAction(HttpServletRequest request) {
	    HttpSession session = request.getSession(false); // 獲取當前會話，不創建新會話
	    if (session != null) {
	        session.invalidate(); // 使會話失效
	    }
	    return "redirect:/teacher/teacher-loginPage"; // 重定向到登入頁面
	}
	
	// 查詢單筆
	@GetMapping("/TeacherSelectOne")
	public String processFindOne(@RequestParam("teacherId") Integer teacherId, Model m) {
		TeacherBean result = teacherService.findById(teacherId);

		if (result != null) {
			List<TeacherBean> teachers = new ArrayList();
			teachers.add(result);
			m.addAttribute("teachers", teachers);

		} else {
			m.addAttribute("rowMsg", "找不到此id");
		}
		System.out.println(result);
		return "/dist/account/teacher/teacherCrudPage.jsp";

	}
	
	// 查詢全部
	@GetMapping("/TeacherSelectAll")
	public String processFindAllAction(Model m) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		System.out.println(teachers);
		m.addAttribute("teachers", teachers);

		return "/dist/account/teacher/teacherCrudPage.jsp";
	}
	
	// 刪除
	@DeleteMapping("/TeacherDelete")
	public String processDeleteAction(@RequestParam("teacherId") Integer teacherId, Model m) {
		boolean deleteStatus = teacherService.deleteById(teacherId);

		if (deleteStatus) {
			m.addAttribute("rowMsg", "已刪除一筆資料");
		}

		return "redirect:/teacher/teacher-account";

	}
	
	
}
