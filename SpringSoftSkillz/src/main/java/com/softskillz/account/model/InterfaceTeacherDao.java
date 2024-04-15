package com.softskillz.account.model;

public interface InterfaceTeacherDao {
	public TeacherBean authenticateTeacher(String teacherUsername, String teacherPassword);
	public TeacherBean getTeacherById(int teacherId);

}
