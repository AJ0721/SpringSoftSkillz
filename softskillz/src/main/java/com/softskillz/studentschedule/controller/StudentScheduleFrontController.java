package com.softskillz.studentschedule.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.studentschedule.model.StudentScheduleBean;
import com.softskillz.studentschedule.model.StudentScheduleService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/studentScheduleFront")
public class StudentScheduleFrontController {

	@Autowired
	private StudentScheduleService studentScheduleService;

	@Autowired
	private CourseService courseService;

	// 該學生所有學生行事曆的頁面
	@GetMapping("/schedule")
	public String showSchedule(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		StudentBean student = (StudentBean) session.getAttribute("studentData");
		if (student == null) {
			return "redirect:/student-loginPage/student-login";
		}

		List<StudentScheduleBean> studentSchedules = studentScheduleService
				.getStudentSchedulesById(student.getStudentId());
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

		// 過濾出今天及之後的行事曆
		LocalDate today = LocalDate.now();
		studentSchedules = studentSchedules.stream()
				.filter(schedule -> !schedule.getStudentCourseDate().isBefore(today)).collect(Collectors.toList());

		// 對courseDate排序
		studentSchedules.sort(Comparator.comparing(StudentScheduleBean::getStudentCourseDate));

		// 格式化日期並分組
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		List<String> formattedDates = studentSchedules.stream().map(schedule -> {
			LocalDate courseDate = schedule.getStudentCourseDate();
			String dayOfWeek = courseDate.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.CHINESE);
			return courseDate.format(dateFormatter) + " (" + dayOfWeek + ")";
		}).collect(Collectors.toList());

		// 分组每周的資料
		Map<Integer, List<StudentScheduleBean>> weeklySchedules = new HashMap<>();
		Map<Integer, List<String>> weeklyFormattedDates = new HashMap<>();
		int weekCounter = 0;
		DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY;// 週一開始
		List<StudentScheduleBean> currentWeekSchedules = new ArrayList<>();
		List<String> currentWeekDates = new ArrayList<>();

		for (int i = 0; i < studentSchedules.size(); i++) {
			StudentScheduleBean schedule = studentSchedules.get(i);
			String formattedDate = formattedDates.get(i);
			if (schedule.getStudentCourseDate().getDayOfWeek() == firstDayOfWeek && !currentWeekSchedules.isEmpty()) {
				weeklySchedules.put(weekCounter, new ArrayList<>(currentWeekSchedules));
				weeklyFormattedDates.put(weekCounter, new ArrayList<>(currentWeekDates));
				currentWeekSchedules.clear();
				currentWeekDates.clear();
				weekCounter++;
			}
			currentWeekSchedules.add(schedule);
			currentWeekDates.add(formattedDate);
		}
		// 隔週
		if (!currentWeekSchedules.isEmpty()) {
			weeklySchedules.put(weekCounter, currentWeekSchedules);
			weeklyFormattedDates.put(weekCounter, currentWeekDates);
		}

		// 分頁邏輯
		int totalPages = weeklySchedules.size();
		int currentPage = Math.min(page - 1, totalPages - 1);
		if (currentPage < 0)
			currentPage = 0;

		List<StudentScheduleBean> paginatedSchedules = weeklySchedules.getOrDefault(currentPage, new ArrayList<>());
		List<String> paginatedDates = weeklyFormattedDates.getOrDefault(currentPage, new ArrayList<>());

		model.addAttribute("studentSchedules", paginatedSchedules);
		model.addAttribute("formattedDates", paginatedDates);
		model.addAttribute("currentPage", currentPage + 1); // 分頁從1開始
		model.addAttribute("totalPages", totalPages);

		return "elearning/studentSchedule/studentSchedulePage.jsp";
	}

}
