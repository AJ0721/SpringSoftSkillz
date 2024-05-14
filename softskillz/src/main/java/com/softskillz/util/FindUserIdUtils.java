package com.softskillz.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.softskillz.account.model.repository.AdminRepository;
import com.softskillz.account.model.repository.StudentRepository;
import com.softskillz.account.model.repository.TeacherRepository;
import com.softskillz.forum.model.UserEnum;

@Component
public class FindUserIdUtils {

    @Autowired
    StudentRepository studentRepository;

    @Autowired
    TeacherRepository teacherRepository;

    @Autowired
    AdminRepository adminRepository;

    public Object findUserById(Integer userId, UserEnum userType) {
        if (userId == null) {
            return null;  
        }

        switch (userType) {
            case STUDENT:
                return studentRepository.findById(userId)
                                        .orElseThrow(() -> new RuntimeException("Student not found"));
            case TEACHER:
                return teacherRepository.findById(userId)
                                        .orElseThrow(() -> new RuntimeException("Teacher not found"));
            case ADMIN:
                return adminRepository.findById(userId)
                                       .orElseThrow(() -> new RuntimeException("Admin not found"));
            default:
                throw new IllegalArgumentException("Invalid user type");
        }
    }
}

