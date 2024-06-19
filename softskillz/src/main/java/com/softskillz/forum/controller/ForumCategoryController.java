package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.softskillz.forum.model.dto.ForumCategoryDto;
import com.softskillz.forum.model.service.IForumCategoryService;
import com.softskillz.util.JsonUtil;
import com.softskillz.util.LoggerUtil;

@RestController
@RequestMapping("/forum/category")
public class ForumCategoryController {

	@Autowired
	private IForumCategoryService iforumCategoryService;

	@PostMapping("/insert")
	public ForumCategoryDto insertCategory(@RequestBody ForumCategoryDto category) {

		ForumCategoryDto insertedCategory = iforumCategoryService.insertForumCategory(category);
		return insertedCategory;
	}

	@GetMapping("/find-all")
	public List<ForumCategoryDto> findAllCategories() {
		List<ForumCategoryDto> categories = iforumCategoryService.findAllCategories();
		return categories;
	}

	@GetMapping("/search")
	public List<ForumCategoryDto> findCategoryBeansByKeyword(@RequestParam String keyword) {
		List<ForumCategoryDto> categories = iforumCategoryService.findCategoryBeansByKeyword(keyword);
		return categories;
	}

	@GetMapping("/find/id/{categoryId}")
	public ForumCategoryDto findForumCategoryById(@PathVariable Integer categoryId) {
		ForumCategoryDto category = iforumCategoryService.findForumCategoryById(categoryId);
		if (category != null) {
		} else {
		}
		return category;
	}

	@PutMapping("/update/{categoryId}")
	public ForumCategoryDto updateCategory(@PathVariable int categoryId, @RequestBody ForumCategoryDto categoryDTO) {
		ForumCategoryDto updatedCategory = iforumCategoryService
				.updateForumCategoryById(categoryDTO.getForumCategoryId(), categoryDTO);
		return updatedCategory;
	}

	@DeleteMapping("/delete/{categoryId}")
	public void deleteCategoryById(@PathVariable int categoryId) {
		iforumCategoryService.deleteForumCategoryById(categoryId);
	}

	@DeleteMapping("/delete-all")
	public String deleteAllCategory(@RequestBody List<Integer> categoryIds) {
		iforumCategoryService.deleteForumCategoryByIds(categoryIds);
		return "Deleted category IDs: " + categoryIds;
	}
}
