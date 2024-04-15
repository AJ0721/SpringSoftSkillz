package com.softskillz.account.model;

public interface InterfaceStudentService {
	
	public StudentBean authenticateStudent(String studentUsername, String studentPassword);
	public StudentBean getStudentById(int studentId);

}
