package com.softskillz.teacherschedule.controller;

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
import org.springframework.format.annotation.DateTimeFormat;
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

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.TeacherService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/teacherScheduleFront")
public class TeacherScheduleFrontController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherScheduleService teacherScheduleService;

	// 新增課程的頁面
	@GetMapping("/teacherInsertCourse")
	public String courseInsertPage(HttpSession session, Model model) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		if (teacher == null) {
			return "redirect:/teacher-loginPage/teacher-login"; // 如果session中沒有teacherData，重定向到登入頁面
		}
		model.addAttribute("teacher", teacher);
		return "elearning/teacherSchedule/courseInsert.jsp";
	}

	// 新增課程
	@PostMapping("/addCourse")
	@ResponseBody // 確保返回的是響應體而非視圖名
	public ResponseEntity<?> addCourse(@ModelAttribute CourseBean courseBean, HttpSession session) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		if (teacher == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("未授權的請求");
		}
		courseBean.setTeacherID(teacher.getTeacherId());

		CourseBean newCourse = courseService.insertCourse(courseBean);
		if (newCourse != null && newCourse.getCourseID() != null) {
			return ResponseEntity.ok("課程添加成功");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("課程添加失敗");
		}
	}

	// 查詢該教師所有課程的頁面
	@GetMapping("/teacherSelectCourse")
	public String courseSelectPage(HttpSession session, Model model) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		if (teacher == null) {
			return "redirect:/teacher-loginPage/teacher-login"; // 如果session中沒有teacherData，重定向到登入頁面
		}
		List<CourseBean> courses = courseService.findCoursesByTeacherID(teacher.getTeacherId());
		model.addAttribute("teacher", teacher);
		model.addAttribute("courses", courses);
		return "elearning/teacherSchedule/courseSelect.jsp";
	}

	// 新增教師行事曆的頁面
	@GetMapping("/teacherInsertSchedule")
	public String scheduleInsertPage(HttpSession session, Model model) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		if (teacher == null) {
			return "redirect:/teacherScheduleFront/login"; // 如果session中沒有teacherData，重定向到登入頁面
		}
		model.addAttribute("teacher", teacher);
		return "elearning/teacherSchedule/scheduleInsert.jsp";
	}

	// 確認是否已有該筆教師行事曆
	@GetMapping("/check")
	@ResponseBody
	public String checkDuplicate(@RequestParam("teacherID") int teacherID,
			@RequestParam("courseDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate courseDate) {
		boolean exists = teacherScheduleService.existsByTeacherIDAndCourseDate(teacherID, courseDate);
		return String.valueOf(exists);
	}

	// 新增教師行事曆
	@PostMapping("/addSchedule")
	@ResponseBody // 標記為返回響應體
	public ResponseEntity<?> addTeacherSchedule(@ModelAttribute TeacherScheduleBean teacherScheduleBean,
			HttpSession session) {
		try {
			TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
			if (teacher == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new HashMap<String, Object>() {
					{
						put("success", false);
						put("message", "未授權的請求");
					}
				});
			}
			teacherScheduleBean.setTeacherID(teacher.getTeacherId());

			TeacherScheduleBean newTeacherSchedule = teacherScheduleService.insertTeacherSchedule(teacherScheduleBean);
			if (newTeacherSchedule != null && newTeacherSchedule.getTeacherScheduleID() > 0) {
				return ResponseEntity.ok().body(new HashMap<String, Object>() {
					{
						put("success", true);
						put("message", "教師行事曆新增成功");
					}
				});
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new HashMap<String, Object>() {
					{
						put("success", false);
						put("message", "教師行事曆新增失敗");
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

	// 該教師所有教師行事曆的頁面
	@GetMapping("/schedule")
	public String showSchedule(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		TeacherBean teacher = (TeacherBean) session.getAttribute("teacherData");
		if (teacher == null) {
			return "redirect:/teacher-loginPage/teacher-login";
		}

		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService
				.getTeacherSchedulesById(teacher.getTeacherId());

		// 過濾出今天及之後的行事曆
		LocalDate today = LocalDate.now();
		teacherSchedules = teacherSchedules.stream().filter(schedule -> !schedule.getCourseDate().isBefore(today))
				.collect(Collectors.toList());

		// 對courseDate排序
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
		DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY;// 週一開始
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

		model.addAttribute("teacherSchedules", paginatedSchedules);
		model.addAttribute("formattedDates", paginatedDates);
		model.addAttribute("currentPage", currentPage + 1); // 分頁從1開始
		model.addAttribute("totalPages", totalPages);

		return "elearning/teacherSchedule/teacherSchedulePage.jsp";
	}

}
