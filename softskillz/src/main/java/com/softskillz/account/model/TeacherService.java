package com.softskillz.account.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeacherService {

	@Autowired
	private TeacherRepository teacherRepository;

	//找所有教師
	public List<TeacherBean> findAllTeachers() {
		return teacherRepository.findAll();
	}
}
