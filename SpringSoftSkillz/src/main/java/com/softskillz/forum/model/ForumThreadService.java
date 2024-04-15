package com.softskillz.forum.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class ForumThreadService implements InterfaceForumThreadService {

	@Autowired
	private InterfaceForumThreadDao interfaceForumThreadDao;
	


	public List<ForumThreadBean> selectThreadsByCreatorId(Integer studentId, Integer teacherId) {
		if (studentId != null) {
			return interfaceForumThreadDao.selectThreadsByStudentId(studentId);
		} else if (teacherId != null) {
			return interfaceForumThreadDao.selectThreadsByTeacherId(teacherId);
		} else {
			return null;
		}
	}
	
	

	@Override
	public List<ForumThreadBean> selectThreadsByKeyword(String keyword) {
		return interfaceForumThreadDao.selectThreadsByKeyword(keyword);
	}

	@Override
	public List<ForumThreadBean> selectAllThreads() {
		return interfaceForumThreadDao.selectAllThreads();
	}

	@Override
	public ForumThreadBean selectThreadById(int threadId) {
		return interfaceForumThreadDao.selectThreadById(threadId);
	}

	@Override
	public boolean deleteThread(ForumThreadBean thread) {
		return interfaceForumThreadDao.deleteThread(thread);
	}

	@Override
	public void insertThread(ForumThreadBean thread, Integer studentId, Integer teacherId) {
		interfaceForumThreadDao.insertThread(thread, studentId, teacherId);
	}

	@Override
	public void updateThread(ForumThreadBean thread) {
		interfaceForumThreadDao.updateThread( thread);
	}
	

	@Override
	public List<ForumThreadBean> selectThreadsByStudentId(Integer studentId) {
		return interfaceForumThreadDao.selectThreadsByStudentId(studentId);
	}

	@Override
	public List<ForumThreadBean> selectThreadsByTeacherId(Integer teacherId) {
		return interfaceForumThreadDao.selectThreadsByTeacherId(teacherId);

	

		
		
	}

}
