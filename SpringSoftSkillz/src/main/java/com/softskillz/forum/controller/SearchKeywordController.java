package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.forum.model.ForumThreadBean;
import com.softskillz.forum.model.InterfaceForumThreadService;

@Controller
public class SearchKeywordController {
	
	@Autowired
	private InterfaceForumThreadService interfaceForumThreadService;
	
	@GetMapping("/forum.searchkeyword.controller")
	public String searchKeyword(@RequestParam(name = "search" )String keyword, Model model)  {
		List<ForumThreadBean> keywordResultThreads = interfaceForumThreadService.selectThreadsByKeyword(keyword);
		
		if(! keyword.isEmpty()) {
			model.addAttribute("threads", keywordResultThreads);
			return "forum/pages/keywordResult";
		}
		
		return "redirect:forumhome.controller";
		
	}
	

}
