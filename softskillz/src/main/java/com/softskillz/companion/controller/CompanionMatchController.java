package com.softskillz.companion.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.softskillz.companion.model.CompanionBean;
import com.softskillz.companion.model.CompanionMatchBean;
import com.softskillz.companion.model.CompanionMatchService;
import com.softskillz.companion.model.CompanionService;

@Controller
public class CompanionMatchController {

	@Autowired
	private CompanionMatchService companionMatchService;

	@Autowired
	private CompanionService companionService;
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
	public ModelAndView getCompanionById(@RequestParam("nickname")String studentNickname) {
		ModelAndView view = new ModelAndView("dist/companion/CompanionSelect/selectMatchById.jsp");
		ModelAndView view2 = new ModelAndView("dist/companion/CompanionSelect/selectByIdErr.jsp");
		System.out.println(studentNickname);
	    if (studentNickname == null) {
	        return view2;
	    }
		try {
			CompanionBean companionBeanA = companionService.getByName(studentNickname);
			Set<CompanionMatchBean> companionMatch = companionBeanA.getCompanionMatchA();
			
			List<CompanionMatchBean> companionMatches = new ArrayList<CompanionMatchBean>();
			for (CompanionMatchBean match : companionMatch) {
		        if ("Yes".equals(match.getMatchRequest()) && !isMatchExist(companionMatches, match)) {
		        	System.out.println(match.getMatchRequest());
		        	companionMatches.add(match);
		        }
			}
			view.addObject("companionMatch", companionMatches);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;

	}
	
	// 檢查是否已存在相同的match在列表中
	private boolean isMatchExist(List<CompanionMatchBean> companionMatches, CompanionMatchBean match) {
	    for (CompanionMatchBean existingMatch : companionMatches) {
	        if (existingMatch.getCompanionAId() == match.getCompanionAId() && existingMatch.getCompanionBId() == match.getCompanionBId()) {
	            return true;
	        }
	    }
	    return false;
	}

	// 測試 查詢所有使用者已經遇到過的學伴(無論是按申請配對或隱藏學伴)
	@GetMapping("/MR")
	@ResponseBody
	public void getAllCompanions() {
		try {
			List<CompanionBean> companions = companionMatchService.findByIHaveMetCompanion("Wendy");
			System.out.println(companions);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
