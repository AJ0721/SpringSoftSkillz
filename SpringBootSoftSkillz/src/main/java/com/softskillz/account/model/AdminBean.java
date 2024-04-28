package com.softskillz.account.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.softskillz.forum.model.ForumThreadModel;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "admin")
@Component
public class AdminBean {

	public AdminBean() {
	}

//帳號密碼

	public AdminBean(String adminAccount, String adminPassword) {
		this.adminAccount = adminAccount;
		this.adminPassword = adminPassword;
	}

	// 有id
	public AdminBean(Integer adminId, String adminAccount, String adminPassword, Integer adminLevel) {
		this.adminId = adminId;
		this.adminAccount = adminAccount;
		this.adminPassword = adminPassword;
		this.adminLevel = adminLevel;
	}

	// 沒有id
	public AdminBean(String adminAccount, String adminPassword, Integer adminLevel) {

		this.adminAccount = adminAccount;
		this.adminPassword = adminPassword;
		this.adminLevel = adminLevel;
	}

	//任萱forum
	@OneToMany(mappedBy = "adminBean")
	private List<ForumThreadModel> threads = new ArrayList<>();

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "admin_id")
	private Integer adminId;

	@Column(name = "admin_account")
	private String adminAccount;

	@Column(name = "admin_password")
	private String adminPassword;

	@Column(name = "admin_level")
	private Integer adminLevel;

	
	//任萱forum getter/setter
	public List<ForumThreadModel> getThreads() {
		return threads;
	}

	public void setThreads(List<ForumThreadModel> threads) {
		this.threads = threads;
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

	public String getAdminPassword() {
		return adminPassword;
	}

	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public Integer getAdminLevel() {
		return adminLevel;
	}

	public void setAdminLevel(Integer adminLevel) {
		this.adminLevel = adminLevel;
	}

	@Override
	public String toString() {
		return "AdminBean [adminId=" + adminId + ", adminAccount=" + adminAccount + ", adminPassword=" + adminPassword
				+ ", adminLevel=" + adminLevel + "]";
	}

}
