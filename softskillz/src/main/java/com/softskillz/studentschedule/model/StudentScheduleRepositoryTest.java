package com.softskillz.studentschedule.model;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;
import java.util.Optional;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.persistence.EntityManager;

public class StudentScheduleRepositoryTest {

	@Autowired
	private EntityManager entityManager;

	@Autowired
	private StudentScheduleRepository studentScheduleRepository;

	@SuppressWarnings("deprecation")
	@Test
	public void testFindByStudentIDAndCourseDate() {
		// 準備數據
		System.out.println("正在插入測試數據...");
		StudentScheduleBean schedule = new StudentScheduleBean();
		schedule.setStudentID(1);
		LocalDate courseDate = LocalDate.now();
		schedule.setCourseDate(courseDate);
		entityManager.persist(schedule);
		entityManager.flush();
		System.out.println("數據插入完成");

		// 執行查詢
		System.out.println("正在執行查詢...");
		Optional<StudentScheduleBean> found = studentScheduleRepository.findByStudentIDAndCourseDate(1, courseDate);

		// 驗證結果
		System.out.println("查詢結果: " + found);
		assertTrue(found.isPresent());
		assertEquals(schedule.getStudentID(), found.get().getStudentID());
		assertEquals(schedule.getCourseDate(), found.get().getCourseDate());
	}
}
