package com.softskillz.courseorder.model.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.courseorder.model.repository.StudentRepositoryS;
import com.softskillz.courseorder.model.service.StudentServiceS;

@Service
@Transactional
public class StudentServiceImpl implements StudentServiceS {

	@Autowired
	private StudentRepositoryS stRepo;

	@Override
	public StudentBean loginSimulation(String account, String pwd) {
		
		return stRepo.loginSimulation(account, pwd);
	}

	@Override
	public StudentBean findStudentByFormatID(String studentIdFormatted) {
		return stRepo.findByStudentIdFormatted(studentIdFormatted);
	}

	public StudentBean findByStudentID(Integer studentID) {
		Optional<StudentBean> result = stRepo.findById(studentID);
		StudentBean student = null;
		if(result.isPresent()) {
			student = result.get();
		}
		return student;
	}
}
