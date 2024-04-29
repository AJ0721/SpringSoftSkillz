package com.softskillz.studentreservation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.StudentService;
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

	// 學生預約課程CRUD頁面
	@GetMapping("/studentReservationPage/studentReservationAllPage")
	public String studentReservationAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/studentReservation/studentReservationPage/studentReservationAllPage.jsp";
	}

	// 新增學生預約的頁面
	@PostMapping("/insert")
	public String insertStudentReservationPage(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);

		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService.findAllTeacherSchedules();
		model.addAttribute("teacherSchedules", teacherSchedules);

		List<StudentBean> students = studentService.findAllStudents();
		model.addAttribute("students", students);
		return "/studentReservation/studentReservationPage/studentReservationInsert.jsp";
	}

	@PostMapping("/add")
	public String addStudentReservation(@ModelAttribute StudentReservationBean studentReservationBean,
			RedirectAttributes redirectAttributes) throws ReservationException {

		StudentReservationBean newStudentReservation = studentReservationService
				.insertStudentReservation(studentReservationBean);
		if (newStudentReservation != null && newStudentReservation.getTeacherScheduleID() > 0) {
			redirectAttributes.addFlashAttribute("message", "學生預約新增成功");
		} else {
			redirectAttributes.addFlashAttribute("error", "學生預約新增失敗");
		}
		return "/studentReservation/studentReservationPage/studentReservationInsertSuccessed.jsp"; // 這裡填寫成功頁面的路徑
	}

	// 根據學生預約編號查詢單筆學生預約資料的頁面
	@GetMapping("/select")
	public String selectStudentReservationPage(Model model) {
		List<StudentReservationBean> reservations = studentReservationService.findAllStudentReservations();
		model.addAttribute("reservations", reservations);
		return "/studentReservation/studentReservationPage/studentReservationSelect";
	}

	@GetMapping("/oneStudentReservation")
	public String getStudentReservation(@RequestParam("studentReservationID") int studentReservationID, Model model) {
		StudentReservationBean reservations = studentReservationService
				.findStudentReservationById(studentReservationID);
		model.addAttribute("reservations", reservations);
		return "/studentReservation/studentReservationPage/studentReservationSelectSuccessed.jsp"; // 指向查詢成功的頁面
	}

	// 根據學生編號查詢該學生所有預約的頁面
	@GetMapping("/selectAll")
	public String selectAllTeacherSchedulePage(Model model) {
		List<StudentBean> student = studentService.findAllStudents();
		model.addAttribute("student", student);
		return "/studentReservation/studentReservationPage/studentReservationSelectAll.jsp";
	}

	@GetMapping("/allReservations")
	public String getStudentReservations(@RequestParam("studentId") int studentId, Model model) {
		List<StudentReservationBean> reservations = studentReservationService.getStudentReservationsById(studentId);
		model.addAttribute("reservations", reservations);
		return "/studentReservation/studentReservationPage/studentReservationSelectAllById.jsp";
	}

	// 刪除學生預約的頁面
	@PostMapping("/delete")
	public String deleteStudentReservationPage(Model model) {
		List<StudentReservationBean> reservations = studentReservationService.findAllStudentReservations();
		model.addAttribute("reservations", reservations);
		return "/studentReservation/studentReservationPage/studentReservationDelete.jsp";
	}

	// 處理刪除學生預約的請求
	@PostMapping("/deleted")
	public String deleteStudentReservation(@RequestParam("studentReservationID") Integer studentReservationID,
			RedirectAttributes redirectAttributes) {
		studentReservationService.deleteByStudentReservationId(studentReservationID);
		redirectAttributes.addFlashAttribute("message", "預約刪除成功");
		return "/studentReservation/studentReservationPage/studentReservationDeleteSuccessed.jsp";
	}

	
//	@GetMapping("/insertSelect")
//	public String insertSelectStudentReservationPage(@RequestParam("courseID") int courseID,
//			@RequestParam("teacherScheduleID") int teacherScheduleID, Model model) {
////		List<CourseBean> courses = courseService.findAllCourses();
////		model.addAttribute("courses", courses);
////
////		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService.findAllTeacherSchedules();
////		model.addAttribute("teacherSchedules", teacherSchedules);
//
//		TeacherScheduleBean schedule = teacherScheduleService.findTeacherScheduleById(teacherScheduleID);
//
//		List<StudentBean> students = studentService.findAllStudents();
//		model.addAttribute("teacherSchedule", schedule);
//		model.addAttribute("students", students);
//		return "/studentReservation/studentReservationPage/studentReservationInsertEdit";
//	}

}
