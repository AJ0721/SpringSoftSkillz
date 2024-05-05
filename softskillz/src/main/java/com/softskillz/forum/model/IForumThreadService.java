package com.softskillz.forum.model;

import java.util.List;

public interface IForumThreadService {

	// insert
	ForumThreadDto insertForumThread(ForumThreadDto threadDto);

	// update
	ForumThreadDto updateForumThreadById(Integer threadId,ForumThreadDto threadDto);
	

	// delete
	void deleteForumThreadById(Integer threadId);

	void deleteAllForumThreads(List<Integer> threadIds);

	// read
	List<ForumThreadDto> findThreadsByKeyword(String keyword);

	ForumThreadDto findThreadByThreadId(Integer threadId);

	List<ForumThreadDto> findAllThreads();

	List<ForumThreadDto> findThreadsByTeacherId(Integer teacherId);

	List<ForumThreadDto> findThreadsByStudentId(Integer studentId);
}
