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

import com.softskillz.forum.model.ForumCategoryIdListDto;
import com.softskillz.forum.model.ForumThreadDto;
import com.softskillz.forum.model.ForumThreadModel;
import com.softskillz.forum.model.IDtoConverter;
import com.softskillz.forum.model.IForumThreadService;

@RestController
@RequestMapping("/forum/thread/")
public class ForumThreadController {
	@Autowired
	private IForumThreadService iforumThreadService;

	//find threads by username
	
	
	@PostMapping("/insert")
	public ForumThreadDto insertThread(@RequestBody ForumThreadDto threadDto) {
		//hardcode admin
	
	
		threadDto.setAdminId(1);  //
	    
	    return iforumThreadService.insertForumThread(threadDto);

	}
	

	@PutMapping("/update/{threadId}")
	public ForumThreadDto updateThread(@PathVariable int threadId, @RequestBody ForumThreadDto threadDto) {

		ForumThreadDto updatedThread = iforumThreadService.updateForumThreadById(threadId, threadDto);
		return updatedThread;
	}

	// Delete a thread by ID
	@DeleteMapping("/delete/{threadId}")
	public void deleteThread(@PathVariable int threadId) {

		iforumThreadService.deleteForumThreadById(threadId);

	}
	
	// bulk delete by ID
	@DeleteMapping("/deleteall")
	public void deleteAllThreads(@RequestBody ForumThreadDto threadListDtos) {
		ForumThreadDto idToBeDelete = threadListDtos;
		iforumThreadService.deleteAllForumThreads(idToBeDelete.getThreadIds());
		System.out.println(idToBeDelete);
	}

	// Find all threads
	@GetMapping("/findall")
	public List<ForumThreadDto> findAllThreads() {
		return iforumThreadService.findAllThreads();
	}

	// Find threads by keyword
	@GetMapping("/search")
	public List<ForumThreadDto> findThreadsByKeyword(@RequestParam String keyword) {
		return iforumThreadService.findThreadsByKeyword(keyword);
	}

	// Find thread by ID
	@GetMapping("/find/{threadId}")
	public ForumThreadDto findThreadById(@PathVariable int threadId) {

		ForumThreadDto threadDto = iforumThreadService.findThreadByThreadId(threadId);
		return threadDto;
	}

	// Find threads by teacher ID
	@GetMapping("/teacherid/{teacherId}")
	public List<ForumThreadDto> findThreadsByTeacherId(@PathVariable Integer teacherId) {
		return iforumThreadService.findThreadsByTeacherId(teacherId);
	}

	// Find threads by student ID
	@GetMapping("/studentid/{studentId}")
	public List<ForumThreadDto> findThreadsByStudentId(@PathVariable Integer studentId) {
		return iforumThreadService.findThreadsByStudentId(studentId);
	}

}
