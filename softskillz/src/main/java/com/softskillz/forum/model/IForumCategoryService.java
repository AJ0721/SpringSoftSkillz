package com.softskillz.forum.model;

import java.util.List;

public interface IForumCategoryService {

	// search by id
	ForumCategoryDto findForumCategoryById(int categoryId);

	// search all
	List<ForumCategoryDto> findAllCategories();

	// search by keyword
	List<ForumCategoryDto> findCategoryBeansByKeyword(String keyword);

	// insert
	ForumCategoryDto insertForumCategory(ForumCategoryDto categoryDTO);

	// update by id
	ForumCategoryDto updateForumCategoryById(int categoryId, ForumCategoryDto categoryDTO);

	// delete by id
	void deleteForumCategoryById(int categoryId);
	
	// bulk delete by id
	void deleteForumCategoryByIds(List<Integer> categoryId);
	

}
