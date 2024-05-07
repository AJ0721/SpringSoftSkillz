package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.service.IForumThreadService;

@RestController
@RequestMapping("/forum/thread/")
public class ForumThreadController {
	@Autowired
	private IForumThreadService forumThreadService;

	//find threads by username
	
	
	@PostMapping("/insert")
	public ForumThreadDto insertThread(@RequestBody ForumThreadDto threadDto) {
		//hardcode admin
	
		System.out.println(threadDto);
		threadDto.setAdminId(1);  //
	    
	    return forumThreadService.insertForumThread(threadDto);

	}
	

	@PutMapping("/update/{threadId}")
	public ForumThreadDto updateThread(@PathVariable int threadId, @RequestBody ForumThreadDto threadDto) {

		ForumThreadDto updatedThread = forumThreadService.updateForumThreadById(threadId, threadDto);
		return updatedThread;
	}

	// Delete a thread by ID
	@DeleteMapping("/delete/{threadId}")
	public void deleteThread(@PathVariable int threadId) {

		forumThreadService.deleteForumThreadById(threadId);

	}
	
	@DeleteMapping("/deleteall")
	public void deleteAllThreads(@RequestBody ForumThreadDto threadDtos) {
		ForumThreadDto idToBeDelete = threadDtos;
		forumThreadService.deleteAllForumThreads(idToBeDelete.getThreadIds());
		System.out.println(idToBeDelete);
		
	}

	// Find all threads
	@GetMapping("/findall")
	public List<ForumThreadDto> findAllThreads() {
		return forumThreadService.findAllThreads();
	}

	// Find threads by keyword
	@GetMapping("/search")
	public List<ForumThreadDto> findThreadsByKeyword(@RequestParam String keyword) {
		return forumThreadService.findThreadsByKeyword(keyword);
	}

	// Find thread by ID
	@GetMapping("/find/id/{threadId}")
	public ForumThreadDto findThreadById(@PathVariable Integer threadId) {

		ForumThreadDto threadDto = forumThreadService.findThreadByThreadId(threadId);
		return threadDto;
	}

	// Find threads by teacher ID
	@GetMapping("/teacherid/{teacherId}")
	public List<ForumThreadDto> findThreadsByTeacherId(@PathVariable Integer teacherId) {
		return forumThreadService.findThreadsByTeacherId(teacherId);
	}

	// Find threads by student ID
	@GetMapping("/studentid/{studentId}")
	public List<ForumThreadDto> findThreadsByStudentId(@PathVariable Integer studentId) {
		return forumThreadService.findThreadsByStudentId(studentId);
	}

}
