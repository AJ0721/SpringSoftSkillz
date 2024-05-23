package com.softskillz.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.forum.model.dto.AdminDto;
import com.softskillz.forum.model.dto.StudentDto;
import com.softskillz.forum.model.dto.TeacherDto;
import com.softskillz.forum.model.dto.UserDto;
import com.softskillz.util.SessionUserUtils;
import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/session")
public class SessionController {

    @Autowired
    private SessionUserUtils sessionUtils;

    @GetMapping("/logged-in-user")
    public ResponseEntity<UserDto> getLoggedInUser(HttpSession session) {
        Object loggedInUser = sessionUtils.getLoggedInUser(session);
        if (loggedInUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        UserDto userDto;
        if (loggedInUser instanceof StudentBean) {
            StudentBean student = (StudentBean) loggedInUser;
            userDto = new StudentDto(student.getStudentId(), student.getStudentUsername(), student.getStudentCountry());
        } else if (loggedInUser instanceof TeacherBean) {
            TeacherBean teacher = (TeacherBean) loggedInUser;
            userDto = new TeacherDto(teacher.getTeacherId(), teacher.getTeacherUserName(), teacher.getTeacherCountry());
        } else if (loggedInUser instanceof AdminBean) {
            AdminBean admin = (AdminBean) loggedInUser;
            userDto = new AdminDto(admin.getAdminId(), admin.getAdminAccount());
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }
System.out.println(userDto.toString());
        return ResponseEntity.ok(userDto);
        
    }

    @GetMapping("/user-type")
    public ResponseEntity<String> getUserType(HttpSession session) {
        String userType = sessionUtils.getUserType(session);
        if (userType == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }
        return ResponseEntity.ok(userType);
    }
}
