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
import com.softskillz.companion.model.CompanionMatchBean;
import com.softskillz.companion.model.CompanionMatchDAO;

@Controller
public class CompanionMatchController {

	@Autowired
	private CompanionMatchDAO companionMatchDAO;

	// 查詢單筆 id
	@RequestMapping(value = "/GetCompanionMatchById", method = RequestMethod.POST)
	public ModelAndView getCompanionById(@RequestParam("fk_student_a_id") Integer studentAId) {
		ModelAndView view = new ModelAndView("Companion/CompanionSelect/selectMatchById");
		try {
			CompanionMatchBean companion = companionMatchDAO.selectById(studentAId);
			view.addObject("companion", companion);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}


}
