package com.softskillz.forum.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ForumCategoryService implements IForumCategoryService {

	@Autowired
	private ForumCategoryRepository forumCategoryRepository;

	// search by id
	public ForumCategoryDto findForumCategoryById(Integer categoryId) {
		
		 ForumCategoryModel category = forumCategoryRepository.findById(categoryId).orElse(null);
		 return IDtoConverter.INSTANCE.toForumCategoryDTO(category);
	}

	// search all
	public List<ForumCategoryDto> findAllCategories() {
        List<ForumCategoryModel> categories = forumCategoryRepository.findAll();
        return categories.stream()
                         .map(IDtoConverter.INSTANCE::toForumCategoryDTO)
                         .collect(Collectors.toList());
    }
	
	

	// search by keyword
	public List<ForumCategoryDto> findCategoryBeansByKeyword(String keyword) {
		List<ForumCategoryModel> categoryBeans = forumCategoryRepository.findCategoryModelByKeyword(keyword);
		List<ForumCategoryDto> categoryDTOs = 
				categoryBeans.stream()
				.map(IDtoConverter.INSTANCE::toForumCategoryDTO)
				.collect(Collectors.toList());
		
		if(!categoryDTOs.isEmpty()) {
        return categoryDTOs;}
		return new ArrayList<ForumCategoryDto>();
	}

	// insert
	public ForumCategoryDto insertForumCategory(ForumCategoryDto categoryDTO) {
		
		ForumCategoryModel categoryBean = IDtoConverter.INSTANCE.toForumCategoryModel(categoryDTO);
        ForumCategoryModel savedCategory = forumCategoryRepository.save(categoryBean);
        return IDtoConverter.INSTANCE.toForumCategoryDTO(savedCategory);
	}

	// update by id
	public ForumCategoryDto updateForumCategoryById(Integer categoryId, ForumCategoryDto categoryDto) {

		// Find existing category
		ForumCategoryModel existingCategory = forumCategoryRepository.findById(categoryId)
				.orElseThrow(() -> new RuntimeException("Category not found with id: " + categoryId));

		// Set new values
		existingCategory.setForumCategoryName(categoryDto.getForumCategoryName());
		existingCategory.setForumCategoryDescription(categoryDto.getForumCategoryDescription());

		// Save updated category
		ForumCategoryModel updatedCategory = forumCategoryRepository.save(existingCategory);
		
		return IDtoConverter.INSTANCE.toForumCategoryDTO(updatedCategory); 
	}

	//delete by id
	public void deleteForumCategoryById(Integer categoryId) {
		forumCategoryRepository.deleteById(categoryId);
	}
	
	//bulk delete by id
	public void deleteForumCategoryByIds(List<Integer> categoryIds) {
		forumCategoryRepository.deleteAllByIdInBatch(categoryIds);
	}
	
	//

	
}
