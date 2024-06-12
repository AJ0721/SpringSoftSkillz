package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.model.ForumThreadModel;

public interface ForumThreadRepository extends JpaRepository<ForumThreadModel, Integer> {

//	@Query("SELECT t FROM ForumThreadModel t LEFT JOIN FETCH t.teacherBean LEFT JOIN FETCH t.studentBean sb LEFT JOIN FETCH companionBean LEFT JOIN FETCH t.forumCategoryModel LEFT JOIN FETCH t.adminBean WHERE t.threadStatus <> 'DELETED'")
	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED'")
	List<ForumThreadModel> findAllActiveThreads();

	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadTitle LIKE CONCAT('%', :keyword, '%') OR t.threadContent LIKE CONCAT('%', :keyword, '%') ORDER BY t.threadCreatedTime DESC")
	List<ForumThreadModel> findThreadsByKeyword(@Param("keyword") String keyword);

	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.teacherBean.teacherId = :teacherId")
	List<ForumThreadModel> findByTeacherBeanTeacherId(Integer teacherId);

	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.studentBean.studentId = :studentId")
	List<ForumThreadModel> findByStudentBeanStudentId(Integer studentId);

	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
	@Query("SELECT t FROM ForumThreadModel t WHERE t.threadStatus <> 'DELETED' AND t.forumCategoryModel.forumCategoryId = :categoryId")
	List<ForumThreadModel> findByForumCategoryModelForumCategoryId(Integer categoryId);
	
	@EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
    @Override
    List<ForumThreadModel> findAll();

    @EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
    @Override
    java.util.Optional<ForumThreadModel> findById(Integer integer);

    @EntityGraph(value = "ForumThread.All", type = EntityGraph.EntityGraphType.LOAD)
    @Override
    void deleteById(Integer integer);


}
