package com.softskillz.account.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.softskillz.account.model.bean.TeacherBean;

public interface TeacherRepository extends JpaRepository<TeacherBean, Integer> {
}
