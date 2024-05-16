package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.forum.model.dto.ForumPostDto;
import com.softskillz.forum.model.model.ForumPostModel;

public interface ForumPostRepository extends JpaRepository<ForumPostModel, Integer> {

	@Query("SELECT p FROM ForumPostModel p WHERE p.forumThreadModel.threadId = :threadId ORDER BY p.postCreatedTime DESC")
    List<ForumPostModel> findPostsByThreadId(@Param("threadId") Integer threadId);

	List<ForumPostModel> findByTeacherBeanTeacherId(Integer teacherId);

	List<ForumPostModel> findByStudentBeanStudentId(Integer studentId);

}
