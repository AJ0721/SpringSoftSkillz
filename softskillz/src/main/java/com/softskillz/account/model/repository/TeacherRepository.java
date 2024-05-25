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
   
   // 用信箱找帳號，因為信箱是unique，所以用信箱就可以找到該帳號
   @Query("FROM TeacherBean tb WHERE tb.teacherEmail = :tEmail")
   Optional<TeacherBean> findTeacherByEmail(@Param("tEmail") String teacherEmail);
   
   TeacherBean findByTeacherIdFormatted (String teacherFormatID);

    //創帳號查找重複資料
 	//帳號重複
 	@Query("from TeacherBean tb where tb.teacherUserName = :tUsername")
 	Optional<TeacherBean> checkAccout(@Param("tUsername")String username);
 	//信箱重複
 	@Query("from TeacherBean tb where tb.teacherEmail = :tEmail")
 	Optional<TeacherBean> checkMail(@Param("tEmail")String email);
 	//手機重複
 	@Query("from TeacherBean tb where tb.teacherMobile = :tMobile")
 	Optional<TeacherBean> checkPhone(@Param("tMobile")String phone);
}
