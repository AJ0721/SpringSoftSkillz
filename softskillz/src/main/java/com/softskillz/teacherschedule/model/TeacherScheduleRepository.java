package com.softskillz.teacherschedule.model;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TeacherScheduleRepository extends JpaRepository<TeacherScheduleBean, Integer> {
	List<TeacherScheduleBean> findByTeacherIDAndCourseDate(int teacherID, LocalDate courseDate);

	List<TeacherScheduleBean> findByTeacherID(int teacherID);

	Optional<TeacherScheduleBean> findById(int id); // 添加此方法以便根據ID查找
}