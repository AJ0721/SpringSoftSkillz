package com.softskillz.course.model;


import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseRepository extends JpaRepository<CourseBean, Integer> {
}
