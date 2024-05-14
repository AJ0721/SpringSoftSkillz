package com.softskillz.courseorder.model.bean;

import java.io.Serializable;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


//@Entity
//@Table(name = "admin")
public class Admin2 implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer admin_id;
	private String admin_account;
	private String admin_password;
	private Integer admin_level;

	public Admin2() {
		super();
	}

	public Admin2(Integer admin_id, String admin_account, String admin_password, Integer admin_level) {
		super();
		this.admin_id = admin_id;
		this.admin_account = admin_account;
		this.admin_password = admin_password;
		this.admin_level = admin_level;
	}

	public Integer getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(Integer admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_account() {
		return admin_account;
	}

	public void setAdmin_account(String admin_account) {
		this.admin_account = admin_account;
	}

	public String getAdmin_password() {
		return admin_password;
	}

	public void setAdmin_password(String admin_password) {
		this.admin_password = admin_password;
	}

	public Integer getAdmin_level() {
		return admin_level;
	}

	public void setAdmin_level(Integer admin_level) {
		this.admin_level = admin_level;
	}

	@Override
	public String toString() {
		return "Admin [admin_id=" + admin_id + ", admin_account=" + admin_account + ", admin_password=" + admin_password
				+ ", admin_level=" + admin_level + "]";
	}
}
