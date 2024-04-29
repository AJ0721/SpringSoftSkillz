package com.softskillz.account.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

	@Autowired
	private StudentRepository studentRepository;

	// 找所有學生
	public List<StudentBean> findAllStudents() {
		return studentRepository.findAll();
	}

}
