package com.softskillz.forum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.forum.model.dto.ForumCategoryDto;
import com.softskillz.forum.model.service.IForumCategoryService;



@RestController
@RequestMapping("/forum/category")
public class ForumCategoryController {

	@Autowired
	private IForumCategoryService iforumCategoryService;
	

	@PostMapping("/insert")
	public ForumCategoryDto insertCategory(@RequestBody ForumCategoryDto category) {
		return iforumCategoryService.insertForumCategory(category);
	}


	@GetMapping("/find-all")
	public List<ForumCategoryDto> findAllCategories() {
		return iforumCategoryService.findAllCategories();
	}

	@GetMapping("/search")
	public List<ForumCategoryDto> findCategoryBeansByKeyword(@RequestParam String keyword) {
		return iforumCategoryService.findCategoryBeansByKeyword(keyword);
	}

	@GetMapping("/find/id/{categoryId}")
	public ForumCategoryDto findForumCategoryById(@PathVariable Integer categoryId
			) {
		
		ForumCategoryDto category = iforumCategoryService.findForumCategoryById(categoryId);
		return category;
	}
	
	@PutMapping("/update/{categoryId}")
    public ForumCategoryDto updateCategory(
            @PathVariable int categoryId,
            @RequestBody ForumCategoryDto categoryDTO) {

            ForumCategoryDto updatedCategory = iforumCategoryService.updateForumCategoryById(categoryDTO.getForumCategoryId(), categoryDTO);
            return (updatedCategory); 
        
        }
	
	@DeleteMapping("/delete/{categoryId}")
	public void deleteCategoryById(@PathVariable int categoryId) {
		iforumCategoryService.deleteForumCategoryById(categoryId);
		
	}
	@DeleteMapping("/delete-all")
	public String deleteAllCategory(@RequestBody List<Integer>categoryIds) {
		iforumCategoryService.deleteForumCategoryByIds(categoryIds);
		return "Deleted categoty IDs: "+ categoryIds;
		
	}
	
	
	
    }


