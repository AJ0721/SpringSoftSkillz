package com.softskillz.studentreservation.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


public interface StudentReservationRepository extends JpaRepository<StudentReservationBean, Integer> {
	List<StudentReservationBean> findByStudentID(int studentId);
}
