package com.softskillz.course.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CourseRepository extends JpaRepository<CourseBean, Integer> {
	// 給圖表用的
	@Query("SELECT c.courseCategory as category, COUNT(c) as count FROM CourseBean c GROUP BY c.courseCategory")
	List<Object[]> countCoursesByCategory();

	// 根據課程類別查詢課程
	List<CourseBean> findByCourseCategory(String category);
}
