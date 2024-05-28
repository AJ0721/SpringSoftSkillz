package com.softskillz.companion.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.companion.model.CompanionBean;
import com.softskillz.companion.model.CompanionDTO;
import com.softskillz.companion.model.CompanionMatchBean;
import com.softskillz.companion.model.CompanionMatchService;
import com.softskillz.companion.model.CompanionService;

import jakarta.servlet.http.HttpSession;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;


@Controller
public class CompanionController {

	@Autowired
	private CompanionService companionService;
	
	@Autowired
	private CompanionMatchService companionMatchService;
	
	@Autowired
	private StudentService studentService;
	
	@GetMapping("/insertJSP")
	public String insertJSP() {
		return "dist/companion/CompanionInsert/insert.jsp";
	};
	
	@GetMapping("/companionIndex")
	public String companionIndex() {
		return "dist/companion/companionIndex.jsp";
	};
	
	@GetMapping("/companionFrontIndex")
	public String companionFrontIndex() {
		return "elearning/companion/companionFrontIndex.jsp";
	};
	
	@GetMapping("/companionFrontChatroom")
	public String companionFrontChatroom(HttpSession session, Model model) {
		
		StudentBean studentData = (StudentBean) session.getAttribute("studentData");
		
	    if (studentData != null) {
		String studentNickname =  studentData.getStudentNickname();
        model.addAttribute("studentNickname", studentNickname);
        return "elearning/companion/companionFrontChatroom.jsp";
	    }else {
	    	model.addAttribute("errorMessageNoStudentData", "請重新登入!");
			return "elearning/companion/companionFrontIndex.jsp";
		}
	};
	
	@GetMapping("/companionFrontCenter")
	public String companionFrontCenter() {
		return "elearning/companion/companionFrontCenter.jsp";
	};
	
