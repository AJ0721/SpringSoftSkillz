package com.softskillz.account.model.service;

import java.util.List;
import java.util.Optional;

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
	
	public StudentBean update(StudentBean studentBean) {
		return studentRepository.save(studentBean);
	}
	
	public StudentBean getById(Integer id) {
		Optional<StudentBean> op1 = studentRepository.findById(id);
		
		if(op1.isPresent()) {
			return op1.get();
		}
		
		return null;
	}

	//Create,新增,註冊學生
	public StudentBean insert(StudentBean students) {
		return studentRepository.save(students);
		

	}
	
	
	

}
