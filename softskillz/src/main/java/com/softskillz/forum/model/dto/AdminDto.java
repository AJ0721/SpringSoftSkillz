package com.softskillz.forum.model.dto;

public class AdminDto {
    private Integer adminId;
    private String adminAccount;
    

    public AdminDto() {
    }


	public AdminDto(Integer adminId) {
		this.adminId = adminId;
	}


	public Integer getAdminId() {
		return adminId;
	}


	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}


	public String getAdminAccount() {
		return adminAccount;
	}


	public void setAdminAccount(String adminAccount) {
		this.adminAccount = adminAccount;
	}
	
	
}


	