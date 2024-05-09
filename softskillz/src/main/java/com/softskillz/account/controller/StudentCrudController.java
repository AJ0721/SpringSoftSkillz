package com.softskillz.account.controller;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PutMapping;

@Controller
@RequestMapping("/student")
public class StudentCrudController {

	@Autowired
	private StudentService studentService;

	// 登入
	// 網址頁登入一定要用get方法
	@GetMapping("/student-loginPage")
	public String StudentLoginAction() {
		return "account/student/StudentLoginFront.jsp";
	}

	// 登入action
	@PostMapping("/student-login")
	public String studentLoginAction(@RequestParam("usernameOrEmail") String usernameOrEmail,
			@RequestParam("studentPassword") String studentPassword, HttpSession session) {
		
		StudentBean studentData = null;

		// 檢查輸入是否包含 '@'，如果有，則視為電子郵件
		if (usernameOrEmail.contains("@")) {
			studentData = studentService.emailCheckLogin(usernameOrEmail, studentPassword);
		} else {
			studentData = studentService.usernameCheckLogin(usernameOrEmail, studentPassword);
		}

		if (studentData != null) {
			session.setAttribute("studentData", studentData);
			return "/account/homepage/FrontPage.jsp";
		} else {
			//redirect只能叫controller，其他時候直接輸入網址
			session.setAttribute("loginMsg", "Invalid username or email.");
			return "/account/student/StudentLoginFront.jsp";
		}
	}

	// 學生後台頁面
	@GetMapping("/student-account")
	public String StudentCrudPage() {
		return "account/student/StudentCrudPage.jsp";
	}

	// 註冊頁面
	@GetMapping({ "/student-createPage" })
	public String goToStudentCreatePage() {
		return "account/student/StudentCreate.jsp";
	}

	// 新增頁面，印舊資料
	@GetMapping({ "/student-update" })
	public String goToStudentUpdate(@RequestParam("studentId") Integer studentId, Model m) {

		StudentBean oldStudentBean = studentService.findById(studentId);
		m.addAttribute("student", oldStudentBean);

		return "account/student/StudentUpdate.jsp";
	}

	// 新增, 學生註冊
	@PostMapping("/student-create")
	public String studentInsert(@RequestParam("studentLastName") String studentLastName,
			@RequestParam("studentFirstName") String studentFirstName,
			@RequestParam("studentUsername") String studentUsername,
			@RequestParam("studentPassword") String studentPassword, @RequestParam("studentEmail") String studentEmail,
			@RequestParam("studentGender") String studentGender, @RequestParam("studentBirth") String studentBirth,
			@RequestParam("studentCountry") String studentCountry, @RequestParam("studentMobile") String studentMobile,
			@RequestParam("studentEducation") String studentEducation,
			@RequestParam("learningFrequency") String learningFrequency, Model m) throws ParseException {

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(studentBirth);
		StudentBean insertBean = new StudentBean();
		insertBean.setStudentLastName(studentLastName);
		insertBean.setStudentFirstName(studentFirstName);
		insertBean.setStudentUsername(studentUsername);
		insertBean.setStudentPassword(studentPassword);
		insertBean.setStudentEmail(studentEmail);
		insertBean.setStudentGender(studentGender);
		insertBean.setStudentBirth(date);
		insertBean.setStudentCountry(studentCountry);
		insertBean.setStudentMobile(studentMobile);
		insertBean.setStudentEducation(studentEducation);
		insertBean.setLearningFrequency(learningFrequency);

		StudentBean resultBean = studentService.insert(insertBean);

		if (resultBean == null) {
			m.addAttribute("createMsg", "該帳號已被使用");
		} else {
			m.addAttribute("createMsg", "帳號創建成功");
		}
		return "account/student/StudentLoginFront.jsp";
	}

	// 查詢全部
	@GetMapping("/StudentSelectAll")
	public String processFindAllAction(Model m) {
		List<StudentBean> students = studentService.findAllStudents();
		System.out.println(students);
		m.addAttribute("students", students);

		return "/account/student/StudentCrudPage.jsp";
	}

	// 查詢單筆
	@GetMapping("/StudentSelectOne")
	public String processFindOne(@RequestParam("studentId") Integer studentId, Model m) {
		StudentBean result = studentService.findById(studentId);

		if (result != null) {
			List<StudentBean> students = new ArrayList();
			students.add(result);
			m.addAttribute("students", students);

		} else {
			m.addAttribute("rowMsg", "找不到此id");
		}
		System.out.println(result);
		return "/account/student/StudentCrudPage.jsp";

	}

	// 刪除
	@DeleteMapping("/StudentDelete")
	public String processDeleteAction(@RequestParam("studentId") Integer studentId, Model m) {
		boolean deleteStatus = studentService.deleteById(studentId);

		if (deleteStatus) {
			m.addAttribute("rowMsg", "已刪除一筆資料");
		}

		return "/account/student/StudentCrudPage.jsp";

	}

	// 後台修改學生資料
	@PutMapping("/StudentUpdate")
	public String processUpdateAction(@RequestParam("studentId") Integer studentId,
			@RequestParam("studentLastName") String studentLastName,
			@RequestParam("studentFirstName") String studentFirstName,
			@RequestParam("studentUsername") String studentUsername,
			@RequestParam("studentPassword") String studentPassword, @RequestParam("studentEmail") String studentEmail,
			@RequestParam("studentGender") String studentGender, @RequestParam("studentBirth") String studentBirth,
			@RequestParam("studentCountry") String studentCountry, @RequestParam("studentMobile") String studentMobile,
			@RequestParam("studentEducation") String studentEducation,
			@RequestParam("learningFrequency") String learningFrequency, Model m) throws ParseException {

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(studentBirth);

		StudentBean studentBean = new StudentBean();
		studentBean.setStudentId(studentId);
		studentBean.setStudentLastName(studentLastName);
		studentBean.setStudentFirstName(studentFirstName);
		studentBean.setStudentUsername(studentUsername);
		studentBean.setStudentPassword(studentPassword);
		studentBean.setStudentEmail(studentEmail);
		studentBean.setStudentGender(studentGender);
		studentBean.setStudentBirth(date);
		studentBean.setStudentCountry(studentCountry);
		studentBean.setStudentMobile(studentMobile);
		studentBean.setStudentEducation(studentEducation);
		studentBean.setLearningFrequency(learningFrequency);
		studentService.updateStudentBean(studentBean);

		// 把東西丟到頁面
		m.addAttribute("rowMsg", "已更新學生帳號");

		return "/account/student/StudentCrudPage.jsp";
	}
}
