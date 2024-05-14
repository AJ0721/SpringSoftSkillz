package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.softskillz.forum.model.model.ForumPostModel;

public interface ForumPostRepository extends JpaRepository<ForumPostModel, Integer> {

	List<ForumPostModel> findByTeacherBeanTeacherId(Integer teacherId);
    List<ForumPostModel> findByStudentBeanStudentId(Integer studentId);
    

}
