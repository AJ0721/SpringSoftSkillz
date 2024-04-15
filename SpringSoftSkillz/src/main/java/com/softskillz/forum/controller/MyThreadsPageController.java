package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;

import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

@SessionAttributes(names = { "student", "teacher", "threads","thread" })
@Controller
public class MyThreadsPageController {

	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@GetMapping("/forum.mythreadspage.controller")
	public String getThreadsByCreatorId(Model model) {

		StudentBean student = (StudentBean) model.getAttribute("student");
		TeacherBean teacher = (TeacherBean) model.getAttribute("teacher");

		Integer creatorId = null;
		if (student != null) {
			creatorId = student.getStudentId();
			List<ForumThreadBean> threads1 = interfaceForumThreadService.selectThreadsByStudentId(creatorId);

			model.addAttribute("threads", threads1);
		} else if (teacher != null) {
			creatorId = teacher.getTeacherId();
			List<ForumThreadBean> threads2 = interfaceForumThreadService.selectThreadsByTeacherId(creatorId);
			model.addAttribute("threads", threads2);
		} else {
			return "forum/pages/login";
		}

		return "forum/pages/myThreadsPage";
	}

}
