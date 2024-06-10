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
public class ForumCategoryController extends LoggerUtil {

    @Autowired
    private IForumCategoryService iforumCategoryService;

    @PostMapping("/insert")
    public ForumCategoryDto insertCategory(@RequestBody ForumCategoryDto category) {
        logger.debug("POST /forum/category/insert - inserting new category: {}", JsonUtil.toJson(category));
        ForumCategoryDto insertedCategory = iforumCategoryService.insertForumCategory(category);
        logger.info("New category inserted successfully: {}", JsonUtil.toJson(insertedCategory));
        return insertedCategory;
    }

    @GetMapping("/find-all")
    public List<ForumCategoryDto> findAllCategories() {
        logger.debug("GET /forum/category/find-all - fetching all categories");
        List<ForumCategoryDto> categories = iforumCategoryService.findAllCategories();
        logger.info("Successfully fetched {} categories", categories.size());
        return categories;
    }

    @GetMapping("/search")
    public List<ForumCategoryDto> findCategoryBeansByKeyword(@RequestParam String keyword) {
        logger.debug("GET /forum/category/search - searching categories with keyword: {}", keyword);
        List<ForumCategoryDto> categories = iforumCategoryService.findCategoryBeansByKeyword(keyword);
        logger.info("Successfully fetched {} categories for keyword: {}", categories.size(), keyword);
        return categories;
    }

    @GetMapping("/find/id/{categoryId}")
    public ForumCategoryDto findForumCategoryById(@PathVariable Integer categoryId) {
        logger.debug("GET /forum/category/find/id/{} - fetching category by ID", categoryId);
        ForumCategoryDto category = iforumCategoryService.findForumCategoryById(categoryId);
        if (category != null) {
            logger.info("Successfully fetched category: {}", JsonUtil.toJson(category));
        } else {
            logger.warn("Category with ID {} not found", categoryId);
        }
        return category;
    }

    @PutMapping("/update/{categoryId}")
    public ForumCategoryDto updateCategory(@PathVariable int categoryId, @RequestBody ForumCategoryDto categoryDTO) {
        logger.debug("PUT /forum/category/update/{} - updating category with data: {}", categoryId, JsonUtil.toJson(categoryDTO));
        ForumCategoryDto updatedCategory = iforumCategoryService.updateForumCategoryById(categoryDTO.getForumCategoryId(), categoryDTO);
        logger.info("Successfully updated category: {}", JsonUtil.toJson(updatedCategory));
        return updatedCategory;
    }

    @DeleteMapping("/delete/{categoryId}")
    public void deleteCategoryById(@PathVariable int categoryId) {
        logger.debug("DELETE /forum/category/delete/{} - deleting category by ID", categoryId);
        iforumCategoryService.deleteForumCategoryById(categoryId);
        logger.info("Successfully deleted category with ID: {}", categoryId);
    }

    @DeleteMapping("/delete-all")
    public String deleteAllCategory(@RequestBody List<Integer> categoryIds) {
        logger.debug("DELETE /forum/category/delete-all - deleting categories with IDs: {}", categoryIds);
        iforumCategoryService.deleteForumCategoryByIds(categoryIds);
        logger.info("Successfully deleted categories with IDs: {}", categoryIds);
        return "Deleted category IDs: " + categoryIds;
    }
}
