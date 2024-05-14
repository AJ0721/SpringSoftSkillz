package com.softskillz.account.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.StudentBean;

public interface StudentRepository extends JpaRepository<StudentBean, Integer> {
	
	 // 查詢有沒有該帳號
    @Query("FROM StudentBean sb WHERE sb.studentUsername = :sUsername AND sb.studentPassword = :sPassword")
    Optional<StudentBean> findByUsername(@Param("sUsername") String studentUsername, @Param("sPassword") String studentPassword);
     // 查詢有沒有該信箱
    @Query("FROM StudentBean sb WHERE sb.studentEmail = :sEmail AND sb.studentPassword = :sPassword")
    Optional<StudentBean> findByEmail(@Param("sEmail") String studentEmail, @Param("sPassword") String studentPassword);

}
	

