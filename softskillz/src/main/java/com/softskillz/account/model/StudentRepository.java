package com.softskillz.account.model;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<StudentBean, Integer> {
}
