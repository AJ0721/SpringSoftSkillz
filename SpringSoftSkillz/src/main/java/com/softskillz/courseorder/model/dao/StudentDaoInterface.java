package com.softskillz.courseorder.model.dao;

import com.softskillz.courseorder.model.bean.Student;

public interface StudentDaoInterface {

	Student selectStudent(String account,String pwd);
}
