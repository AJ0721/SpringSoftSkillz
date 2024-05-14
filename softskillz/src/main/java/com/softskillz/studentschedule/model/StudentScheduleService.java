package com.softskillz.studentschedule.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StudentScheduleService {

	@Autowired
	private StudentScheduleRepository studentScheduleRepository;

	// 查詢該學生所有行事曆
	public List<StudentScheduleBean> getStudentSchedulesById(int studentID) {
		return studentScheduleRepository.findByStudentID(studentID);
	}

	// 刪除單筆學生行事曆
	public void deleteByStudentScheduleId(Integer studentScheduleID) {
		studentScheduleRepository.deleteById(studentScheduleID);
	}
}

// 修改學生行事曆
