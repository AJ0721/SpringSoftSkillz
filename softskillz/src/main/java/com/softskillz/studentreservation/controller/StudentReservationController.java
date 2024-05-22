package com.softskillz.studentreservation.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.studentreservation.model.ReservationException;
import com.softskillz.studentreservation.model.StudentReservationBean;
import com.softskillz.studentreservation.model.StudentReservationService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

import jakarta.servlet.http.HttpSession;

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

	@GetMapping("/getTimeSlots")
    @ResponseBody
    public ResponseEntity<Map<String, String>> getTimeSlots(@RequestParam("teacherScheduleID") int teacherScheduleID) {
        TeacherScheduleBean teacherSchedule = teacherScheduleService.findTeacherScheduleById(teacherScheduleID);
        if (teacherSchedule != null) {
            Map<String, String> response = new HashMap<>();
            response.put("teacherTimeSlots", teacherSchedule.getTeacherTimeSlots());
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addStudentReservation(
            @RequestParam("studentTimeSlots") String studentTimeSlots, @RequestParam("totalHours") int totalHours,
            @RequestParam("courseID") int courseID, @RequestParam("teacherScheduleID") int teacherScheduleID,
            @RequestParam("studentID") int studentID) {

        try {
            StudentReservationBean reservation = new StudentReservationBean();
            reservation.setCourseID(courseID);
            reservation.setTeacherScheduleID(teacherScheduleID);
            reservation.setReservationDate(LocalDate.now());
            reservation.setStudentID(studentID);
            reservation.setStudentTimeSlots(studentTimeSlots);
            reservation.setTotalHours(totalHours);

            StudentReservationBean savedReservation = studentReservationService.insertStudentReservation(reservation);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "學生預約新增成功");
            response.put("courseID", courseID);
            response.put("zoomMeetingUrl", savedReservation.getZoomMeetingUrl());

            return ResponseEntity.ok(response);

        } catch (ReservationException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new HashMap<String, Object>() {
                {
                    put("success", false);
                    put("message", e.getMessage());
                }
            });
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new HashMap<String, Object>() {
                {
                    put("success", false);
                    put("message", "學生預約新增失敗：" + e.getMessage());
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
	public ResponseEntity<?> deleteStudentReservation(
			@RequestParam("studentReservationID") Integer studentReservationID) {
		try {
			// 調用更新後的刪除預約及更新行事曆方法
			studentReservationService.deleteStudentReservationAndUpdateSchedules(studentReservationID);
			return ResponseEntity.ok().body(new HashMap<String, Object>() {
				{
					put("success", true);
					put("message", "學生預約刪除成功");
				}
			});
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new HashMap<String, Object>() {
				{
					put("success", false);
					put("message", "學生預約刪除失敗: " + e.getMessage());
				}
			});
		}
	}

}
