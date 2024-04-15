package com.softskillz.courseorder.model.dao;

import com.softskillz.courseorder.model.bean.Admin2;

public interface AdminDaoInterface {

	Admin2 login(String account, String pwd);
}
