package com.softskillz.account.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.repository.StudentRepository;

@Service
public class StudentService {

	@Autowired
	private StudentRepository studentRepository;

	// 找所有學生
	public List<StudentBean> findAllStudents() {
		return studentRepository.findAll();
	}

}
