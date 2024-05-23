package com.softskillz.account.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.TeacherNewPwdBean;

public interface TeacherEmailRepository extends JpaRepository<TeacherNewPwdBean, Integer> {

	@Query("FROM TeacherNewPwdBean tnpb WHERE tnpb.token = :token")
	public Optional<TeacherNewPwdBean> findToken(@Param("token") String token);

}
