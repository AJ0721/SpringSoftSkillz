package com.softskillz.forum.model.service;

import java.util.List;

import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.dto.ForumThreadDto;

public interface IForumThreadService {

	// insert
	ForumThreadDto insertForumThread(ForumThreadDto threadDto);

	// update
	ForumThreadDto updateForumThreadById(Integer threadId, ForumThreadDto threadDto);

	StatusEnum updateForumThreadStatus(Integer threadId, StatusEnum newStatus);

	// delete
	void softDeleteForumThreadById(Integer threadId);

	void deleteForumThreadById(Integer threadId);

	void deleteAllForumThreads(List<Integer> threadIds);

	// read
	List<ForumThreadDto> findThreadsByKeyword(String keyword);

	ForumThreadDto findThreadByThreadId(Integer threadId);

	List<ForumThreadDto> findAllThreads();

	List<ForumThreadDto> findThreadsByTeacherId(Integer teacherId);

	List<ForumThreadDto> findThreadsByStudentId(Integer studentId);

	List<ForumThreadDto> findThreadsByCategory(Integer categoryId);
}
