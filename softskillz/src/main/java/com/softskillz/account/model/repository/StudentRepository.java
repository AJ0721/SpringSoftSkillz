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
    // 用信箱找帳號，因為信箱是unique，所以用信箱就可以找到該帳號
    @Query("FROM StudentBean sb WHERE sb.studentEmail = :sEmail")
    Optional<StudentBean> findStudentByEmail(@Param("sEmail") String studentEmail);

	StudentBean findByStudentIdFormatted(String studentIdFormatted);
	
	//創帳號查找重複資料
	//帳號重複
	@Query("from StudentBean sb where sb.studentUsername = :sUsername")
	Optional<StudentBean> checkAccout(@Param("sUsername")String username);
	//信箱重複
	@Query("from StudentBean sb where sb.studentEmail = :sEmail")
	Optional<StudentBean> checkMail(@Param("sEmail")String email);
	//手機重複
	@Query("from StudentBean sb where sb.studentMobile = :sMobile")
	Optional<StudentBean> checkPhone(@Param("sMobile")String phone);
	//暱稱重複
	@Query("from StudentBean sb where sb.studentNickname = :sNickname")
	Optional<StudentBean> checkNickname(@Param("sNickname")String nickname);
}
	

