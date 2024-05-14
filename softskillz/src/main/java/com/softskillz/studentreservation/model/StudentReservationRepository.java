package com.softskillz.studentreservation.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StudentReservationRepository extends JpaRepository<StudentReservationBean, Integer> {
	List<StudentReservationBean> findByStudentID(int studentId);
}
