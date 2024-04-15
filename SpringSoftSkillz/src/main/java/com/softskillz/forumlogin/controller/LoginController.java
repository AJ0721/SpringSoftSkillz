package com.softskillz.forumlogin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.account.model.InterfaceStudentService;
import com.softskillz.account.model.InterfaceTeacherService;
import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

@Controller
@SessionAttributes(names = {"student", "teacher"})
public class LoginController {

	@GetMapping("/loginpage.controller")
	public String loginPage() {
		return "forum/pages/login";
	}

	@Autowired
	private InterfaceStudentService interfaceStudentService;

	@Autowired
	private InterfaceTeacherService interfaceTeacherService;

	@PostMapping("/studentchecklogin.controller")
	public String studentLoginAuthentication(
			@RequestParam(name = "studentUsername") String studentUsername,
			@RequestParam(name = "studentPassword") String studentPassword, Model model) {
		

		Map<String, String> errors = new HashMap<>();
		model.addAttribute("errors", errors);

		if (studentUsername == null || studentUsername.length() == 0) {
			errors.put("sNameError", "請輸入使用者名稱");
		}

		if (studentPassword == null || studentPassword.length() == 0) {
			errors.put("sPasswordError", "請輸入密碼");
		}

		if (!errors.isEmpty()) {
			return "redirect:forumhome.controller";
		}

		StudentBean studentBean = interfaceStudentService.authenticateStudent(studentUsername, studentPassword);
		if (studentBean != null) {
	
			model.addAttribute("student",studentBean);
			
			return "redirect:forumhome.controller";
		} else  {
			errors.put("loginError", "請輸入正確使用者名稱或密碼");
		}
		return"forum/pages/login";
	}
	

	@PostMapping("/teacherchecklogin.controller")
	public String teacherLoginAuthentication(
			@RequestParam(name = "teacherUsername") String teacherUsername,
			@RequestParam(name = "teacherPassword") String teacherPassword, Model model) {

		Map<String, String> errors = new HashMap<>();
		model.addAttribute("errors", errors);

		if (teacherUsername == null || teacherUsername.length() == 0) {
			errors.put("tNameError", "請輸入使用者名稱");
		}

		if (teacherPassword == null || teacherPassword.length() == 0) {
			errors.put("tPasswordError", "請輸入密碼");
		}
		if (errors != null && !errors.isEmpty()) {
			return "forum/pages/login";
		}

		TeacherBean teacherBean = interfaceTeacherService.authenticateTeacher(teacherUsername, teacherPassword);
		if (teacherBean != null) {
			model.addAttribute("teacher", teacherBean);
			return "redirect:forumhome.controller";
		} else{
			errors.put("loginError", "請輸入正確使用者名稱或密碼");	
		}
		
		return "forum/pages/login";
	}
}
