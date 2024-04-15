package com.softskillz.account.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StudentService implements InterfaceStudentService {
	
	@Autowired
    private InterfaceStudentDao studentDao;

	@Override
	public StudentBean authenticateStudent(String studentUsername, String studentPassword) {
		return studentDao.authenticateStudent(studentUsername, studentPassword);
	}

	@Override
	public StudentBean getStudentById(int studentId) {
		return studentDao.getStudentById(studentId);
	}
	
	
	
	
	
	
	
	

}
