package com.softskillz.courseorder.model.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.courseorder.model.repository.TeacherRepositoryS;

@Service
@Transactional
public class TeacherServiceImpl {

	@Autowired
	private TeacherRepositoryS tRepo;

	//找所有教師
	public List<TeacherBean> findAllTeachers() {
		return tRepo.findAll();
	}
	
	public TeacherBean findByTeacherID(Integer teacherID) {
		Optional<TeacherBean> result = tRepo.findById(teacherID);
		TeacherBean teacher = null;
		if(result.isPresent()) {
			teacher = result.get();
		}
		return teacher;
	}
	
	public TeacherBean findByFormatID(String tfID) {
		return tRepo.findByTeacherIdFormatted(tfID);
	}
	
	public TeacherBean loginSimulation(String account, String pwd) {
		
		return tRepo.tLoginSimulation(account, pwd);
	}
}
