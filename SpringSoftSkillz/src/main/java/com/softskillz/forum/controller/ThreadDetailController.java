package com.softskillz.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@SessionAttributes(names = {"thread"})
public class ThreadDetailController {

	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@GetMapping("/forum/{category}/thread/{threadId}")
	public String getThreadDetail(
			@PathVariable("category") String categoryName, 
			@PathVariable("threadId") int threadId, 
			Model model) {
		
		ForumThreadBean thread = interfaceForumThreadService.selectThreadById(threadId);

		if (thread != null) {
			categoryName=thread.getForumCategoryBean().getForumCategoryName();
			threadId=thread.getThreadId();
			model.addAttribute("thread", thread);
			return "forum/pages/threadDetail";
		} else {
			model.addAttribute("threadNotFound", "文章不存在或已刪除");
			return "forum/pages/threadDetail";
		}

	}

}
