package com.softskillz.account.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.repository.TeacherRepository;

@Service
public class TeacherService {

	@Autowired
	private TeacherRepository teacherRepository;

	// 老師帳號登入
	public TeacherBean usernameCheckLogin(String teacherUserName, String teacherPassword) {
		Optional<TeacherBean> resultOptional = teacherRepository.findByUsername(teacherUserName, teacherPassword);

		boolean result = resultOptional.isPresent();

		if (result) {
			return resultOptional.get();
		}
		return null;
	}

	// 老師信箱登入
	public TeacherBean emailCheckLogin(String teacherEmail, String teacherPassword) {
		Optional<TeacherBean> resultOptional = teacherRepository.findByEmail(teacherEmail, teacherPassword);

		boolean result = resultOptional.isPresent();

		if (result) {
			return resultOptional.get();
		}
		return null;
	}

	// 找單筆學生
	public TeacherBean findById(Integer teacherId) {
		Optional<TeacherBean> op1 = teacherRepository.findById(teacherId);
		if (op1.isPresent()) {
			return op1.get();
		}
		return null;
	}

	// 找所有教師
	public List<TeacherBean> findAllTeachers() {
		return teacherRepository.findAll();
	}

	// Delete, 刪除
	public boolean deleteById(Integer teacherId) {
		try {
			teacherRepository.deleteById(teacherId);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 新增,註冊老師
	public TeacherBean insert(TeacherBean teachers) {
		return teacherRepository.save(teachers);
	}

	public TeacherBean findByFormatID(String tfID) {
		return teacherRepository.findByTeacherIdFormatted(tfID);
	}

	// 後台修改老師帳號
	public TeacherBean updateTeacherBean(TeacherBean teacherBean) {

		return teacherRepository.save(teacherBean);

	}

}
