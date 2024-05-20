package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.service.IForumThreadService;

@RestController
@RequestMapping("/forum/thread")
public class ForumThreadController {
	@Autowired
	private IForumThreadService forumThreadService;

	// find threads by username

	// find threads by category

	@PostMapping("/insert")
	public ResponseEntity<ForumThreadDto> insertThread(@RequestBody ForumThreadDto threadDto) {
		ForumThreadDto createdThread = forumThreadService.insertForumThread(threadDto);
		if (createdThread != null) {
			return ResponseEntity.ok(createdThread);
		} else {
			return ResponseEntity.badRequest().build();
		}

	}

	// update thread by ID
	@PutMapping("/update/{threadId}")
	public ForumThreadDto updateThread(@PathVariable("threadId") Integer threadId,
			@RequestBody ForumThreadDto threadDto) {

		ForumThreadDto updatedThread = forumThreadService.updateForumThreadById(threadId, threadDto);
		return updatedThread;
	}

	// update thread status
	@PutMapping("/update/id/{threadId}")
	public StatusEnum updateThreadStatus(@PathVariable Integer threadId, @RequestParam("status") StatusEnum newSatus) {
		StatusEnum updatedStatus = forumThreadService.updateForumThreadStatus(threadId, newSatus);
		return updatedStatus;
	}

	// Delete a thread by ID
	@DeleteMapping("/delete/{threadId}")
	public String deleteThread(@PathVariable int threadId) {

		forumThreadService.deleteForumThreadById(threadId);
		return "Deleted thread ID:" + threadId;

	}

	@DeleteMapping("/delete-all")
	public String deleteAllThreads(@RequestBody List<Integer> threadIds) {

		if (threadIds == null || threadIds.isEmpty()) {
			throw new IllegalArgumentException("No thread IDs provided for deletion.");
		}
		forumThreadService.deleteAllForumThreads(threadIds);

		return "Deleted thread ID: " + threadIds;

	}

	// Find all threads
	@GetMapping("/find-all")
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
