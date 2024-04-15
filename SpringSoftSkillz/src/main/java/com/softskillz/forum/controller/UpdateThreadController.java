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


@SessionAttributes(names = { "student", "teacher", "editThread" })
@Controller
public class UpdateThreadController {

	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;

	@GetMapping("/forum.getupdatethread.controller")
	public String getEditThread(@RequestParam("threadId") int threadId, Model model) {

		ForumThreadBean thread = interfaceForumThreadService.selectThreadById(threadId);

		if (thread != null) {
			model.addAttribute("editThread",thread);
			return "forum/pages/updateThreadPage";
		} else {
			model.addAttribute("threadNotFound", "文章不存在或已刪除");
			return "forum/pages/myThreadsPage";
		}

	}

	@PostMapping("/forum.updatethread.controller")
	public String doEditThread(@RequestParam("title") String threadTitle, 
			@RequestParam("content") String threadContent,
			Model model) {
		ForumThreadBean editThread = (ForumThreadBean) model.getAttribute("editThread");


		if (!threadTitle.isBlank() && !threadContent.isBlank()) {
			editThread.setThreadTitle(threadTitle);
			editThread.setThreadContent(threadContent);

			interfaceForumThreadService.updateThread(editThread);
			model.addAttribute("thread", editThread);
			model.addAttribute("success", "文章更新成功!");
		} else {
			model.addAttribute("updateFailed", "文章更新失敗，請重新整理");
		}
		return "redirect:/forum.mythreadspage.controller";


	}

}
