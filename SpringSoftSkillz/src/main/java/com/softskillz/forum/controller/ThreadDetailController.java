package com.softskillz.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThreadDetailController {

	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@GetMapping("/forum.threaddetail.controller")
	public String getThreadDetail(@RequestParam(name = "threadId") int threadId, Model model) {
		ForumThreadBean thread = interfaceForumThreadService.selectThreadById(threadId);

		if (thread != null) {
			model.addAttribute("thread", thread);
			return "forum/pages/threadDetail";
		} else {
			model.addAttribute("threadNotFound", "文章不存在或已刪除");
			return "forum/pages/threadDetail";
		}

	}

}
