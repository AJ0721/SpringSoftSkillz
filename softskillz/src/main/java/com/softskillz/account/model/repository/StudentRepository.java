package com.softskillz.account.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.softskillz.account.model.bean.StudentBean;

public interface StudentRepository extends JpaRepository<StudentBean, Integer> {
}
