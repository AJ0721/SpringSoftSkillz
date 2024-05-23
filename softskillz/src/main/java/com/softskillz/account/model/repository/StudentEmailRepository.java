package com.softskillz.account.model.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.account.model.bean.StudentNewPwdBean;

public interface StudentEmailRepository extends JpaRepository<StudentNewPwdBean, Integer> {

	@Query("FROM StudentNewPwdBean snpb WHERE snpb.token = :token")
	public Optional<StudentNewPwdBean> findToken(@Param("token") String token);

	
}
