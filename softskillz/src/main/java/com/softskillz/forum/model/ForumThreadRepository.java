package com.softskillz.forum.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ForumThreadRepository extends JpaRepository<ForumThreadModel, Integer> {

	List<ForumThreadModel> findByTeacherBeanTeacherId(Integer teacherId);
    List<ForumThreadModel> findByStudentBeanStudentId(Integer studentId);
    
    @Query("SELECT t FROM ForumThreadModel t WHERE t.threadTitle LIKE CONCAT('%', :keyword, '%') OR t.threadContent LIKE CONCAT('%', :keyword, '%') ORDER BY t.threadCreatedTime DESC")
    List<ForumThreadModel> findThreadsByKeyword(@Param("keyword") String keyword);	
	
}
