package com.softskillz.forum.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.forum.model.ForumCategoryBean;
import com.softskillz.forum.model.ForumCategoryDao;
import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;
import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@SessionAttributes(names = { "student", "teacher", "username"})
public class InsertThreadController {

	@Autowired
	private ForumCategoryDao forumCategoryDao;
	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@GetMapping("/forum/newthread/{username}")
	public String showInsertThreadPage(@PathVariable("username") String username, Model model) {

		StudentBean student = (StudentBean) model.getAttribute("student");
		TeacherBean teacher = (TeacherBean) model.getAttribute("teacher");
		
		if (student ==null && teacher == null) {
			return "redirect: /SpringSoftSkillz/loginpage.controller";
		}
		


		Set<ForumCategoryBean> ForumCategoryBeans = forumCategoryDao.getAllCategories();
		model.addAttribute("forumCategoryBeans", ForumCategoryBeans);

		return "forum/pages/insertThreadPage";

	}

	@PostMapping("/forum.insertthread.controller")
	public String intertThread(
			@RequestParam("category") int categoryId, @RequestParam("title") String title,
			@RequestParam("content") String content  ,@ModelAttribute("username") String username
			 ,Model model) {

		StudentBean student = (StudentBean) model.getAttribute("student");
		TeacherBean teacher = (TeacherBean) model.getAttribute("teacher");
	

		ForumCategoryBean category = forumCategoryDao.getCategoryById(categoryId);

		if (category != null && !title.isBlank() && !content.isBlank()) {
			ForumThreadBean newThread = new ForumThreadBean(title, content, category);
		

			if (student != null) {
				newThread.setStudentBean(student);
			} else if (teacher != null) {
				newThread.setTeacherBean(teacher);
			} else {
				model.addAttribute("userNotFound", "查無使用者，請重新整理");
			}

			model.addAttribute("thread", newThread);
			model.addAttribute("success", "文章更新成功!");
			interfaceForumThreadService.updateThread(newThread);
		} else {
			model.addAttribute("updateFailed", "文章更新失敗，請重新整理");

		}

		return "redirect:/forum/mythreads/" + username;

	}

}
