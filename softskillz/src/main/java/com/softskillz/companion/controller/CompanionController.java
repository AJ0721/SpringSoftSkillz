package com.softskillz.companion.controller;

import java.lang.ProcessBuilder.Redirect;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
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
	
	@GetMapping("/insertJSP")
	public String insertJSP() {
		return "/companion/jsp/Companion/CompanionInsert/insert.jsp";
	};
	
	// 新增
	@PutMapping("/Insert")
	@ResponseBody
	public ModelAndView insert(//@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId,
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
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentID");
			StudentBean studentBeanID = studentService.getById(studentId);
			
//			String birth = companionBirth;
//			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//			LocalDate newBirth = LocalDate.parse(birth, formatter);
			
			companionBean.setStudentBeanID(studentBeanID);
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
	
	// 舊的 新增學伴配對 先查詢符合興趣之學伴 再insert
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
	
	// 新增學伴配對 先查詢符合興趣之學伴 再申請配對後 會修改配對紀錄表的狀態欄位 可新增配對時間
	@PostMapping("/InsertCompanion")
	public ModelAndView insertCompanion(@RequestParam("companion_id") Integer companionId,
			@RequestParam("like_or_dislike") String likeOrDislike,
			@SessionAttribute("studentNickname") String studentNickname
			) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionInsert/insertCompanion.jsp");
		try {
			CompanionMatchBean companionMatch = new CompanionMatchBean();
			CompanionBean companionBeanA = companionService.getByName(studentNickname);
			CompanionBean companionBeanB = companionService.getById(companionId);
			
			companionMatch.setCompanionAId(companionBeanA);
			companionMatch.setCompanionBId(companionBeanB);
			System.out.println(likeOrDislike);
			if("like".equals(likeOrDislike)) {
				companionMatch.setMatchRequest("Yes");
				
			}else {
				companionMatch.setMatchRequest("No");
			}
			companionMatchService.insert(companionMatch);
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
			CompanionBean companion = companionService.getByName(companionUsername);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢多筆符合條件的學伴後 再申請配對
	@GetMapping("/GetCompanionByMatchRequirement")
	public ModelAndView getCompanionByMatchRequirement(
			@RequestParam("student_nickname") String studentNickname,
			@RequestParam("companion_gender") String companionGender,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			HttpSession session) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionInsert/CompanionByMatchRequirement.jsp");
		try {
			List<CompanionBean> companions = companionService.getByMatchRequirement(companionLearningInterest,
					companionGender, companionFirstLanguage, companionSpeakingLanguage, companionLearningFrequency,
					studentNickname);
			
			List<CompanionBean> companionsIHaveMet = companionMatchService.findByIHaveMetCompanion(studentNickname);
			
			List<CompanionBean> companionsToRemove = new ArrayList<>();
			companionsToRemove.addAll(companionsIHaveMet);
			
			companions.removeAll(companionsToRemove);
			
			// 隨機排序
			Collections.shuffle(companions);

			// 只取前2筆資料，Math.min(companions.size(), 2)，裡面數字決定要取幾筆出來
			List<CompanionBean> randomCompanions = new ArrayList<>(companions.subList(0, Math.min(companions.size(), 2)));
			
//			List<CompanionBean> iLikeCompanions = new ArrayList<>();
//			for (CompanionBean selectedCompanion : companions) {
//				
//				CompanionBean companion = companionService.getByName(studentNickname);
//				
//				//我用條件查出來的學伴，會是配對紀錄表的student_b_id，先找出這些學伴的被配對紀錄
//				Set<CompanionMatchBean> companionMatchA = selectedCompanion.getCompanionMatchA();
//				Set<CompanionMatchBean> companionMatchB = selectedCompanion.getCompanionMatchB();
//				
//				
//				//使用者現在沒有配對紀錄，所以會不符合上面兩個條件，這個時候就要讓使用者查到所有符合配對條件的人
//				boolean noMatchAIdSelectedCompanion = companion.getCompanionMatchA().isEmpty();
//				boolean noMatchBIdSelectedCompanion = companion.getCompanionMatchB().isEmpty();
//				boolean noA = companionMatchA.isEmpty();
//				boolean noB = companionMatchB.isEmpty();
//				if (noMatchAIdSelectedCompanion || noMatchBIdSelectedCompanion) {
//					
//					iLikeCompanions.add(selectedCompanion);
//					
//				}
//				
//				//這些學伴的配對紀錄一筆一筆拿出來看
//				for (CompanionMatchBean matchB : companionMatchB) {
//					//這些學伴的配對紀錄中，我只要student_a_id是現在使用者的id
//					boolean allMatchIdSelectedCompanion = matchB.getCompanionAId().getStudentBeanID().getStudentId().equals(companion.getStudentBeanID().getStudentId());
//					//這些學伴的配對紀錄中，我只要MatchRequest是同意Yes的
//					boolean mR = "Yes".equals(matchB.getMatchRequest());
//					//上面兩者同時成立
//					
//					System.out.println("使用者ID" + companion.getStudentBeanID().getStudentId());
//					if ((allMatchIdSelectedCompanion && mR)) {
//						System.out.println("符合的配對紀錄ID" + matchB.getMatchId());
//						
//						iLikeCompanions.add(selectedCompanion);
//						System.out.println("跳出");
//					}
//
//				}
//
//			}
			view.addObject("companions", randomCompanions);
			session.setAttribute("studentNickname", studentNickname);
//			view.getModelMap();
			
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
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
