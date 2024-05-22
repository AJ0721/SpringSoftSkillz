package com.softskillz.util;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;

import jakarta.servlet.http.HttpSession;

@Component
public class SessionUserUtils {

    public static final String STUDENT = "studentData";
    public static final String TEACHER = "teacherData";
    public static final String ADMIN = "adminData";

    public Object getLoggedInUser(HttpSession session) {
        Object user = session.getAttribute(STUDENT);
        if (user != null) {
        	System.out.println(user);
            return user;
        }
        user = session.getAttribute(TEACHER);
        if (user != null) {
        	System.out.println(user);

            return user;
        }
        user = session.getAttribute(ADMIN);
        if (user != null) {
        	System.out.println(user);

            return user;
        }
        return null;
    }

    public String getUserType(HttpSession session) {
        Object user = getLoggedInUser(session);
        if (user instanceof StudentBean) {
            return "STUDENT";
        }
        if (user instanceof TeacherBean) {
            return "TEACHER";
        }
        if (user instanceof AdminBean) {
            return "ADMIN";
        }
        return null;
    }
}