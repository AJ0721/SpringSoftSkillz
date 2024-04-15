package com.softskillz.forum.model;

import java.util.List;

import org.springframework.ui.Model;


public interface InterfaceForumThreadService {

	
	public List<ForumThreadBean> selectThreadsByCreatorId(Integer studentId, Integer teacherId);
	public List<ForumThreadBean> selectThreadsByKeyword(String keyword);
	public List<ForumThreadBean> selectAllThreads();
	public ForumThreadBean selectThreadById(int threadId);
	public List<ForumThreadBean> selectThreadsByStudentId(Integer studentId);
	public List<ForumThreadBean> selectThreadsByTeacherId(Integer teacherId);
	public boolean deleteThread(ForumThreadBean thread);
	public void insertThread(ForumThreadBean thread, Integer studentId, Integer teacherId);
	public void updateThread(ForumThreadBean thread);
}
