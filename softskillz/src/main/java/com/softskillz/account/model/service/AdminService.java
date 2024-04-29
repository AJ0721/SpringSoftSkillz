package com.softskillz.account.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.repository.AdminRepository;

@Service
@Transactional
public class AdminService {

	@Autowired
	private AdminRepository adminRepos;

	// 新增,註冊會員
	public AdminBean insert(AdminBean adminBean) {
		
//		String newAccount =adminBean.getAdminAccount();
//		AdminBean resultBean = adminRepos.findByadminAccount(newAccount);	
	
		AdminBean resultBean = adminRepos.findByadminAccount(adminBean.getAdminAccount());
		
		if (resultBean!=null) {
			//resultBean!=null就是在sql有找到已存在帳號
			return null;
		} else {
			//resultBean=null就是在sql沒有找到帳號，所以儲存該帳號（從暫存改成永久儲存）
			return adminRepos.save(adminBean);
		}
		
	}
	

	// 檢查帳號密碼
	public boolean checkLogin(AdminBean adminBean) {
		Optional<AdminBean> result = adminRepos.findByUsernameAndPassword(adminBean.getAdminAccount(),
				adminBean.getAdminPassword());
		return result.isPresent();
	}

	// 更新
	public AdminBean update(AdminBean adminBean) {
		return adminRepos.save(adminBean);
	}

	// 更新層級
	public AdminBean updateLevel(Integer adminId, Integer adminLevel) {
		// 先把id的東西拿出來
		Optional<AdminBean> op1 = adminRepos.findById(adminId);
		//把id原本的東西放進Bean裡面
		AdminBean adminBean = op1.get();
		//把新的adminLevel放進去adminBean
		adminBean.setAdminLevel(adminLevel);
		//save新的adminBean
		return adminRepos.save(adminBean);
	}

	// 刪除
	public boolean deleteById(Integer adminId) {
		try {
			adminRepos.deleteById(adminId);
			return true; // 假設刪除成功
		} catch (Exception e) {
			return false; // 處理任何刪除時可能出現的異常
		}
	}

	// 查詢
	public AdminBean findById(Integer adminId) {
		Optional<AdminBean> op1 = adminRepos.findById(adminId);
		if (op1.isPresent()) {
			return op1.get();
		}
		return null;
	}

	// 查詢全部
	public List<AdminBean> getAll() {
		return adminRepos.findAll();
	}
	
	// 查詢分頁
	public Page<AdminBean> findAllByPage(Pageable pageable){
		return adminRepos.findAll(pageable);
	}

}
