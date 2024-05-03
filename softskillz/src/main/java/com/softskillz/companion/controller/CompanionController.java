package com.softskillz.companion.controller;

import java.lang.ProcessBuilder.Redirect;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.companion.model.CompanionBean;
import com.softskillz.companion.model.CompanionMatchBean;
import com.softskillz.companion.model.CompanionMatchService;
import com.softskillz.companion.model.CompanionService;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
//@SessionAttributes(names= {"companionUsername"})
public class CompanionController {

	@Autowired
	private CompanionService companionService;
	
	@Autowired
	private CompanionMatchService companionMatchService;
	
	@Autowired
	private StudentService studentService;
	
	@PostMapping("/insertJSP")
	public String insertJSP() {
		return "/companion/jsp/Companion/CompanionInsert/insert.jsp";
	};
	
	// 新增
	@PutMapping("/Insert")
	@ResponseBody
	public ModelAndView insert(//@RequestParam("companion_id") Integer companionId,
//			@RequestParam("student_id") Integer studentId,
//			@RequestParam("companion_username") String companionUsername,
//			@RequestParam("companion_gender") String companionGender,
//			@RequestParam("companion_birth") String companionBirth,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_about_me") String companionAboutMe,
			HttpSession session
//			,@RequestParam("companion_photo") String companionPhoto
			) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionInsert/insertOK.jsp");
		try {
			CompanionBean companionBean = new CompanionBean();
			StudentBean studentBean = (StudentBean)session.getAttribute("studentID");
//			StudentBean studentBeanID = studentService.getById(studentId);
			
//			String birth = companionBirth;
//			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//			LocalDate newBirth = LocalDate.parse(birth, formatter);
			
			companionBean.setStudentBeanID(studentBean);
//			companionBean.setCompanionUsername(companionUsername);
//			companionBean.setCompanionGender(companionGender);
//			companionBean.setCompanionBirth(companionBirth);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionAboutMe(companionAboutMe);
//			companionBean.setCompanionPhoto(companionPhoto);
			companionService.insert(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 新增學伴配對 先查詢符合興趣之學伴 再insert
//	@PostMapping("/InsertCompanion")
//	public ModelAndView insertCompanion(@RequestParam("companion_id") Integer companionId,
//			@RequestParam("companion_gender") String companionGender,
//            @SessionAttribute("companionUsername") String companionUsername) {
//		ModelAndView view = new ModelAndView("/Companion/CompanionInsert/insertCompanion");
//		try {
//			CompanionMatchBean companionMatch = new CompanionMatchBean();
//			CompanionBean companion = companionService.getByName(companionUsername);
//			companionMatch.setStudentAId(companion.getCompanionId());
//			companionMatch.setStudentBId(companionId);
//			companionMatchService.insert(companionMatch);
////			view.addObject("companion", companion);
//		} catch (Exception e) {
//			e.printStackTrace();
//			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
//		}
//		return view;
//	}
	
	@PostMapping("/InsertCompanion")
	public ModelAndView insertCompanion(@RequestParam("companion_id") Integer companionId
			
//			,@SessionAttribute("companionUsername") String companionUsername
			) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionInsert/insertCompanion.jsp");
		try {
			CompanionMatchBean companionMatch = new CompanionMatchBean();
//			CompanionBean companionBeanA = companionService.getByName(companionUsername);
			CompanionBean companionBeanB = companionService.getById(companionId);
			
//			companionMatch.setCompanionAId(companionBeanA);
			companionMatch.setCompanionBId(companionBeanB);
			
//			Set<CompanionMatchBean> companionMatchA = new LinkedHashSet<>();
//			companionMatchA.add(companionMatch);
			companionMatchService.insert(companionMatch);
//			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 刪除單筆 id
	@DeleteMapping("/DeleteCompanionById")
	@ResponseBody
	public ModelAndView deleteCompanionById(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionSelect/GetAllCompanions.jsp");
		try {
			companionService.deleteById(companionId);
			List<CompanionBean> companions = companionService.getAll();
			System.out.println(companions);
			view.addObject("companions", companions);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢欲修改學伴 單筆 id 
	@GetMapping("/GetUpdateData")
	public ModelAndView getUpdateData(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionUpdate/updateData.jsp");
		try {
			CompanionBean companion = companionService.getById(companionId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 修改單筆 抓id
	@PutMapping("/Update")
	public ModelAndView update(@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId,
			@RequestParam("companion_username") String companionUsername,
//			@RequestParam("companion_gender") String companionGender,
//			@RequestParam("companion_birth") String companionBirth,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_about_me") String companionAboutMe,
			HttpSession session
//			,@RequestParam("companion_photo") String companionPhoto
			) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionUpdate/update.jsp");
		try {
			CompanionBean companionBean = new CompanionBean();
//			String birth = companionBirth;
//			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//			LocalDate newBirth = LocalDate.parse(birth, formatter);
			
			StudentBean studentBeanID = studentService.getById(studentId);
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentBeanID");
			
			companionBean.setCompanionId(companionId);
			companionBean.setStudentBeanID(studentBeanID);
//			companionBean.setCompanionUsername(companionUsername);
//			companionBean.setCompanionGender(companionGender);
//			companionBean.setCompanionBirth(java.sql.Date(newBirth));
//			companionBean.setCompanionBirth(companionBirth);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionAboutMe(companionAboutMe);
//			companionBean.setCompanionPhoto(companionPhoto);
			companionService.update(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	
	// 查詢單筆 id
	@GetMapping("/GetCompanionById")
	public ModelAndView getCompanionById(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionSelect/selectById.jsp");
		try {
			CompanionBean companion = companionService.getById(companionId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢單筆 username
	@GetMapping("/GetCompanionByName")
	public ModelAndView getCompanionByName(@RequestParam("companion_username") String companionUsername) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionSelect/selectByName.jsp");
		try {
//			CompanionBean companion = companionService.getByName(companionUsername);
//			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢多筆符合條件的學伴後 再申請配對
//	@GetMapping("/GetCompanionByInterest")
//	public ModelAndView getCompanionByInterest(
////			@RequestParam("companion_username") String companionUsername,
////			@RequestParam("companion_gender") String companionGender,
//			@RequestParam("companion_first_language") String companionFirstLanguage,
//			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
//			@RequestParam("companion_learning_interest") String companionLearningInterest,
//			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
//			HttpSession session) {
//		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionInsert/CompanionByInterest.jsp");
//		try {
//			List<CompanionBean> companions = companionService.getByInterest(companionLearningInterest,companionGender, companionFirstLanguage, companionSpeakingLanguage, companionLearningFrequency, companionUsername);
//			view.addObject("companions", companions);
//			session.setAttribute("companionUsername", companionUsername);
//			System.out.println(companionLearningInterest);
//			System.out.println(companionGender);
//			if (companionGender == null) {
//			    // 如果變量為 null，執行這裡的程式碼
//			    System.out.println("變量是 null");
//			} else {
//			    // 如果變量不為 null，執行這裡的程式碼
//			    System.out.println("變量不是 null");
//			}
//			view.getModelMap();
//		} catch (Exception e) {
//			e.printStackTrace();
//			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
//		}
//		return view;
//	}
	
	// 查詢全部
	@GetMapping("/GetAllCompanions")
//	@RequestMapping(value = "/GetAllCompanions", method = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT,RequestMethod.DELETE})
	public ModelAndView getAllCompanions() {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionSelect/GetAllCompanions.jsp");
		try {
			List<CompanionBean> companions = companionService.getAll();
			List<StudentBean> students = studentService.findAllStudents();
			System.out.println(companions);
			view.addObject("companions", companions);
			view.addObject("students", students);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	@GetMapping("/companionqueryallpage.controller")
	public String processQueryAllPageAction() {
		return "/companion/jsp/Companion/CompanionSelect/companionQueryAll.jsp";
	}
	
	@GetMapping("/queryByPage/{pageNo}")
	@ResponseBody
	public List<CompanionBean> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m, HttpServletRequest request){
		int pageSize = 5;
		Pageable p1 = PageRequest.of(pageNo-1, pageSize);
		Page<CompanionBean> page = companionService.findAllByPage(p1);
		
		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
		
		HttpSession session = request.getSession();
		
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);
		
//		m.addAttribute("totalPages", totalPages);
//		m.addAttribute("totalElements", totalElements);
		
		return page.getContent();
	}
	

}
