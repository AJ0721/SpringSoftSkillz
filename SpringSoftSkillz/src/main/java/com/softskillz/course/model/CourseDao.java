package com.softskillz.course.model;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Repository
@Transactional
public class CourseDao {

	@PersistenceContext
	private EntityManager entityManager;

	// 查詢全部課程，並轉換為CourseDTO列表
	public List<CourseDTO> findAll() {
		String query = "SELECT new com.softskillz.course.model.CourseDTO(c.courseID, c.teacherID, c.courseName, c.courseInfo, c.courseCategory, c.coursePrice,  CONCAT(t.teacherLastName, t.teacherFirstName)) FROM CourseBean c JOIN c.teacherBean t";
		List<CourseDTO> courseDTOList = entityManager.createQuery(query, CourseDTO.class).getResultList();
		return courseDTOList;
	}

	// 根据ID查詢一門課程
	public CourseDTO findCourseDTOById(Integer courseId) {
		String query = "SELECT new com.softskillz.course.model.CourseDTO(c.courseID, c.teacherID, c.courseName, c.courseInfo, c.courseCategory, c.coursePrice, t.teacherUserName) FROM CourseBean c JOIN c.teacherBean t WHERE c.courseID = :courseId";
		List<CourseDTO> result = entityManager.createQuery(query, CourseDTO.class).setParameter("courseId", courseId)
				.getResultList();
		if (result.isEmpty()) {
			return null;
		} else {
			return result.get(0);
		}
	}

	// 新增一門課程
	public CourseDTO insertCourse(CourseDTO courseDTO) {
		CourseBean course = new CourseBean();
		course.setTeacherID(courseDTO.getTeacherID());
		course.setCourseName(courseDTO.getCourseName());
		course.setCourseInfo(courseDTO.getCourseInfo());
		course.setCourseCategory(courseDTO.getCourseCategory());
		course.setCoursePrice(courseDTO.getCoursePrice());

		// 儲存 CourseBean 實例
		entityManager.persist(course);
		entityManager.flush(); // 確保 ID 被賦值

		// 更新 DTO 的 courseID，因為它是新生成的
		courseDTO.setCourseID(course.getCourseID());
		return courseDTO;
	}

	// 根据ID刪除一門課程
	public void deleteByCourseId(Integer courseId) {
		CourseBean course = entityManager.find(CourseBean.class, courseId);
		if (course != null) {
			entityManager.remove(course);
		}
	}

	// 更新課程信息，使用CourseDTO
	public void updateCourse(CourseDTO courseDTO) {
		if (courseDTO == null) {
			return;
		}
		CourseBean courseBean = entityManager.find(CourseBean.class, courseDTO.getCourseID());
		if (courseBean != null) {
			courseBean.setTeacherID(courseDTO.getTeacherID());
			courseBean.setCourseName(courseDTO.getCourseName());
			courseBean.setCourseInfo(courseDTO.getCourseInfo());
			courseBean.setCourseCategory(courseDTO.getCourseCategory());
			courseBean.setCoursePrice(courseDTO.getCoursePrice());
			entityManager.merge(courseBean);
		}
	}

}
