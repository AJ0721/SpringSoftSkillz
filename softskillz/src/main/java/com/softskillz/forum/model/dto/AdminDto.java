package com.softskillz.forum.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class AdminDto implements UserDto {
    private Integer adminId;
    private String adminAccount;

    public AdminDto() {
    }

    public AdminDto(Integer adminId, String adminAccount) {
        this.adminId = adminId;
        this.adminAccount = adminAccount;
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

    @Override
    @JsonIgnore
    public String getIdentifier() {
        return adminAccount;
    }
}
