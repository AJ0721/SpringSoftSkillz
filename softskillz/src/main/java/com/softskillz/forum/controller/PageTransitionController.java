package com.softskillz.forum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.forum.model.UserEnum;

import jakarta.servlet.http.HttpSession;

@SessionAttributes(names = { "student", "teacher", "username", "admin" })
@Controller
@RequestMapping("/forum")
public class PageTransitionController {

	// to frontstage home
	@GetMapping("/home")
	public String showUserForumHome(HttpSession session, Model model) {

		return "/elearning/forum/pages/home/frontHome.html";
	}

	// to frontstage thread detail page
	@GetMapping("/f/thread/id/{threadId}")
	public String frontThreadDetailPage(@PathVariable Integer threadId, Model model) {
		model.addAttribute("threadId", threadId);
		return "/elearning/forum/pages/thread/threadDetail.html";
	}

	// to frontstage myThread
	@GetMapping("/f/user/{type}/{id}")
	public String frontThreadDetailPage(@PathVariable("type") UserEnum userType ,@PathVariable("id") Integer id , Model model) {
		
		return "/elearning/forum/pages/thread/myThread.html";
	}

	public String showUserForumHome(Model model) {

		return "/elearning/forum/home/frontHome.html";
	}

	// to frontstage thread insert
	@GetMapping("/f/thread/insert")
	public String frontCreateThread(Model model) {
		return "/elearning/forum/pages/thread/insertThread.html";
	}

	// to backstage home
	@GetMapping("/adminhome")
	public String showAdminForumHome() {

		return "/dist/forum/home/backHome.html";

	}

	// CATEGORY
	// to category insert
	@GetMapping("/category/insertpage")
	public String adminNewCategory() {
		return "/dist/forum/category/insertForumCategory.html";
	}

	// to category update
	@GetMapping("/category/updatepage/{categoryId}")
	public String adminUpdateCategory(@PathVariable Integer categoryId) {
		return "/dist/forum/category/updateForumCategory.html";
	}

	// to category detail
	@GetMapping("/category/detailpage/{categoryId}")
	public String categoryDetailPage(@PathVariable int categoryId, Model model) {
		model.addAttribute("categoryId", categoryId);
		return "/dist/forum/category/forumCategoryDetail.html";
	}

	// THREAD
	// to thread insert
	@GetMapping("/thread/insertpage")
	public String createThread(Model model) {
		return "/dist/forum/thread/insertForumThread.html";
	}

	// to thread detail
	@GetMapping("/thread/detailpage/{threadId}")
	public String threadDetailPage(@PathVariable Integer threadId, Model model) {
		model.addAttribute("threadId", threadId);
		return "/dist/forum/thread/forumThreadDetail.html";
	}

	// to thread update
	@GetMapping("/thread/updatepage/{threadId}")
	public String updateThread(@PathVariable Integer threadId) {
		return "/dist/forum/thread/updateForumThread.html";
	}

}
