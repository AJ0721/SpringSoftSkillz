package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.forum.model.model.ForumPostModel;

public interface ForumPostRepository extends JpaRepository<ForumPostModel, Integer> {

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    @Query("SELECT p FROM ForumPostModel p WHERE p.forumThreadModel.threadId = :threadId ORDER BY p.postCreatedTime DESC")
    List<ForumPostModel> findPostsByThreadId(@Param("threadId") Integer threadId);

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    List<ForumPostModel> findByTeacherBeanTeacherId(Integer teacherId);

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    List<ForumPostModel> findByStudentBeanStudentId(Integer studentId);

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    @Override
    List<ForumPostModel> findAll();

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    @Query("SELECT p FROM ForumPostModel p WHERE p.postId = :postId")
    ForumPostModel findPostById(@Param("postId") Integer postId);

    @EntityGraph(value = "ForumPost.All", type = EntityGraphType.LOAD)
    @Query("SELECT p FROM ForumPostModel p WHERE p.postId IN :postIds")
    List<ForumPostModel> findAllByIds(@Param("postIds") List<Integer> postIds);
}
