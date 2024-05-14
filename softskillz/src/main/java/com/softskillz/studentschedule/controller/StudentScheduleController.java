package com.softskillz.studentschedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.service.StudentService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.studentschedule.model.StudentScheduleBean;
import com.softskillz.studentschedule.model.StudentScheduleService;

@Controller
@RequestMapping("/studentSchedule")
public class StudentScheduleController {

	@Autowired
    private CourseService courseService;
	
	@Autowired
	private StudentService studentService;

	@Autowired
	private StudentScheduleService studentScheduleService;

	// 根據教師編號查詢該教師所有行事曆的頁面
	@GetMapping("/selectAllPage")
	public String selectAllStudentSchedules(Model model) {
		List<StudentBean> students = studentService.findAllStudents();
		model.addAttribute("students", students);
		return "/dist/studentSchedule/studentScheduleSelect.jsp";
	}

	@GetMapping("/allSchedules")
	public String getStudentSchedules(@RequestParam("studentId") int studentId, Model model) {
		List<StudentScheduleBean> studentSchedules = studentScheduleService.getStudentSchedulesById(studentId);
		Map<Integer, CourseBean> courseMap = new HashMap<>();

		for (StudentScheduleBean schedule : studentSchedules) {
			String[] reservationIds = schedule.getStudentTimeSlotsAll().split("-");
			StringBuilder scheduleDisplay = new StringBuilder();

			for (int i = 0; i < reservationIds.length; i++) {
				if (!reservationIds[i].equals("0")) {
					int reservationId = Integer.parseInt(reservationIds[i]);
					CourseBean course = courseMap.computeIfAbsent(reservationId,
							id -> courseService.findCourseById(id));
					if (course != null) {
						String hour = String.format("%02d:00", i);
						scheduleDisplay.append(hour).append(" - ").append(course.getCourseName()).append(", ");
					}
				}
			}
			if (scheduleDisplay.length() > 0) {
				scheduleDisplay.setLength(scheduleDisplay.length() - 2);
			}
			schedule.setFormattedSchedule(scheduleDisplay.toString());
		}

		model.addAttribute("studentSchedules", studentSchedules);
		return "/dist/studentSchedule/studentScheduleSelectAll.jsp";
	}

	// 處理刪除教師行事曆的請求
	@PostMapping("/deleted")
	@ResponseBody
	public ResponseEntity<?> deleteStudentSchedule(@RequestParam("studentScheduleID") Integer studentScheduleID) {
		try {
			studentScheduleService.deleteByStudentScheduleId(studentScheduleID);
			return ResponseEntity.ok().body("行事曆刪除成功");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("行事曆刪除失敗");
		}
	}
}
