package com.softskillz.courseorder.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.TeacherBean;

public interface TeacherRepositoryS extends JpaRepository<TeacherBean, Integer> {
	
	
	@Query("from TeacherBean t where t.teacherUserName = :account AND t.teacherPassword = :pwd ")
	TeacherBean tLoginSimulation(@Param("account") String account, @Param("pwd") String pwd);
	
	TeacherBean findByTeacherIdFormatted (String teacherFormatID);
}
