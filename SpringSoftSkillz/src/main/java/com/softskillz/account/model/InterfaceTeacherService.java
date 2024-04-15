package com.softskillz.account.model;

public interface InterfaceTeacherService {
	
	public TeacherBean authenticateTeacher(String teacherUsername, String teacherPassword);
	public TeacherBean getTeacherById(int teacherId);

}
