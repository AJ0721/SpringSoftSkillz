package com.softskillz.account.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminService {

	@Autowired
	private AdminDao adminDao;

	public AdminBean insert(AdminBean adminBean) {
		return adminDao.insert(adminBean);
	}

	public AdminBean update(Integer id,Integer level) {
		return adminDao.update(id, level);
	}

	public boolean checkLogin(AdminBean adminBean) {
		return adminDao.checkLogin(adminBean);
	}
	
	public AdminBean findById(Integer id) {
		return adminDao.findById(id);
	}

	public List<AdminBean> findAll() {
		return adminDao.findAll();
	}

	public boolean deleteById(Integer id) {
		return adminDao.deleteById(id);
	}
}
