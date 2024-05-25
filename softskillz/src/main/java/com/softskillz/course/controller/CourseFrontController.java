package com.softskillz.course.controller;

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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.TeacherService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/courseFront")
public class CourseFrontController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private TeacherScheduleService teacherScheduleService;

	// 學生登入後首頁
	@GetMapping("/selectAllPage")
	public String loadCoursesPage(HttpSession session, Model model) {
		StudentBean student = (StudentBean) session.getAttribute("studentData");

		String loggedInUser = (student != null) ? "student" : "guest";
		model.addAttribute("loggedInUser", loggedInUser);
		System.out.println("Logged in user: " + loggedInUser);

		return "elearning/course/courseSelectPage.html";
	}

	// AJAX 請求所有課程資料
	@GetMapping("/selectAllCourses")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getAllCourses(@RequestParam(required = false) String category,
			@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {

		List<CourseBean> courses;
		if (category == null || category.equals("所有課程")) {
			courses = courseService.findAllCourses();
		} else {
			courses = courseService.findCoursesByCategory(category);
		}

		int start = (page - 1) * size;
		int end = Math.min(start + size, courses.size());
		List<CourseBean> paginatedCourses = courses.subList(start, end);

		Map<String, Object> response = new HashMap<>();
		response.put("courses", paginatedCourses);
		response.put("totalItems", courses.size());

		return ResponseEntity.ok(response);
	}

	// 課程詳情頁面
	@GetMapping("/courseDetail/{courseID}")
	public String getCourseDetail(@PathVariable("courseID") Integer courseID,
			@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Model model) {
		CourseBean course = courseService.findCourseById(courseID);
		if (course == null) {
			return "elearning/404.html";
		}
		TeacherBean teacher = teacherService.findById(course.getTeacherID());
		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService
				.getTeacherSchedulesById(course.getTeacherID());

		// 過濾出今天及之後的行事曆
		LocalDate today = LocalDate.now();
		teacherSchedules = teacherSchedules.stream().filter(schedule -> !schedule.getCourseDate().isBefore(today))
				.collect(Collectors.toList());

		// 對courseDate 進行排序
		teacherSchedules.sort(Comparator.comparing(TeacherScheduleBean::getCourseDate));

		// 格式化日期並分組
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		List<String> formattedDates = teacherSchedules.stream().map(schedule -> {
			LocalDate courseDate = schedule.getCourseDate();
			String dayOfWeek = courseDate.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.CHINESE);
			return courseDate.format(dateFormatter) + " (" + dayOfWeek + ")";
		}).collect(Collectors.toList());

		// 分组每周的資料
		Map<Integer, List<TeacherScheduleBean>> weeklySchedules = new HashMap<>();
		Map<Integer, List<String>> weeklyFormattedDates = new HashMap<>();
		int weekCounter = 0;
		DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY;
		List<TeacherScheduleBean> currentWeekSchedules = new ArrayList<>();
		List<String> currentWeekDates = new ArrayList<>();

		for (int i = 0; i < teacherSchedules.size(); i++) {
			TeacherScheduleBean schedule = teacherSchedules.get(i);
			String formattedDate = formattedDates.get(i);
			if (schedule.getCourseDate().getDayOfWeek() == firstDayOfWeek && !currentWeekSchedules.isEmpty()) {
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

		List<TeacherScheduleBean> paginatedSchedules = weeklySchedules.getOrDefault(currentPage, new ArrayList<>());
		List<String> paginatedDates = weeklyFormattedDates.getOrDefault(currentPage, new ArrayList<>());

		// 教師照片路徑
		String teacherPhotoPath = "/teacher/images/" + teacher.getTeacherPhoto();

		model.addAttribute("course", course);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherSchedules", paginatedSchedules);
		model.addAttribute("formattedDates", paginatedDates);
		model.addAttribute("currentPage", currentPage + 1);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("teacherPhotoPath", teacherPhotoPath);

		StudentBean student = (StudentBean) session.getAttribute("studentData");

		if (student != null) {
			model.addAttribute("loggedInUser", "student");
		} else {
			model.addAttribute("loggedInUser", "guest");
		}

		return "elearning/course/courseDetailPage.jsp";
	}

	@GetMapping("/selectTimeSlots")
	public String selectTimeSlots(@RequestParam("courseID") int courseID,
			@RequestParam("teacherScheduleID") int teacherScheduleID, HttpSession session, Model model) {

		StudentBean student = (StudentBean) session.getAttribute("studentData");
		if (student == null) {
			return "redirect:/student/student-loginPage";
		}
		CourseBean course = courseService.findCourseById(courseID);
		TeacherScheduleBean teacherSchedule = teacherScheduleService.findTeacherScheduleById(teacherScheduleID);

		model.addAttribute("course", course);
		model.addAttribute("teacherSchedule", teacherSchedule);
		model.addAttribute("student", student);

		return "elearning/course/studentReservationSelect.jsp";
	}
}