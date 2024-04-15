package com.softskillz.course.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CourseService {

	@Autowired
	private CourseDao courseDao;

	// 根據ID查詢一門課程
	public CourseDTO findByCourseId(Integer courseId) {
		return courseDao.findCourseDTOById(courseId);
	}

	// 查詢所有課程，返回CourseDTO列表
	public List<CourseDTO> findAll() {
		return courseDao.findAll();
	}

	// 新增一門課程
	public CourseDTO insertCourse(CourseDTO courseDTO) {
		return courseDao.insertCourse(courseDTO);
	}

	// 根據ID刪除一門課程
	public void deleteByCourseId(CourseDTO courseDTO) {
		if (courseDTO != null && courseDTO.getCourseID() != null) {
			courseDao.deleteByCourseId(courseDTO.getCourseID());
		}
	}

	// 更新課程訊息，使用CourseDTO
    public void updateCourse(CourseDTO courseDTO) {
        courseDao.updateCourse(courseDTO);
    }

}
