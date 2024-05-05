package com.softskillz.studentschedule.model;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StudentScheduleRepository extends JpaRepository<StudentScheduleBean, Integer> {
	@Query("SELECT ss FROM StudentScheduleBean ss WHERE ss.studentID = :studentID AND ss.studentCourseDate = :courseDate")
	Optional<StudentScheduleBean> findByStudentIDAndCourseDate(@Param("studentID") int studentID,
			@Param("courseDate") LocalDate courseDate);
}
