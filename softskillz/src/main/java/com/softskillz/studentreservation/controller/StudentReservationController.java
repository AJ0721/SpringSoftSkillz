package com.softskillz.studentreservation.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.StudentService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.studentreservation.model.ReservationException;
import com.softskillz.studentreservation.model.StudentReservationBean;
import com.softskillz.studentreservation.model.StudentReservationService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

@Controller
@RequestMapping("/studentReservation")
public class StudentReservationController {

	@Autowired
	private StudentReservationService studentReservationService;

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherScheduleService teacherScheduleService;

	@Autowired
	private StudentService studentService;

	// 模版新增學生預約CRUD頁面
	@GetMapping("/insertPage")
	public String studentReservationInsertPage(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);

		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService.findAllTeacherSchedules();
		model.addAttribute("teacherSchedules", teacherSchedules);

		List<StudentBean> students = studentService.findAllStudents();
		model.addAttribute("students", students);
		return "/dist/studentReservation/studentReservationInsert.jsp";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public ResponseEntity<?> addStudentReservation(@ModelAttribute StudentReservationBean studentReservationBean) {
		try {
			StudentReservationBean newStudentReservation = studentReservationService.insertStudentReservation(studentReservationBean);
			if (newStudentReservation != null && newStudentReservation.getTeacherScheduleID() > 0) {
				return ResponseEntity.ok().body(new HashMap<String, Object>() {
					{
						put("success", true);
						put("message", "學生預約新增成功");
					}
				});
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new HashMap<String, Object>() {
					{
						put("success", false);
						put("message", "學生預約新增失敗");
					}
				});
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new HashMap<String, Object>() {
				{
					put("success", false);
					put("message", "處理請求時發生錯誤");
				}
			});
		}
	}

	// 根據學生編號查詢該學生所有預約的頁面
	@GetMapping("/selectAllPage")
	public String selectAllTeacherSchedulePage(Model model) {
		List<StudentBean> student = studentService.findAllStudents();
		model.addAttribute("student", student);
		return "/dist/studentReservation/studentReservationSelect.jsp";
	}

	@GetMapping("/allReservations")
	public String getStudentReservations(@RequestParam("studentId") int studentId, Model model) {
		List<StudentReservationBean> reservations = studentReservationService.getStudentReservationsById(studentId);
		model.addAttribute("reservations", reservations);
		return "/dist/studentReservation/studentReservationSelectAll.jsp";
	}

	// 處理刪除學生預約的請求
	@PostMapping("/deleted")
	@ResponseBody
	public ResponseEntity<?> deleteStudentReservation(@RequestParam("studentReservationID") Integer studentReservationID) {
		try {
			studentReservationService.deleteByStudentReservationId(studentReservationID);
			return ResponseEntity.ok().body("學生預約刪除成功");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("學生預約刪除失敗");
		}
	}

}
