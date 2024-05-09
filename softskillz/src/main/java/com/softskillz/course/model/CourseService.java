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
//	public CourseBean updateCourse(CourseBean course) {
//	    if (course != null && course.getCourseID() != null && courseRepository.existsById(course.getCourseID())) {
//	        // 從資料庫中獲取現有課程
//	        CourseBean existingCourse = courseRepository.findById(course.getCourseID()).orElse(null);
//	        if (existingCourse != null) {
//	            // 複製要更新的屬性到現有課程中
//	            existingCourse.setCourseCategory(course.getCourseCategory());
//	            existingCourse.setCourseName(course.getCourseName());
//	            existingCourse.setCourseInfo(course.getCourseInfo());
//	            existingCourse.setCoursePrice(course.getCoursePrice());
//	            
//	            // 保存更新後的課程
//	            return courseRepository.save(existingCourse);
//	        }
//	    }
//	    return null;
//	}
	public CourseBean updateCourse(CourseBean course) {
		if (course != null && course.getCourseID() != null && courseRepository.existsById(course.getCourseID())) {
			return courseRepository.save(course);
		}
		return null;
	}
}
