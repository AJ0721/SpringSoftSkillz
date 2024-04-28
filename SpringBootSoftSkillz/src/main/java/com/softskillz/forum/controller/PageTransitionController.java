package com.softskillz.forum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.account.model.AdminBean;
import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;


@SessionAttributes(names={"student","teacher","username","admin"})
@Controller
@RequestMapping("/forum")
public class PageTransitionController {
	
	//to frontstage home
	@GetMapping("/userhome.controller")
    public String showUserForumHome(Model model){
		
		StudentBean student =(StudentBean)model.getAttribute("student");
		TeacherBean teacher = (TeacherBean)model.getAttribute("teacher");
		
		
		if(student != null) {
			String sUsername = student.getStudentUsername();
			model.addAttribute("username", sUsername);
		}else if (teacher != null) {
			String tUsername =teacher.getTeacherUserName();
		model.addAttribute("username", tUsername);
		}else {model.addAttribute("username", "guest");}
		
		return "/pages/jsp/forumFrontstageHome"; 
    }
	
	// to backstage home
	@GetMapping("/adminhome")
    public String showAdminForumHome(Model model) {
		/*
		AdminBean admin=(AdminBean)model.getAttribute("admin");
		if(admin != null) {
			return "pages/forumBackstageHome"; 	
		}
		*/
		AdminBean admin1= new AdminBean();
		admin1.setAdminId(1);
		model.addAttribute("admin", admin1);
		return "pages/jsp/forumBackstageHome";

    }
	
	//to backstage category details
	
	//to backstage category insert
	@GetMapping("/admin/category/insert")
	public String adminNewCategory(Model model) {
		/*
		AdminBean admin=(AdminBean)model.getAttribute("admin");
		if(admin != null) {
			return "pages/forumBackstageHome"; 	
		}
		*/
		AdminBean admin1= new AdminBean();
		admin1.setAdminId(1);
		model.addAttribute("admin", admin1);
		return "pages/jsp/insertForumCategory";

		
	}
	
	//to backstage category insert
		@GetMapping("/admin/category/update")
		public String adminUpdateCategory(Model model) {
			/*
			AdminBean admin=(AdminBean)model.getAttribute("admin");
			if(admin != null) {
				return "pages/forumBackstageHome"; 	
			}
			*/
			AdminBean admin1= new AdminBean();
			admin1.setAdminId(1);
			model.addAttribute("admin", admin1);
			return "pages/jsp/updateForumCategory";

			
		}
	
	//to thread details page
	
	
	

}
