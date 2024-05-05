package com.softskillz.studentschedule.model;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StudentScheduleService {

//	@Autowired
//	private StudentScheduleRepository studentScheduleRepository;
//
//	// 示例方法，用於在應用中直接測試studentScheduleRepository.findByStudentIDAndCourseDate()
//	public void testFindByStudentIDAndCourseDate(int studentID, LocalDate courseDate) {
//		Optional<StudentScheduleBean> result = studentScheduleRepository.findByStudentIDAndCourseDate(studentID,
//				courseDate);
//		if (result.isPresent()) {
//			System.out.println("找到學生行事曆: " + result.get());
//		} else {
//			System.out.println("未找到對應的學生行事曆");
//		}
//	}
}
// 查詢學生行事曆

// 查詢該學生所有行事曆

// 刪除學生行事曆

// 修改學生行事曆
