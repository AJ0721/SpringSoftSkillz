package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.forum.model.model.ForumThreadModel;

public interface ForumThreadRepository extends JpaRepository<ForumThreadModel, Integer> {

	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED'")
	List<ForumThreadModel> findAllActiveThreads();

	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadTitle LIKE CONCAT('%', :keyword, '%') OR t.threadContent LIKE CONCAT('%', :keyword, '%') ORDER BY t.threadCreatedTime DESC")
	List<ForumThreadModel> findThreadsByKeyword(@Param("keyword") String keyword);

	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.teacherBean.teacherId = :teacherId")
	List<ForumThreadModel> findByTeacherBeanTeacherId(Integer teacherId);

	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.studentBean.studentId = :studentId")
	List<ForumThreadModel> findByStudentBeanStudentId(Integer studentId);

	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.forumCategoryModel.forumCategoryId = :categoryId")
	List<ForumThreadModel> findByForumCategoryModelForumCategoryId(Integer categoryId);

}
