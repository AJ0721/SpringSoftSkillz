package com.softskillz.account.controller;

import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PutMapping;

@Controller
@RequestMapping("/student")
public class StudentCrudController {

	@Autowired
	private StudentService studentService;

	/************************************ 後台 *************************************/
	// 學生後台頁面
	@GetMapping("/student-account")
	public String StudentCrudPage() {
		return "/dist/account/student/studentCrudPage.jsp";
	}

	// 後台修改，印舊資料
	@GetMapping({ "/student-update" })
	public String goToStudentUpdate(@RequestParam("studentId") Integer studentId, Model m) {

		StudentBean oldStudentBean = studentService.findById(studentId);
		m.addAttribute("student", oldStudentBean);

		return "/dist/account/student/StudentUpdate.jsp";
	}

	// 查詢全部
	@GetMapping("/StudentSelectAll")
	public String processFindAllAction(Model m) {
		List<StudentBean> students = studentService.findAllStudents();
		System.out.println(students);
		m.addAttribute("students", students);

		return "/dist/account/student/studentCrudPage.jsp";
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
		return "/dist/account/student/studentCrudPage.jsp";

	}

	// 刪除
	@DeleteMapping("/StudentDelete")
	public String processDeleteAction(@RequestParam("studentId") Integer studentId, Model m) {
		boolean deleteStatus = studentService.deleteById(studentId);

		if (deleteStatus) {
			m.addAttribute("rowMsg", "已刪除一筆資料");
		}

		// return "/account/student/StudentCrudPage.jsp";
		return "redirect:/student/student-account";

	}

	// 後台修改學生資料
	@PutMapping("/StudentUpdate")
	public String processUpdateAction(@RequestParam("studentId") Integer studentId,
			@RequestParam("studentLastName") String studentLastName,
			@RequestParam("studentFirstName") String studentFirstName,
			@RequestParam("studentUsername") String studentUsername,
			@RequestParam("studentPassword") String studentPassword, @RequestParam("studentEmail") String studentEmail,
			@RequestParam("studentGender") String studentGender, @RequestParam("studentBirth") String studentBirth,
			@RequestParam("studentCountry") String studentCountry,@RequestParam("firstLanguage") String firstLanguage, @RequestParam("studentMobile") String studentMobile,
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
		studentBean.setFirstLanguage(firstLanguage);
		studentBean.setStudentMobile(studentMobile);
		studentBean.setStudentEducation(studentEducation);
		studentBean.setLearningFrequency(learningFrequency);
		studentService.updateStudentBean(studentBean);

		// 把東西丟到頁面
		m.addAttribute("rowMsg", "已更新學生帳號");

		return "redirect:/student/student-account";
	}

	/************************************ 前台 *************************************/
	// 登入
	// 網址頁登入一定要用get方法
	@GetMapping("/student-loginPage")
	public String StudentLoginPage() {
		return "/elearning/account/student/StudentLoginFront.jsp";
	}

	// 登入action
	@PostMapping("/student-login")
	public String studentLoginAction(@RequestParam("usernameOrEmail") String usernameOrEmail,
			@RequestParam("studentPassword") String studentPassword, HttpSession session, Model m) {

		StudentBean studentData = null;

		// 檢查輸入是否包含 '@'，如果有，則視為電子郵件
		if (usernameOrEmail.contains("@")) {
			studentData = studentService.emailCheckLogin(usernameOrEmail, studentPassword);
		} else {
			studentData = studentService.usernameCheckLogin(usernameOrEmail, studentPassword);
		}

		if (studentData != null) {
			session.setAttribute("studentData", studentData);
			return "redirect:/courseFront/selectAllPage";
		} else {
			// redirect只能叫controller，其他時候直接輸入網址
			m.addAttribute("loginMsg", "錯誤的帳號或密碼");
			return "/elearning/account/student/StudentLoginFront.jsp";
		}
	}

	// 登出功能
	@PostMapping("/student-logout")
	public String logoutAction(HttpServletRequest request) {

		// 獲取當前會話，不創建新會話
		// true就是如果你沒有，就叫舊的session，false就是會叫對話過的session
		HttpSession session = request.getSession(false);

		// session != null是對話過的
		if (session != null) {
			session.invalidate(); // 使會話失效
		}
		return "redirect:/student/student-loginPage"; // 重定向到登入頁面
	}

