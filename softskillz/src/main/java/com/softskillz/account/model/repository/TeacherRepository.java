package com.softskillz.account.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.TeacherBean;

public interface TeacherRepository extends JpaRepository<TeacherBean, Integer> {
	
	
	 // 查詢有沒有該帳號
   @Query("FROM TeacherBean tb WHERE tb.teacherUserName = :tUsername AND tb.teacherPassword = :tPassword")
   Optional<TeacherBean> findByUsername(@Param("tUsername") String teacherUserName, @Param("tPassword") String teacherPassword);
    // 查詢有沒有該信箱
   @Query("FROM TeacherBean tb WHERE tb.teacherEmail = :tEmail AND tb.teacherPassword = :tPassword")
   Optional<TeacherBean> findByEmail(@Param("tEmail") String teacherEmail, @Param("tPassword") String teacherPassword);
   
   TeacherBean findByTeacherIdFormatted (String teacherFormatID);

}
