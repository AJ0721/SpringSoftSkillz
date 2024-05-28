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
import com.softskillz.forum.model.dto.AdminDto;
import com.softskillz.forum.model.dto.ForumPostDto;
import com.softskillz.forum.model.service.IForumPostService;

@RestController
@RequestMapping("/forum/post")
public class ForumPostController {
	@Autowired
	private IForumPostService forumPostService;

	// insert
	@PostMapping("/insert")
	public ForumPostDto insertPost(@RequestBody ForumPostDto postDto) {

		// Hardcode the admin ID
		if (postDto.getAdmin() == null) {
			AdminDto adminDto = new AdminDto();
			adminDto.setAdminId(1);
			postDto.setAdmin(adminDto);
			postDto.getAdmin().setAdminId(1);
		}
		return forumPostService.insertForumPost(postDto);

	}

	// Update by postId
	@PutMapping("/update/{postId}")
	public ForumPostDto updatePost(@RequestBody ForumPostDto postDto, @PathVariable("postId") Integer postId) {
		return forumPostService.updateForumPostById(postDto, postId);
	}

	// Update status
	@PutMapping("/update/id/{postId}")
	public StatusEnum updatePostById(@PathVariable("postId") Integer postId,
			@RequestParam("status") StatusEnum newStatus) {
		StatusEnum updatedStatus = forumPostService.updateForumPostStatus(postId, newStatus);
		return updatedStatus;
	}

	// Delete by Id

	@DeleteMapping("/soft-delete/{postId}")
	public ResponseEntity<Void> softDeletPost(@PathVariable Integer postId) {
		forumPostService.softDeleteForumPostById(postId);
		return ResponseEntity.noContent().build();
	}

	@DeleteMapping("/delete/{postId}")
	public String deletePostById(@PathVariable("postId") Integer postId) {
		forumPostService.deleteForumPostById(postId);
		return "Deleted post ID: " + postId;

	}

	// Bulk delete posts

	@DeleteMapping("/delete-all")
	public ResponseEntity<String> deleteAllPosts(@RequestBody List<Integer> postIds) {

		if (postIds == null || postIds.isEmpty()) {
			throw new IllegalArgumentException("No post IDs provided for deletion.");
		}
		forumPostService.deleteAllForumPost(postIds);
		return ResponseEntity.ok("Deleted post IDs: " + postIds);
	}

	// Read all posts
	
	//find both active and inactive threads
	@GetMapping("/find-all")
	public List<ForumPostDto> findAllPosts() {
		return forumPostService.findAllPosts();

	}

	// Read by post ID
	@GetMapping("/find/id/{postId}")
	public ForumPostDto findPostById(@PathVariable("postId") Integer postId) {
		ForumPostDto postDto = forumPostService.findPostById(postId);
		return postDto;
	}

	// Read post by thread ID
	@GetMapping("/find-all/thread")
	public List<ForumPostDto> findAllPosts(@RequestParam("id") Integer threadId) {
		return forumPostService.findPostsByThreadId(threadId);

	}

	// Read posts by username

}