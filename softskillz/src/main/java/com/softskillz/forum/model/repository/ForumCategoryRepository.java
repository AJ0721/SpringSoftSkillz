package com.softskillz.forum.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.forum.model.model.ForumCategoryModel;

public interface ForumCategoryRepository extends JpaRepository<ForumCategoryModel, Integer> {

	@Transactional
	@Query("SELECT c FROM ForumCategoryModel c WHERE c.forumCategoryName LIKE CONCAT('%',:keyword, '%') ORDER BY c.forumCategoryId ASC"  )
	public List<ForumCategoryModel> findCategoryModelByKeyword(@Param("keyword") String keyword);
	
}
