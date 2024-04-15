package com.softskillz.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;

@Controller
@SessionAttributes(names = "thread")
public class DeleteThreadController {

	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@PostMapping("/forum.deletethread.controller")
	public String DeleteThread(@RequestParam("threadId") int threadId, Model model) {

		ForumThreadBean thread = interfaceForumThreadService.selectThreadById(threadId);

		interfaceForumThreadService.deleteThread(thread);
		return "redirect: forum.mythreadspage.controller";

	}

}
