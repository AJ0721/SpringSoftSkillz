package com.softskillz.forum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;


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
		
		return "/forum/pages/jsp/homepage/forumFrontstageHome.jsp"; 
    }
	
	// to backstage home
	@GetMapping("/adminhome")
    public String showAdminForumHome() {
		
		return "/forum/pages/jsp/homepage/forumBackstageHome.jsp";

    }
	
	
//CATEGORY
	//to category insert
	@GetMapping("/category/insertpage")
	public String adminNewCategory() {	
		return "/forum/pages/jsp/category/insertForumCategory.jsp";	
	}
	
	//to category update
		@GetMapping("/category/updatepage/{categoryId}")
		public String adminUpdateCategory(@PathVariable Integer categoryId) {	
			return "/forum/pages/jsp/category/updateForumCategory.jsp";	
		}
		
	//to category detail
		@GetMapping("/category/detailpage/{categoryId}")
		public String categoryDetailPage(@PathVariable int categoryId, Model model) {
		    model.addAttribute("categoryId", categoryId);
		    return "/forum/pages/jsp/category/forumCategoryDetail.jsp"; 
		}
		
		
//THREAD
	//to thread insert
		@GetMapping("/thread/insertpage")
		public String createThread(Model model) {
			return "/forum/pages/jsp/thread/insertForumThread.jsp";
		}
		
		
	//to thread detail
		@GetMapping("/thread/detailpage/{threadId}")
		public String threadDetailPage(@PathVariable Integer threadId, Model model) {
		    model.addAttribute("threadId", threadId);
		    return "/forum/pages/jsp/thread/forumThreadDetail.jsp"; 
		}
		
		
	//to thread update
		@GetMapping("/thread/updatepage/{threadId}")
		public String updateThread(@PathVariable Integer threadId) {	
			return "/forum/pages/jsp/thread/updateForumThread.jsp";	
		}
	
	
	

}