	// 註冊頁面
	@GetMapping({ "/student-createPage" })
	public String goToStudentCreatePage() {
		return "/elearning/account/student/StudentCreate.jsp";
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
			@RequestParam("learningFrequency") String learningFrequency,
			@RequestParam("firstLanguage") String firstLanguage, Model m) throws ParseException {

		Date now = new Date();

		// 解析生日日期
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
		insertBean.setFirstLanguage(firstLanguage);
		insertBean.setStudentRegistrationDate(now); // 設置註冊日期為當前日期

		StudentBean resultBean = studentService.insert(insertBean);

		if (resultBean == null) {
			m.addAttribute("createMsg", "該帳號已被使用");
		} else {
			m.addAttribute("createMsg", "帳號創建成功");
		}
		return "/elearning/account/student/StudentLoginFront.jsp";
	}
	
	//個人中心，修改資料
	// 後台修改，印舊資料
	@GetMapping({ "/student-info" })
	public String studentUpdateFront(HttpSession session, Model m) {

		 StudentBean studentData = (StudentBean) session.getAttribute("studentData");

		  m.addAttribute("student", studentData);

		  return "/elearning/account/student/StudentInfo.jsp";
	}
	
	// 前台修改學生資料
	@PutMapping("/StudentInfo")
	public String updateStudentInfo(@RequestParam("studentId") Integer studentId,
	        @RequestParam("studentLastName") String studentLastName,
	        @RequestParam("studentFirstName") String studentFirstName,
	        @RequestParam("studentUsername") String studentUsername,
	        @RequestParam("studentNickname") String studentNickname,
	        @RequestParam("studentPassword") String studentPassword, 
	        @RequestParam("studentEmail") String studentEmail,
	        @RequestParam("studentGender") String studentGender, 
	        @RequestParam("studentBirth") String studentBirth,
	        @RequestParam("studentMobile") String studentMobile,
	        @RequestParam("studentPhoto") MultipartFile studentPhoto,
	        HttpServletRequest request, Model m) throws ParseException, IllegalStateException, IOException {

	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = simpleDateFormat.parse(studentBirth);

	    StudentBean studentBean = new StudentBean();	   
	    studentBean.setStudentId(studentId);
	    studentBean.setStudentLastName(studentLastName);
	    studentBean.setStudentFirstName(studentFirstName);
	    studentBean.setStudentUsername(studentUsername);
	    studentBean.setStudentNickname(studentNickname);
	    studentBean.setStudentPassword(studentPassword);
	    studentBean.setStudentEmail(studentEmail);
	    studentBean.setStudentGender(studentGender);
	    studentBean.setStudentBirth(date);
	    studentBean.setStudentMobile(studentMobile);
	    
	    String studentPhotoFileName = processImage(studentPhoto);
	    
	    //存進資料庫
	    studentBean.setStudentPhoto(studentPhotoFileName);
	    
	    studentService.updateStudentBean(studentBean);

	    // 把東西丟到頁面
	    m.addAttribute("rowMsg", "已更新學生帳號");

	    request.getSession().setAttribute("studentData", studentBean);
	    
	    return "redirect:/student/student-info";
	}
	 
	 

	 private String processImage(MultipartFile mf) throws IllegalStateException, IOException {
		   if (mf.isEmpty()) {
		        System.out.println("No file uploaded");
		        return "File is empty";
		    }
		 
		 String fileName = mf.getOriginalFilename();
	  System.out.println("fileName:" + fileName);
	  
	  String extension = "";

      int i = fileName.lastIndexOf('.');
      if(i >= 0) {
          extension = fileName.substring(i);
      }
      
      Random random = new Random();
      int raNumber = random.nextInt(10000);

      fileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + "_"
              + raNumber + extension;

	  
	  String saveFileDirPath = "/Users/Wei/iSpan/SoftSkillz-git/softskillz/src/main/webapp/WEB-INF/dist/account/student/images/";
	  File saveFileDir = new File(saveFileDirPath);
	  
	  
	  
	  if(!saveFileDir.exists()) {
	   saveFileDir.mkdirs();
	   System.out.println("upload directory created");
	  }
	  
	  File saveFilePath = new File(saveFileDir, fileName);
	  mf.transferTo(saveFilePath);
	  System.out.println("saveFilePath:" + saveFilePath);
	  
	  return fileName;
	 }

}
