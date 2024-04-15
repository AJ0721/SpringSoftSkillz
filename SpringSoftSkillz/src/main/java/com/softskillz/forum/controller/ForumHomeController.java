package com.softskillz.forum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

@SessionAttributes(names={"student","teacher"})
@Controller
public class ForumHomeController {
	
	
	@GetMapping("/forumhome.controller")
    public String showForumHome(Model model){
		
//		StudentBean student =(StudentBean)model.getAttribute("student");
//		TeacherBean teacher = (TeacherBean)model.getAttribute("teacher");
		
		
		return "forum/pages/forumHome"; 
    }
	
	

}
