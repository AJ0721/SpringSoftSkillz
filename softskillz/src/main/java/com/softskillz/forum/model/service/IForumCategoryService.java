package com.softskillz.forum.model.service;

import java.util.List;

import com.softskillz.forum.model.dto.ForumCategoryDto;

public interface IForumCategoryService {

	// search by id
	ForumCategoryDto findForumCategoryById(Integer categoryId);

	// search all
	List<ForumCategoryDto> findAllCategories();

	// search by keyword
	List<ForumCategoryDto> findCategoryBeansByKeyword(String keyword);

	// insert
	ForumCategoryDto insertForumCategory(ForumCategoryDto categoryDTO);

	// update by id
	ForumCategoryDto updateForumCategoryById(Integer categoryId, ForumCategoryDto categoryDTO);

	// delete by id
	void deleteForumCategoryById(Integer categoryId);
	
	// bulk delete by id
	void deleteForumCategoryByIds(List<Integer> categoryId);
	

}
