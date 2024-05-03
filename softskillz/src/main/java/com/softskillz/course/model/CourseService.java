package com.softskillz.course.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CourseService {

	@Autowired
	private CourseRepository courseRepository;

	// 根據ID查詢一門課程
	public CourseBean findCourseById(Integer courseId) {
		return courseRepository.findById(courseId).orElse(null);
	}

	// 查詢所有課程
	public List<CourseBean> findAllCourses() {
		return courseRepository.findAll();
	}

	// 新增一門課程
	public CourseBean insertCourse(CourseBean course) {
		return courseRepository.save(course);
	}

	// 根據ID刪除一門課程
	public void deleteByCourseId(Integer courseID) {
		courseRepository.deleteById(courseID);
	}

	// 更新課程
	// 先檢查傳入的CourseBean是否為非空,且其 ID 是否有效（即資料庫中已存在此 ID 的課程）
	// 如果是，使用save()更新課程。
	public CourseBean updateCourse(CourseBean course) {
		if (course != null && course.getCourseID() != null && courseRepository.existsById(course.getCourseID())) {
			return courseRepository.save(course);
		}
		return null;
	}
}
