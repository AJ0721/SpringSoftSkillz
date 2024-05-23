package com.softskillz.account.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.messaging.MessagingException;
import org.springframework.stereotype.Service;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.StudentNewPwdBean;
import com.softskillz.account.model.repository.StudentEmailRepository;
import com.softskillz.account.model.repository.StudentRepository;

import jakarta.mail.internet.MimeMessage;

@Service
public class StudentService {

	@Autowired
	private StudentRepository studentRepository;
	@Autowired
	private StudentEmailRepository studentEmailRepository;
	@Autowired
	private JavaMailSender javaMailSender;

	// 學生帳號登入
	public StudentBean usernameCheckLogin(String studentUsername, String studentPassword) {
		Optional<StudentBean> resultOptional = studentRepository.findByUsername(studentUsername, studentPassword);

		boolean result = resultOptional.isPresent();

		if (result) {
//			StudentBean studentBean = resultOptional.get();
			return resultOptional.get();
		}
		return null;
	}

	// 學生信箱登入
	public StudentBean emailCheckLogin(String studentEmail, String studentPassword) {
		Optional<StudentBean> resultOptional = studentRepository.findByEmail(studentEmail, studentPassword);

		boolean result = resultOptional.isPresent();

		if (result) {
//			StudentBean studentBean = resultOptional.get();
			return resultOptional.get();
		}
		return null;
	}

	// 找所有學生
	public List<StudentBean> findAllStudents() {
		return studentRepository.findAll();
	}

	public StudentBean update(StudentBean studentBean) {
		return studentRepository.save(studentBean);
	}

	public StudentBean getById(Integer id) {
		Optional<StudentBean> op1 = studentRepository.findById(id);

		if (op1.isPresent()) {
			return op1.get();
		}

		return null;
	}

	// 找單筆學生
	public StudentBean findById(Integer studentId) {
		Optional<StudentBean> op1 = studentRepository.findById(studentId);
		if (op1.isPresent()) {
			return op1.get();
		}
		return null;
	}

	// Create,新增,註冊學生
	public StudentBean insert(StudentBean students) {
		return studentRepository.save(students);

	}

	// Delete, 刪除
	public boolean deleteById(Integer studentId) {
		try {
			studentRepository.deleteById(studentId);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// 後台修改學生帳號
	public StudentBean updateStudentBean(StudentBean studentBean) {

		return studentRepository.save(studentBean);

	}

	public StudentBean findStudentByFormatID(String studentIdFormatted) {
		return studentRepository.findByStudentIdFormatted(studentIdFormatted);
	}

	/************************************
	 * 忘記密碼
	 *************************************/
	// 用帳號找信箱
	public Optional<StudentBean> findStudentByEmail(String studentEmail) {
		Optional<StudentBean> resultOptional = studentRepository.findStudentByEmail(studentEmail);

		boolean result = resultOptional.isPresent();

		if (result) {
			return resultOptional;
		}
		return null;
	}

	public void sendPlainText(String receivers, String subject, String content, String from)
			throws jakarta.mail.MessagingException {
		MimeMessage mailMessage = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "UTF-8");

		helper.setTo(receivers);
		helper.setSubject(subject);
		helper.setText(content, true);
		helper.setFrom(from);

		javaMailSender.send(mailMessage);
	}

	/************************************
	 * token表操作
	 *************************************/
	// 把新密碼放進去
	public StudentNewPwdBean insertForgotPwd(StudentNewPwdBean newPwd) {
		return studentEmailRepository.save(newPwd);
	}

	// 把新密碼放進去
	public Optional<StudentNewPwdBean> findToken(String token) {
		return studentEmailRepository.findToken(token);
	}

	// Delete, 刪除
	// 對應token此表的id
	public void deleteToken(Integer tokenId) {
		studentEmailRepository.deleteById(tokenId);
	}

}
