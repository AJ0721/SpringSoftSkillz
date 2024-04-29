package com.softskillz.forum.model;

public class ForumCategoryDto {
	
	private int forumCategoryId;
    private String forumCategoryName;
    private String forumCategoryDescription;

    public ForumCategoryDto() {
    }

	public ForumCategoryDto(int forumCategoryId, String forumCategoryName, String forumCategoryDescription) {
		this.forumCategoryId = forumCategoryId;
		this.forumCategoryName = forumCategoryName;
		this.forumCategoryDescription = forumCategoryDescription;
	}

	public int getForumCategoryId() {
		return forumCategoryId;
	}
	
	
	public void setForumCategoryId(int forumCategoryId) {
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

	
	
    
    

}
