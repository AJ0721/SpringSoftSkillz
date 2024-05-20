package com.softskillz.account.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PutMapping;

@Controller
@RequestMapping("/teacher")
public class TeacherCrudController {

	@Autowired
	private TeacherService teacherService;
	/************************************ 後台 *************************************/

	// 老師後台頁面
	@GetMapping("/teacher-account")
	public String TeacherCrudPage() {
		return "/dist/account/teacher/teacherCrudPage.jsp";
	}

	// 註冊頁面
	@GetMapping({ "/teacher-createPage" })
	public String goToStudentCreatePage() {
		return "/elearning/account/teacher/TeacherCreate.jsp";
	}

	// 後台，印舊資料
	@GetMapping({ "/teacher-update" })
	public String goToStudentUpdate(@RequestParam("teacherId") Integer teacherId, Model m) {

		TeacherBean oldTeacherBean = teacherService.findById(teacherId);
		m.addAttribute("teacher", oldTeacherBean);

		return "/dist/account/teacher/TeacherUpdate.jsp";
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
	
	// 後台修改老師資料
	@PutMapping("/TeacherUpdate")
	public String processUpdateAction(
			 @RequestParam("teacherId") Integer teacherId, 
			   @RequestParam("teacherUserName") String teacherUserName, 
			   @RequestParam("teacherLastName") String teacherLastName, 
			   @RequestParam("teacherFirstName") String teacherFirstName,
			   @RequestParam("teacherPassword") String teacherPassword,
			   @RequestParam("teacherBirth") String teacherBirth, 
			   @RequestParam("teacherEmail") String teacherEmail, 
			   @RequestParam("teacherGender") String teacherGender, 
			   @RequestParam("teacherCountry") String teacherCountry, 
			   @RequestParam("teacherMobile") String teacherMobile, 
			   @RequestParam("teacherEducation") String teacherEducation, 
			   @RequestParam("teachTime") String teachTime,
			   @RequestParam("experience") String experience,
			   @RequestParam("status") String status,
			   @RequestParam("strength") String strength,
			   @RequestParam("subject") String subject,
			   Model m
		) throws ParseException {
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(teacherBirth);

		TeacherBean teacherBean = new TeacherBean();
		teacherBean.setTeacherId(teacherId);
		teacherBean.setTeacherUserName(teacherUserName);
		teacherBean.setTeacherLastName(teacherLastName);
		teacherBean.setTeacherFirstName(teacherFirstName);
		teacherBean.setTeacherPassword(teacherPassword);
		teacherBean.setTeacherBirth(date);
		teacherBean.setTeacherEmail(teacherEmail);
		teacherBean.setTeacherGender(teacherGender);
		teacherBean.setTeacherCountry(teacherCountry);
		teacherBean.setTeacherMobile(teacherMobile);
		teacherBean.setTeacherEducation(teacherEducation);
		teacherBean.setTeachTime(teachTime);
		teacherBean.setExperience(teachTime);
		teacherBean.setStatus(status);
		teacherBean.setStrength(strength);
		teacherBean.setSubject(subject);
		teacherService.updateTeacherBean(teacherBean);
		
		// 把東西丟到頁面
		m.addAttribute("rowMsg", "已更新老師帳號");

		return "redirect:/teacher/teacher-account";
	}
	
	
	/************************************ 前台 *************************************/
	
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

	// 登出功能
	@PostMapping("/teacher-logout")
	public String logoutAction(HttpServletRequest request) {
		HttpSession session = request.getSession(false); // 獲取當前會話，不創建新會話
		if (session != null) {
			session.invalidate(); // 使會話失效
		}
		return "redirect:/teacher/teacher-loginPage"; // 重定向到登入頁面
	}
	
	
	// 新增，老師註冊
	@PostMapping("/teacher-create")
	public String teacherInsert(@RequestParam("teacherLastName") String teacherLastName,
			@RequestParam("teacherFirstName") String teacherFirstName,
			@RequestParam("teacherUserName") String teacherUserName,
			@RequestParam("teacherPassword") String teacherPassword, @RequestParam("teacherBirth") String teacherBirth,
			@RequestParam("teacherGender") String teacherGender, @RequestParam("teacherEmail") String teacherEmail,
			@RequestParam("teacherMobile") String teacherMobile, @RequestParam("teacherCountry") String teacherCountry,
			@RequestParam("subject") String subject, @RequestParam("teacherEducation") String teacherEducation,
			@RequestParam("experience") String experience, @RequestParam("status") String status,
			@RequestParam("teachTime") String teachTime, @RequestParam("strength") String strength, Model m)
			throws ParseException {

		Date now = new Date();
		// 解析生日日期
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(teacherBirth);

		TeacherBean insertBean = new TeacherBean();
		insertBean.setTeacherLastName(teacherLastName);
		insertBean.setTeacherFirstName(teacherFirstName);
		insertBean.setTeacherUserName(teacherUserName);
		insertBean.setTeacherPassword(teacherPassword);
		insertBean.setTeacherBirth(date);
		insertBean.setTeacherGender(teacherGender);
		insertBean.setTeacherEmail(teacherEmail);
		insertBean.setTeacherMobile(teacherMobile);
		insertBean.setTeacherCountry(teacherCountry);
		insertBean.setSubject(subject);
		insertBean.setTeacherEducation(teacherEducation);
		insertBean.setExperience(experience);
		insertBean.setStatus(status);
		insertBean.setTeachTime(teachTime);
		insertBean.setStrength(strength);
		insertBean.setTeacherRegistrationDate(now);

		TeacherBean resultBean = teacherService.insert(insertBean);

		if (resultBean == null) {
			m.addAttribute("createMsg", "該帳號已被使用");
		} else {
			m.addAttribute("createMsg", "帳號創建成功");
		}
		return "/dist/account/teacher/TeacherLoginFront.jsp";
	}

}
