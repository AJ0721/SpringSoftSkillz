package com.softskillz.account.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TeacherService implements InterfaceTeacherService {
	
	@Autowired
    private InterfaceTeacherDao teacherDao;

	@Override
	public TeacherBean authenticateTeacher(String teacherUsername, String teacherPassword) {
		return teacherDao.authenticateTeacher(teacherUsername, teacherPassword);
	}

	@Override
	public TeacherBean getTeacherById(int teacherId) {
		return teacherDao.getTeacherById(teacherId);
	}
	
	
	
	
	
	
	
	

}
