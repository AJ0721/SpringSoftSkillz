package com.softskillz.account.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.AdminBean;


public interface AdminRepository extends JpaRepository<AdminBean, Integer> {

	// :跟變數之間不可以有空格
	@Query("from AdminBean ab where ab.adminAccount= :aAccount AND ab.adminPassword= :aPassword")
	Optional<AdminBean> findByUsernameAndPassword(@Param("aAccount") String adminAccount,
			@Param("aPassword") String adminPassword);

	//查詢帳號有沒有重複
	//findBy+Bean一樣的值adminAccount
	AdminBean findByadminAccount(String adminAccount);
	
	
	
}
