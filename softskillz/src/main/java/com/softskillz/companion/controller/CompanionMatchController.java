package com.softskillz.companion.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.companion.model.CompanionBean;
import com.softskillz.companion.model.CompanionMatchBean;
import com.softskillz.companion.model.CompanionMatchService;

@Controller
public class CompanionMatchController {

	@Autowired
	private CompanionMatchService companionMatchService;

	// 查詢單筆 id
//	@GetMapping("/GetCompanionMatchById")
//	public ModelAndView getCompanionById(@RequestParam("fk_student_a_id") Integer studentAId) {
//		ModelAndView view = new ModelAndView("/Companion/CompanionSelect/selectMatchById");
//		try {
//			List<CompanionMatchBean> companionMatch = companionMatchService.getByStudentAId(studentAId);
//			view.addObject("companionMatch", companionMatch);
//		} catch (Exception e) {
//			e.printStackTrace();
//			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
//		}
//		return view;
//	}
	// 查詢單筆 id
	@GetMapping("/GetCompanionMatchById")
	public ModelAndView getCompanionById(@RequestParam(name="fk_student_a_id",required = false) CompanionBean companionAId) {
		ModelAndView view = new ModelAndView("/companion/jsp/Companion/CompanionSelect/selectMatchById.jsp");
		ModelAndView view2 = new ModelAndView("/companion/jsp/Companion/CompanionSelect/selectByIdErr.jsp");
		System.out.println(companionAId);
	    if (companionAId == null) {
	        // 如果缺少參數，導向到指定的視圖
	        return view2;
	    }
		try {
			List<CompanionMatchBean> companionMatch = companionMatchService.getByStudentAId(companionAId);
			
				view.addObject("companionMatch", companionMatch);
			
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;

	}


}
