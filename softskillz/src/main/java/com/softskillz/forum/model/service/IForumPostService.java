package com.softskillz.forum.model.service;

import java.util.List;

import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.dto.ForumPostDto;
import com.softskillz.forum.model.dto.ForumThreadDto;

public interface IForumPostService {

	// insert
	ForumPostDto insertForumPost(ForumPostDto postDto);	
	
	//update
	ForumPostDto updateForumPostById(ForumPostDto postDto, Integer postId);
	StatusEnum updateForumPostStatus(Integer postId, StatusEnum newStatus);
	
	//delete
	void deleteForumPostById(Integer postId);
	void deleteAllForumPost(List<Integer>postIds);
	
	//read
	ForumPostDto findPostById(Integer postId);
	List<ForumPostDto> findAllPosts();
	List<ForumPostDto> findPostsByTeacherId(Integer teacherId);
	List<ForumPostDto> findPostsByStudentId(Integer studentId);
	List<ForumPostDto> findPostsByThreadId(Integer threadId);
	
}
