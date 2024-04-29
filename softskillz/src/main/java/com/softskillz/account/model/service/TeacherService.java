package com.softskillz.account.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.repository.TeacherRepository;

@Service
public class TeacherService {

	@Autowired
	private TeacherRepository teacherRepository;

	//找所有教師
	public List<TeacherBean> findAllTeachers() {
		return teacherRepository.findAll();
	}
}
