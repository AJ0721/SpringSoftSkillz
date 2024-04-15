package com.softskillz.companion.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.companion.model.CompanionBean;
import com.softskillz.companion.model.CompanionDAO;
import com.softskillz.companion.model.CompanionDAOInterface;

@Controller
public class CompanionController {

	@Autowired
	private CompanionDAOInterface companionDAO;

	// 新增
	@RequestMapping(value = "/Insert", method = RequestMethod.POST)
	public ModelAndView insert(//@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId,
			@RequestParam("companion_username") String companionUsername,
			@RequestParam("companion_gender") String companionGender,
			@RequestParam("companion_birth") String companionBirth,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_photo") String companionPhoto) {
		ModelAndView view = new ModelAndView("Companion/CompanionInsert/insertOK");
		try {
			CompanionBean companionBean = new CompanionBean();
			String birth = companionBirth;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate newBirth = LocalDate.parse(birth, formatter);
			
//			companionBean.setCompanionId(Integer.parseInt(request.getParameter("companion_id")));
			companionBean.setStudentId(studentId);
			companionBean.setCompanionUsername(companionUsername);
			companionBean.setCompanionGender(companionGender);
//			companionBean.setCompanionBirth(java.sql.Date(newBirth));
			companionBean.setCompanionBirth(companionBirth);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionPhoto(companionPhoto);
			companionDAO.insert(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 新增學伴配對 先查詢單筆 id 再insert
	@RequestMapping(value = "/InsertCompanion", method = RequestMethod.POST)
	public ModelAndView insertCompanion(@RequestParam("companion_id") Integer companionId,
			@RequestParam("companion_learning_interest") String companionLearningInterest) {
		ModelAndView view = new ModelAndView("Companion/CompanionInsert/insertCompanion");
		try {
			CompanionBean companion = companionDAO.insertCompanion(companionId, companionLearningInterest);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 刪除單筆 id
	@RequestMapping(value = "/DeleteCompanionById", method = RequestMethod.POST)
	public ModelAndView deleteCompanionById(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("Companion/CompanionDelete/delete");
		try {
			companionDAO.deleteOne(companionId);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢欲修改學伴 單筆 id 
	@RequestMapping(value = "/GetUpdateData", method = RequestMethod.POST)
	public ModelAndView getUpdateData(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("Companion/CompanionUpdate/updateData");
		try {
			CompanionBean companion = companionDAO.selectById(companionId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 修改單筆 抓id
	@RequestMapping(value = "/Update", method = RequestMethod.POST)
	public ModelAndView update(@RequestParam("companion_id") Integer companionId,
			@RequestParam("student_id") Integer studentId,
			@RequestParam("companion_username") String companionUsername,
			@RequestParam("companion_gender") String companionGender,
			@RequestParam("companion_birth") String companionBirth,
			@RequestParam("companion_first_language") String companionFirstLanguage,
			@RequestParam("companion_speaking_language") String companionSpeakingLanguage,
			@RequestParam("companion_learning_interest") String companionLearningInterest,
			@RequestParam("companion_learning_frequency") String companionLearningFrequency,
			@RequestParam("companion_photo") String companionPhoto) {
		ModelAndView view = new ModelAndView("Companion/CompanionUpdate/update");
		try {
			CompanionBean companionBean = new CompanionBean();
			String birth = companionBirth;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate newBirth = LocalDate.parse(birth, formatter);
			
			companionBean.setCompanionId(companionId);
			companionBean.setStudentId(studentId);
			companionBean.setCompanionUsername(companionUsername);
			companionBean.setCompanionGender(companionGender);
//			companionBean.setCompanionBirth(java.sql.Date(newBirth));
			companionBean.setCompanionBirth(companionBirth);
			companionBean.setCompanionFirstLanguage(companionFirstLanguage);
			companionBean.setCompanionSpeakingLanguage(companionSpeakingLanguage);
			companionBean.setCompanionLearningInterest(companionLearningInterest);
			companionBean.setCompanionLearningFrequency(companionLearningFrequency);
			companionBean.setCompanionPhoto(companionPhoto);
			companionDAO.updateOne(companionBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	
	// 查詢單筆 id
	@RequestMapping(value = "/GetCompanionById", method = RequestMethod.POST)
	public ModelAndView getCompanionById(@RequestParam("companion_id") Integer companionId) {
		ModelAndView view = new ModelAndView("Companion/CompanionSelect/selectById");
		try {
			CompanionBean companion = companionDAO.selectById(companionId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢單筆 username
	@RequestMapping(value = "/GetCompanionByName", method = RequestMethod.POST)
	public ModelAndView getCompanionByName(@RequestParam("companion_username") String companionUsername) {
		ModelAndView view = new ModelAndView("Companion/CompanionSelect/selectByName");
		try {
			CompanionBean companion = companionDAO.selectByName(companionUsername);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢單筆 interest
	@RequestMapping(value = "/GetCompanionByInterest", method = RequestMethod.POST)
	public ModelAndView getCompanionByInterest(
			@RequestParam("companion_username") String companionUsername,
			@RequestParam("companion_learning_interest") String companionLearningInterest) {
		ModelAndView view = new ModelAndView("Companion/CompanionInsert/CompanionByInterest");
		try {
			List<CompanionBean> companions = companionDAO.selectByInterest(companionLearningInterest, companionUsername);
			view.addObject("companions", companions);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}
	
	// 查詢全部
	@RequestMapping(value = "/GetAllCompanions", method = RequestMethod.POST)
	public ModelAndView getAllCompanions() {
		ModelAndView view = new ModelAndView("Companion/CompanionSelect/GetAllCompanions");
		try {
			List<CompanionBean> companions = companionDAO.selectAll();
			System.out.println(companions);
			view.addObject("companions", companions);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

}
