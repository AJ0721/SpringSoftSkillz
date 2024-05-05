package com.softskillz.forum.model;

import java.util.List;

public class ForumCategoryDto {
	
	private Integer forumCategoryId;
    private String forumCategoryName;
    private String forumCategoryDescription;
    private List<Integer> forumCategoryIds;


    public ForumCategoryDto() {
    }

	public ForumCategoryDto(Integer forumCategoryId, String forumCategoryName, String forumCategoryDescription) {
		this.forumCategoryId = forumCategoryId;
		this.forumCategoryName = forumCategoryName;
		this.forumCategoryDescription = forumCategoryDescription;
	}

	public Integer getForumCategoryId() {
		return forumCategoryId;
	}

	public void setForumCategoryId(Integer forumCategoryId) {
		this.forumCategoryId = forumCategoryId;
	}

	public String getForumCategoryName() {
		return forumCategoryName;
	}

	public void setForumCategoryName(String forumCategoryName) {
		this.forumCategoryName = forumCategoryName;
	}

	public String getForumCategoryDescription() {
		return forumCategoryDescription;
	}

	public void setForumCategoryDescription(String forumCategoryDescription) {
		this.forumCategoryDescription = forumCategoryDescription;
	}

	public List<Integer> getForumCategoryIds() {
		return forumCategoryIds;
	}

	public void setForumCategoryIds(List<Integer> forumCategoryIds) {
		this.forumCategoryIds = forumCategoryIds;
	}
	
	


    

}
