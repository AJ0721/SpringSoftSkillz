package com.softskillz.courseorder.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.StudentBean;


public interface StudentRepositoryS extends JpaRepository<StudentBean, Integer> {

	@Query("from StudentBean s where s.studentUsername = :account AND s.studentPassword = :pwd ")
	StudentBean loginSimulation(@Param("account") String account, @Param("pwd") String pwd);
	
	StudentBean findByStudentIdFormatted(String studentIdFormatted);
}