	// 後台新增
	@PutMapping("/Insert")
	@ResponseBody
	public ModelAndView insert(//@RequestParam("companion_id") Integer companionId,
//			@RequestParam("companion_first_language") String companionFirstLanguage,
//			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
//			@RequestParam("companion_learning_interest") String companionLearningInterest,
//			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
//			@RequestParam("companion_about_me") String companionAboutMe,
			HttpSession session
//			,@RequestParam("companion_photo") String companionPhoto
			) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionInsert/insertOK.jsp");
		try {
//			Integer studentId =  (Integer) session.getAttribute("studentId");
			StudentBean studentData = (StudentBean) session.getAttribute("studentData");
			StudentBean studentID = studentService.getById(studentData.getStudentId());
			CompanionBean companionBean = new CompanionBean();
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentID");
			
			companionBean.setStudentBeanID(studentID);
			companionService.insert(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 新增學伴配對 先查詢符合興趣之學伴 再申請配對後 會修改配對紀錄表的狀態欄位
	@PostMapping("/InsertCompanion")
	public ModelAndView insertCompanion(@RequestParam("companion_id") Integer companionId,
			@RequestParam("like_or_dislike") String likeOrDislike,
//			@SessionAttribute("studentNickname") String studentNickname
			HttpSession session
			) {
		
		ModelAndView view = new ModelAndView("elearning/companion/companionFrontIndex.jsp");
		try {
			StudentBean studentData = (StudentBean) session.getAttribute("studentData");

//			String studentNickname =  (String) session.getAttribute("studentNickname");
			String studentNickname =  studentData.getStudentNickname();
			System.out.println("取session"+studentNickname);
//			System.out.println(session.getAttribute("studentNickname"));
			CompanionMatchBean companionMatch = new CompanionMatchBean();
			CompanionBean companionBeanA = companionService.getByStudentNickname(studentNickname);
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
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/companionQueryAll.jsp");
		try {
			companionService.deleteById(companionId);
			List<CompanionBean> companions = companionService.getAll();
			System.out.println(companions);
//			view.addObject("companions", companions);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	// 假刪除 點擊刪除時會把資料清除 等同於更新為空白 更新單筆 id
	@PutMapping("/fakeDeleteCompanionById")
	public ModelAndView fakedeleteCompanionById(@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/companionQueryAll.jsp");
		try {
			CompanionBean companionBean = new CompanionBean();
			
			
			StudentBean studentBeanID = studentService.getById(studentId);
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentBeanID");
			
			companionBean.setCompanionId(companionId);
			companionBean.setStudentBeanID(studentBeanID);
			
			companionBean.setCompanionFirstLanguage("");
			companionBean.setCompanionSpeakingLanguage("");
			companionBean.setCompanionLearningInterest("");
			companionBean.setCompanionLearningFrequency("");
			companionBean.setCompanionAboutMe("");
			companionService.update(companionBean);
			
			System.out.println(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢欲修改學伴 單筆 id 
	@GetMapping("/GetUpdateData")
	public ModelAndView getUpdateData(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionUpdate/updateData.jsp");
		try {
			CompanionBean companion = companionService.getById(companionId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 後台修改單筆 抓id
	@PutMapping("/Update")
	public ModelAndView update(@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId,
			@RequestParam("companion_username") String companionUsername,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_about_me") String companionAboutMe,
			@RequestParam("companion_photo") String companionPhoto,
			HttpSession session
			) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/companionQueryAll.jsp");
		try {
			
			StudentBean studentBeanID = studentService.getById(studentId);
//			CompanionBean companionBean = new CompanionBean();
			CompanionBean companionBean = studentBeanID.getCompanionBean();
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentBeanID");
			
			companionBean.setCompanionId(companionId);
			companionBean.setStudentBeanID(studentBeanID);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionAboutMe(companionAboutMe);
//			System.out.println("12"+companionPhoto.isEmpty());
		if(!companionPhoto.isEmpty()) {
			companionBean.setCompanionPhoto("companion/CompanionImg/"+companionPhoto);
			}
			
			companionService.update(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 前台修改個人條件資料 單筆 抓id
	@PutMapping("/UpdateMyData")
	public ModelAndView updateMyData(
//			@RequestParam("companion_id") Integer companionId,
//			@RequestParam("student_id") Integer studentId,
			@RequestParam("companion_username") String companionUsername,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_about_me") String companionAboutMe,
			@RequestParam("companion_photo") String companionPhoto,
			HttpSession session
			) {
		ModelAndView view = new ModelAndView("elearning/companion/companionFrontIndex.jsp");
		try {
			StudentBean studentData = (StudentBean) session.getAttribute("studentData");
			Integer studentId = studentData.getStudentId();
//			StudentBean studentBeanID = studentService.getById(studentId);
//			CompanionBean companionBean = new CompanionBean();
			CompanionBean companionBean = studentData.getCompanionBean();
//			StudentBean studentBean = (StudentBean)session.getAttribute("studentBeanID");
			
//			companionBean.setCompanionId(companionId);
			companionBean.setStudentBeanID(studentData);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionAboutMe(companionAboutMe);
//			System.out.println("12"+companionPhoto.isEmpty());
		if(!companionPhoto.isEmpty()) {
			companionBean.setCompanionPhoto("companion/CompanionImg/"+companionPhoto);
			}
			
			companionService.update(companionBean);
			view.addObject("successUpdate", "個人條件更新成功");
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢單筆 id
	@GetMapping("/GetCompanionById")
	public ModelAndView getCompanionById(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/selectById.jsp");
		ModelAndView viewErr = new ModelAndView("dist/companion/companionIndex.jsp");
		try {
			CompanionBean companion = companionService.getById(companionId);
			if (companion != null) {
				view.addObject("companion", companion);
				return view;
			}else {
				viewErr.addObject("errorMessage", "沒有這個id的資料");
				return viewErr;
			}
		} catch (Exception e) {
			e.printStackTrace();
			viewErr.addObject("errorMessage", "An error occurred: " + e.getMessage());
			return viewErr;
		}
	}
	
	// 查詢單筆 username
	@GetMapping("/GetCompanionByName")
	public ModelAndView getCompanionByName(@RequestParam("companion_username") String companionUsername) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/selectByName.jsp");
		ModelAndView viewErr = new ModelAndView("dist/companion/companionIndex.jsp");
		try {
			CompanionBean companion = companionService.getByStudentNickname(companionUsername);
			if (companion != null) {
				view.addObject("companion", companion);
				return view;
			}else {
				viewErr.addObject("errorMessageErrName", "沒有這個暱稱的資料");
				return viewErr;
			}
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessageErrName", "An error occurred: " + e.getMessage());
			return viewErr;
		}
	}
	
	// 前台查詢個人條件設定 若使用者從未設定個人條件 就直接新增id到sql表 單筆 username
	// 使用者點選「個人條件設定」時，先判斷學伴資料表有無這個studentId，若無，就新增studentId到sql表
	@GetMapping("/GetMyData")
	public ModelAndView getMyData(HttpSession session) {
	    ModelAndView view = new ModelAndView("elearning/companion/companionFrontCenter.jsp");
	    ModelAndView viewErr = new ModelAndView("elearning/companion/companionFrontIndex.jsp");

	    try {
	        StudentBean studentData = (StudentBean) session.getAttribute("studentData");

	        // 檢查 studentData 是否為 null
	        if (studentData == null) {
	            viewErr.addObject("errorMessageNoStudentData", "請重新登入");
	            return viewErr;
	        }

	        String studentNickname = studentData.getStudentNickname();
	        Optional<CompanionBean> optionalCompanion = companionService.findByStudentNickname(studentNickname);

	        if (!optionalCompanion.isPresent()) {
	            // 若 companion 為 null，則創建一個新的 CompanionBean
	            CompanionBean newCompanionBean = new CompanionBean();
	            newCompanionBean.setStudentBeanID(studentData);
	            newCompanionBean.setCompanionFirstLanguage("");
	            newCompanionBean.setCompanionSpeakingLanguage("");
	            newCompanionBean.setCompanionLearningInterest("");
	            newCompanionBean.setCompanionLearningFrequency("");
	            newCompanionBean.setCompanionAboutMe("");
	            newCompanionBean.setCompanionPhoto("companion/CompanionImg/Default.jpg");
	            companionService.saveOrUpdate(newCompanionBean);

	            // 再次查詢新創建的 companion
	            optionalCompanion = companionService.findByStudentNickname(studentNickname);
	        }

	        CompanionBean companion = optionalCompanion.orElse(null);
	        view.addObject("companion", companion);
	        return view;
	    } catch (Exception e) {
	        e.printStackTrace();
	        viewErr.addObject("errorMessageErrName", "An error occurred: " + e.getMessage());
	        viewErr.addObject("errorMessageNoStudentData", "請重新登入!");
	        return viewErr;
	    }
	}

	
	
	// 查詢多筆符合條件的學伴後 再申請配對
	@GetMapping("/GetCompanionByMatchRequirement")
	public ModelAndView getCompanionByMatchRequirement(
//			@RequestParam("student_nickname") String studentNickname,
			@RequestParam("companion_gender") String companionGender,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			HttpSession session) {
		ModelAndView view = new ModelAndView("elearning/companion/CompanionByMatchRequirement.jsp");
		ModelAndView viewErr = new ModelAndView("elearning/companion/companionFrontIndex.jsp");
		try {
			StudentBean studentData = (StudentBean) session.getAttribute("studentData");
			String studentNickname = studentData.getStudentNickname();
			List<CompanionBean> companions = companionService.getByMatchRequirement(companionLearningInterest,
					companionGender, companionFirstLanguage, companionSpeakingLanguage, companionLearningFrequency,
					studentNickname);
			
			List<CompanionBean> companionsIHaveMet = companionMatchService.findByIHaveMetCompanion(studentNickname);
			
			List<CompanionBean> companionsToRemove = new ArrayList<>();
			companionsToRemove.addAll(companionsIHaveMet);
			
			companions.removeAll(companionsToRemove);
			
			// 隨機排序
			Collections.shuffle(companions);

			// 只取前8筆資料，Math.min(companions.size(), 8)，裡面數字決定要取幾筆出來
			List<CompanionBean> randomCompanions = new ArrayList<>(companions.subList(0, Math.min(companions.size(), 8)));
			view.addObject("companions", randomCompanions);
			
			return view;
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
			viewErr.addObject("errorMessageNoStudentData", "請重新登入!!");
			return viewErr;
		}
	}
	
	// 查詢全部
	@GetMapping("/GetAllCompanions")
//	@RequestMapping(value = "/GetAllCompanions", method = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT,RequestMethod.DELETE})
	public ModelAndView getAllCompanions() {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/GetAllCompanions.jsp");
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
	
	// 返回取得資料的jsp
	@GetMapping("/companionqueryallpage.controller")
	public String processQueryAllPageAction() {
		return "dist/companion/CompanionSelect/companionQueryAll.jsp";
	}
	
	@GetMapping("/queryByPage/{pageNo}")
	@ResponseBody
	public List<CompanionDTO> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m, HttpSession session){
	    int pageSize = 5;
	    Pageable p1 = PageRequest.of(pageNo-1, pageSize);
	    Page<CompanionDTO> page = companionService.findAllByPage(p1);
	    
	    List<CompanionDTO> companionDTOList = page.getContent();
	    
	    int totalPages = page.getTotalPages();
	    long totalElements = page.getTotalElements();
	    
	    session.setAttribute("totalPages", totalPages);
	    session.setAttribute("totalElements", totalElements);
	    
	    return companionDTOList;
	}

	//用fetch呼叫這支controller，將使用者選擇的圖片存到指定資料夾
	@PostMapping("/upload2.controller")
	@ResponseBody
	public String processAction(@RequestParam("companion_photo") MultipartFile mf) throws IllegalStateException, IOException {
		String fileName = mf.getOriginalFilename();
		System.out.println("fileName:" + fileName);
		
		
//		String saveFileDirPath = "C:\\Users\\Denton\\Documents\\softskillzworkspace\\softskillz\\src\\main\\webapp\\WEB-INF\\dist\\companion\\CompanionImg";
		String saveFileDirPath = "/Users/wumengyan/Documents/Action/workspace/softskillz/src/main/webapp/WEB-INF/dist/companion/CompanionImg";
		File saveFileDir = new File(saveFileDirPath);
		
		if(!saveFileDir.exists()) {
			saveFileDir.mkdirs();
			System.out.println("upload directory created");
		}
		
		File saveFilePath = new File(saveFileDir, fileName);
		mf.transferTo(saveFilePath);
		System.out.println("saveFilePath:" + saveFilePath);
		
		return "success";
	}
}
