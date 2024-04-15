package com.softskillz.account.model;

public interface InterfaceStudentDao {
	public StudentBean authenticateStudent(String studentUsername, String studentPassword);
	public StudentBean getStudentById(int studentId);
	public StudentBean studentLogin(String account,String pwd);

}
