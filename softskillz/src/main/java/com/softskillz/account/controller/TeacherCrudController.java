package com.softskillz.account.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.StudentNewPwdBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.bean.TeacherNewPwdBean;
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
	public String processUpdateAction(@RequestParam("teacherId") Integer teacherId,
			@RequestParam("teacherUserName") String teacherUserName,
			@RequestParam("teacherLastName") String teacherLastName,
			@RequestParam("teacherFirstName") String teacherFirstName,
			@RequestParam("teacherPassword") String teacherPassword, @RequestParam("teacherBirth") String teacherBirth,
			@RequestParam("teacherEmail") String teacherEmail, @RequestParam("teacherGender") String teacherGender,
			@RequestParam("teacherCountry") String teacherCountry, @RequestParam("teacherMobile") String teacherMobile,
			@RequestParam("teacherEducation") String teacherEducation, @RequestParam("teachTime") String teachTime,
			@RequestParam("experience") String experience, @RequestParam("status") String status,
			@RequestParam("strength") String strength, @RequestParam("subject") String subject, Model m)
			throws ParseException {

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
		return "/elearning/account/teacher/TeacherLoginFront.jsp";
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
			return "/elearning/account/teacher/TeacherLoginFront.jsp";
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
			@RequestParam("teachTime") String teachTime, @RequestParam("strength") String strength,
			@RequestParam(value = "teacherPhoto", required = false) String teacherPhoto, // 將此參數設為可選
			Model m)
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
		
		// 如果未提供照片，則使用預設照片
				insertBean.setTeacherPhoto(teacherPhoto != null ? teacherPhoto
						: "/dist/account/teacher/images/teacher04.jpg");

		TeacherBean resultBean = teacherService.insert(insertBean);

		if (resultBean == null) {
			m.addAttribute("createMsg", "該帳號已被使用");
		} else {
			m.addAttribute("createMsg", "帳號創建成功");
		}
		return "/elearning/account/teacher/TeacherLoginFront.jsp";
	}

	// 個人中心，修改資料
	// 後台修改，印舊資料
	@GetMapping({ "/teacher-info" })
	public String teacherUpdateFront(HttpSession session, Model m) {

		TeacherBean teacherData = (TeacherBean) session.getAttribute("teacherData");

		m.addAttribute("teacher", teacherData);

		return "/elearning/account/teacher/TeacherInfo.jsp";
	}

	// 前台修改學生資料
	@PutMapping("/TeacherInfo")
	public String updateStudentInfo(@RequestParam("teacherId") Integer teacherId,
			@RequestParam("teacherLastName") String teacherLastName,
			@RequestParam("teacherFirstName") String teacherFirstName,
			@RequestParam("teacherUserName") String teacherUserName,
			@RequestParam("teacherGender") String teacherGender, @RequestParam("teacherBirth") String teacherBirth,
			@RequestParam("teacherMobile") String teacherMobile, @RequestParam("teacherEmail") String teacherEmail,
			@RequestParam("teacherPassword") String teacherPassword,
			@RequestParam("teacherCountry") String teacherCountry, @RequestParam("subject") String subject,
			@RequestParam("experience") String experience, @RequestParam("status") String status,
			@RequestParam("teachTime") String teachTime, @RequestParam("strength") String strength,
			@RequestParam("teacherEducation") String teacherEducation,
			@RequestParam("teacherPhoto") MultipartFile teacherPhoto, HttpServletRequest request, Model m)
			throws ParseException, IllegalStateException, IOException {

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(teacherBirth);

		TeacherBean teacherBean = teacherService.findById(teacherId);
		teacherBean.setTeacherLastName(teacherLastName);
		teacherBean.setTeacherFirstName(teacherFirstName);
		teacherBean.setTeacherUserName(teacherUserName);
		teacherBean.setTeacherGender(teacherGender);
		teacherBean.setTeacherBirth(date);
		teacherBean.setTeacherMobile(teacherMobile);
		teacherBean.setTeacherEmail(teacherEmail);
		teacherBean.setTeacherPassword(teacherPassword);
		teacherBean.setTeacherEmail(teacherEmail);
		teacherBean.setTeacherPassword(teacherPassword);
		teacherBean.setTeacherCountry(teacherCountry);
		teacherBean.setSubject(subject);
		teacherBean.setExperience(experience);
		teacherBean.setStatus(status);
		teacherBean.setTeachTime(teachTime);
		teacherBean.setStrength(strength);
		teacherBean.setTeacherEducation(teacherEducation);

		if (!teacherPhoto.isEmpty()&&teacherPhoto.getSize()>0) {
			
			String teacherPhotoFileName = processImage(teacherPhoto);
			// 存進資料庫
			teacherBean.setTeacherPhoto(teacherPhotoFileName);
			
		}

		teacherService.updateTeacherBean(teacherBean);

		// 把東西丟到頁面
		m.addAttribute("rowMsg", "已更新學生帳號");

		request.getSession().setAttribute("teacherData", teacherBean);

		return "redirect:/teacher/teacher-info";
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
		if (i >= 0) {
			extension = fileName.substring(i);
		}

		Random random = new Random();
		int raNumber = random.nextInt(10000);

		fileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + "_" + raNumber
				+ extension;

		String saveFileDirPath = "/Users/Wei/iSpan/SoftSkillz-git/softskillz/src/main/webapp/WEB-INF/dist/account/teacher/images/";
		File saveFileDir = new File(saveFileDirPath);

		if (!saveFileDir.exists()) {
			saveFileDir.mkdirs();
			System.out.println("upload directory created");
		}

		File saveFilePath = new File(saveFileDir, fileName);

		// 上傳檔案路徑到專案
		mf.transferTo(saveFilePath);

		fileName = "/teacher/images/" + fileName;
		System.out.println("saveFilePath:" + saveFilePath);

		return fileName;
	}
	
	/************************************
	 * 寄驗證碼
	 * 
	 * @throws jakarta.mail.MessagingException
	 *************************************/
	
	// 忘記密碼網頁
	@GetMapping({ "/teacher-forgotPassword" })
	public String teacherForgotPassword() {
		return "/elearning/account/teacher/TeacherForgotPwd.jsp";
	}
	
	@PostMapping("/TeacherForgotPwd")
	public String insertForgotPwd(@RequestParam("teacherEmail") String teacherEmail, Model model)
			throws MessagingException, jakarta.mail.MessagingException {
		String token = UUID.randomUUID().toString();
		Optional<TeacherBean> optional = teacherService.findTeacherByEmail(teacherEmail);
		if (optional != null && optional.isPresent()) {
			TeacherBean teacherBean = optional.get();
			int tId = teacherBean.getTeacherId();
			TeacherNewPwdBean bean = new TeacherNewPwdBean();
			bean.settId(tId);
			bean.setToken(token);
			bean.setTeacherRegistrationDate(LocalDateTime.now());

			teacherService.insertForgotPwd(bean);
			String receivers = teacherEmail;
			String subject = "忘記密碼通知信";
			
			String resetPwdLink = "http://localhost:8080/teacher/reset-password?token="+token;
			String content = mailContent(resetPwdLink);
			String from = "SoftSkillz<itslowei@gmail.com>";
			teacherService.sendPlainText(receivers, subject, content, from);
			model.addAttribute("msg", "信件已發送，請前往信箱查看");
//			return "/student/student-forgotPasssword"; 錯誤！redirect會清空attribute，controller的寫法要用redirect寫
			return "/elearning/account/teacher/TeacherForgotPwd.jsp";
		}
		model.addAttribute("msg", "該信箱尚未註冊");
		return "/elearning/account/teacher/TeacherForgotPwd.jsp";
	}


	private String mailContent(String resetLink) {
	    String content = "<!DOCTYPE html>"
	            + "<html lang='zh-TW'>"
	            + "<body>"
	            + "    <div style='background-color: #ffffff; width: 80%; max-width: 600px; padding: 20px; border: 5px solid #ccc; border-radius: 20px;'>"
	            + "        <div style='text-align: center; background-color: #ffffff;'>"
	            + "            <h1 style='color: #386391;'>重設密碼</h1>"
	            + "            <p>請點擊以下連結，以設定一組新的密碼：</p>"
	            + "            <a href='" + resetLink + "' style='display: inline-block; width: 250px; background-color: #386391; color: white; text-align: center; padding: 10px 0; text-decoration: none; border-radius: 5px; font-size: 20px; margin: 20px 0;'>設定新密碼</a>"
	            + "            <p>如果您沒有請求重設密碼，請忽略這封郵件。</p>"
	            + "            <p>from SoftSkillz Team</p>"
	            + "        </div>"
	            + "    </div>"
	            + "</body>"
	            + "</html>";
	    return content;
	}
	

	@GetMapping("/reset-password")
	public String resetPassword(@RequestParam("token") String token, HttpSession session) {
		
		System.out.println("token : " + token);
		
		/* 紀錄當前時間 */
		LocalDateTime now = LocalDateTime.now();

		/* 創建一個Optional物件 */
		Optional<TeacherNewPwdBean> optionalToken = teacherService.findToken(token);

		/* 驗證此token是否存在並回傳布林值 */
		boolean exist = optionalToken.isPresent();

		if (exist) {
			/* 如果此資料存在，創建他的bean物件 */
			TeacherNewPwdBean resetBean = optionalToken.get();
			System.out.println("token : " + resetBean.getToken());
			System.out.println("studentID : " + resetBean.gettId());
			
			/* 設定session提供後續作使用 */
			session.setAttribute("forgetMemberBean", resetBean);

			/* 紀錄此筆ID */
			Integer thisID = resetBean.getTokenId();

			/* 抓取創建時間 */
			LocalDateTime harvestTime = resetBean.getTeacherRegistrationDate();

			/* 抓取此token資料使否使用過 */
			//boolean used = resetBean.isUsed();

			/* 取得當前時間與創建時間之間的時間差 */
			long minutesDifference = ChronoUnit.MINUTES.between(harvestTime, now);

			/* 判斷時間差是否大於15 */
			boolean timeOut = minutesDifference > 15;

			if (timeOut == false) {
				/* 比較TOKEN */
				if (token.equals(resetBean.getToken())) {
					teacherService.deleteToken(thisID);
					//驗證成功
					return "/elearning/account/teacher/TeacherResetPwd.jsp";
				} else {
					//驗證失敗
					teacherService.deleteToken(thisID);
					return "/elearning/account/teacher/TokenErr.jsp";
				}
			} else {
				//這個token超時
				teacherService.deleteToken(thisID);
				return "/elearning/account/teacher/TokenTimeOut.jsp";
			}
		} else {
			//這個token不存在
			return "/elearning/account/teacher/TokenNotExist.jsp";
		}

	}
	
	@PostMapping("/TeacherResetPwd")
	public String studentResetPassword(@RequestParam("teacherPassword") String teacherPassword,
	        HttpSession session, Model model) {
		
		TeacherNewPwdBean forgetMemberBean = (TeacherNewPwdBean) session.getAttribute("forgetMemberBean");
	    
	    if (forgetMemberBean == null) {
	        model.addAttribute("msg", "無效的請求，請重新申請重設密碼");
	        System.out.println("無效的請求，請重新申請重設密碼");
	        return "redirect:/teacher/teacher-forgotPasssword";
	    }

	    Integer tId = forgetMemberBean.gettId();
	    System.out.println("會員ID: " + tId);
	    TeacherBean forgetPasswordMember = teacherService.findById(tId);
	    forgetPasswordMember.setTeacherPassword(teacherPassword);
	    teacherService.updateTeacherBean(forgetPasswordMember);
	    return "redirect:/teacher/teacher-loginPage";
	}
	
	

}
