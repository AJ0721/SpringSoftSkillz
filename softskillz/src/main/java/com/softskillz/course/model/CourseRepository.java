package com.softskillz.course.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CourseRepository extends JpaRepository<CourseBean, Integer> {
	// 給圖表用的
	@Query("SELECT c.courseCategory as category, COUNT(c) as count FROM CourseBean c GROUP BY c.courseCategory")
	List<Object[]> countCoursesByCategory();

	//給課程前台用 同時載入教師和課程資料
	@Query("SELECT c FROM CourseBean c JOIN FETCH c.teacherBean t")
	List<CourseBean> findAllWithTeachers();
}
