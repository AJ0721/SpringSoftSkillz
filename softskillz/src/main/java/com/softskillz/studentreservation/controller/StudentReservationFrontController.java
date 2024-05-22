package com.softskillz.studentreservation.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
<<<<<<< HEAD
import com.softskillz.coursechatdemo.controller.ChatController;
=======
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
import com.softskillz.studentreservation.model.ReservationException;
import com.softskillz.studentreservation.model.StudentReservationBean;
import com.softskillz.studentreservation.model.StudentReservationService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/studentReservationFront")
public class StudentReservationFrontController {
<<<<<<< HEAD

	@Autowired
	private CourseService courseService;

	@Autowired
	private StudentReservationService studentReservationService;

	@Autowired
	private TeacherScheduleService teacherScheduleService;

	@Autowired
	private ChatController chatController;

=======
	
	@Autowired
    private CourseService courseService;

	@Autowired
	private StudentReservationService studentReservationService;
	
	@Autowired
	private TeacherScheduleService teacherScheduleService;

>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
	@PostMapping("/add")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addStudentReservation(
			@RequestParam("studentTimeSlots") String studentTimeSlots, @RequestParam("totalHours") int totalHours,
			@RequestParam("courseID") int courseID, @RequestParam("teacherScheduleID") int teacherScheduleID,
			HttpSession session) {

		StudentBean student = (StudentBean) session.getAttribute("studentData");

		try {
			StudentReservationBean reservation = new StudentReservationBean();
			reservation.setCourseID(courseID);
			reservation.setTeacherScheduleID(teacherScheduleID);
			reservation.setReservationDate(LocalDate.now());
			reservation.setStudentID(student.getStudentId());
			reservation.setStudentTimeSlots(studentTimeSlots);
			reservation.setTotalHours(totalHours);

			StudentReservationBean savedReservation = studentReservationService.insertStudentReservation(reservation);

<<<<<<< HEAD
			// 發送 Zoom 會議連結
			String zoomMeetingUrl = savedReservation.getZoomMeetingUrl();
			TeacherScheduleBean teacherSchedule = teacherScheduleService.findTeacherScheduleById(teacherScheduleID);
			LocalDate courseDate = teacherSchedule.getCourseDate();
			// 處理時間段的顯示格式
			String[] timeSlots = studentTimeSlots.replaceAll("[\\[\\]\"]", "").split(",");
			StringBuilder courseTimeBuilder = new StringBuilder();
			for (String timeSlot : timeSlots) {
				if (!timeSlot.trim().isEmpty()) {
					courseTimeBuilder.append(timeSlot.trim()).append(", ");
				}
			}
			String courseTime = courseTimeBuilder.length() > 0
					? courseTimeBuilder.substring(0, courseTimeBuilder.length() - 2)
					: "";

			Map<String, String> dataMap = new HashMap<>();
			dataMap.put("studentID", String.valueOf(student.getStudentId()));
			dataMap.put("teacherID",
					String.valueOf(teacherScheduleService.findTeacherScheduleById(teacherScheduleID).getTeacherID()));
			dataMap.put("msg", "您的 「 " + courseDate + " " + courseTime + " 」 Zoom 會議連結 : " + zoomMeetingUrl);

			// 呼叫 ChatController 的 sendMessage 方法
			chatController.sendMessage(dataMap);

			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("message", "學生預約新增成功，Zoom 會議連結已發送");
			response.put("courseID", courseID);
=======
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("message", "學生預約新增成功");
			response.put("courseID", courseID);
			response.put("zoomMeetingUrl", savedReservation.getZoomMeetingUrl());
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d

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
<<<<<<< HEAD

	// 該學生所有學生預約的頁面
	@GetMapping("/reservation")
	public String showReservation(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		StudentBean student = (StudentBean) session.getAttribute("studentData");
		if (student == null) {
			return "redirect:/student-loginPage/student-login";
		}

		List<StudentReservationBean> studentReservations = studentReservationService
				.getStudentReservationsById(student.getStudentId());
		for (StudentReservationBean reservation : studentReservations) {
			CourseBean course = courseService.findCourseById(reservation.getCourseID());
			reservation.setCourseBean(course);

			TeacherScheduleBean schedule = teacherScheduleService
					.findTeacherScheduleById(reservation.getTeacherScheduleID());
			reservation.setTeacherScheduleBean(schedule);
		}

		// 按照課程日期排序
		studentReservations
				.sort(Comparator.comparing(reservation -> reservation.getTeacherScheduleBean().getCourseDate()));

		// 格式化日期
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		List<String> formattedCourseDates = studentReservations.stream()
				.map(reservation -> reservation.getTeacherScheduleBean().getCourseDate().format(dateFormatter))
				.collect(Collectors.toList());
		List<String> formattedReservationDates = studentReservations.stream()
				.map(reservation -> reservation.getReservationDate().format(dateFormatter))
				.collect(Collectors.toList());

		// 分组每周的資料
		Map<Integer, List<StudentReservationBean>> weeklyReservations = new HashMap<>();
		Map<Integer, List<String>> weeklyCourseDates = new HashMap<>();
		Map<Integer, List<String>> weeklyReservationDates = new HashMap<>();
		int weekCounter = 0;
		DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY; // 週一開始
		List<StudentReservationBean> currentWeekReservations = new ArrayList<>();
		List<String> currentWeekCourseDates = new ArrayList<>();
		List<String> currentWeekReservationDates = new ArrayList<>();

		for (int i = 0; i < studentReservations.size(); i++) {
			StudentReservationBean reservation = studentReservations.get(i);
			String courseDate = formattedCourseDates.get(i);
			String reservationDate = formattedReservationDates.get(i);
			if (reservation.getTeacherScheduleBean().getCourseDate().getDayOfWeek() == firstDayOfWeek
					&& !currentWeekReservations.isEmpty()) {
				weeklyReservations.put(weekCounter, new ArrayList<>(currentWeekReservations));
				weeklyCourseDates.put(weekCounter, new ArrayList<>(currentWeekCourseDates));
				weeklyReservationDates.put(weekCounter, new ArrayList<>(currentWeekReservationDates));
				currentWeekReservations.clear();
				currentWeekCourseDates.clear();
				currentWeekReservationDates.clear();
				weekCounter++;
			}
			currentWeekReservations.add(reservation);
			currentWeekCourseDates.add(courseDate);
			currentWeekReservationDates.add(reservationDate);
		}
		// 隔週
		if (!currentWeekReservations.isEmpty()) {
			weeklyReservations.put(weekCounter, currentWeekReservations);
			weeklyCourseDates.put(weekCounter, currentWeekCourseDates);
			weeklyReservationDates.put(weekCounter, currentWeekReservationDates);
		}

		// 分頁邏輯
		int totalPages = weeklyReservations.size();
		int currentPage = Math.min(page - 1, totalPages - 1);
		if (currentPage < 0)
			currentPage = 0;

		List<StudentReservationBean> paginatedReservations = weeklyReservations.getOrDefault(currentPage,
				new ArrayList<>());
		List<String> paginatedCourseDates = weeklyCourseDates.getOrDefault(currentPage, new ArrayList<>());
		List<String> paginatedReservationDates = weeklyReservationDates.getOrDefault(currentPage, new ArrayList<>());

		model.addAttribute("studentReservations", paginatedReservations);
		model.addAttribute("formattedCourseDates", paginatedCourseDates);
		model.addAttribute("formattedReservationDates", paginatedReservationDates);
		model.addAttribute("currentPage", currentPage + 1); // 分頁從1開始
		model.addAttribute("totalPages", totalPages);

		return "elearning/studentReservation/studentReservationPage.jsp";
	}
=======
	
	// 該學生所有學生預約的頁面
	@GetMapping("/reservation")
    public String showReservation(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        StudentBean student = (StudentBean) session.getAttribute("studentData");
        if (student == null) {
            return "redirect:/student-loginPage/student-login";
        }

        List<StudentReservationBean> studentReservations = studentReservationService.getStudentReservationsById(student.getStudentId());
        for (StudentReservationBean reservation : studentReservations) {
            CourseBean course = courseService.findCourseById(reservation.getCourseID());
            reservation.setCourseBean(course);

            TeacherScheduleBean schedule = teacherScheduleService.findTeacherScheduleById(reservation.getTeacherScheduleID());
            reservation.setTeacherScheduleBean(schedule);
        }

        // 按照課程日期排序
        studentReservations.sort(Comparator.comparing(reservation -> reservation.getTeacherScheduleBean().getCourseDate()));

        // 格式化日期
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        List<String> formattedCourseDates = studentReservations.stream()
            .map(reservation -> reservation.getTeacherScheduleBean().getCourseDate().format(dateFormatter))
            .collect(Collectors.toList());
        List<String> formattedReservationDates = studentReservations.stream()
            .map(reservation -> reservation.getReservationDate().format(dateFormatter))
            .collect(Collectors.toList());

        // 分组每周的資料
        Map<Integer, List<StudentReservationBean>> weeklyReservations = new HashMap<>();
        Map<Integer, List<String>> weeklyCourseDates = new HashMap<>();
        Map<Integer, List<String>> weeklyReservationDates = new HashMap<>();
        int weekCounter = 0;
        DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY; // 週一開始
        List<StudentReservationBean> currentWeekReservations = new ArrayList<>();
        List<String> currentWeekCourseDates = new ArrayList<>();
        List<String> currentWeekReservationDates = new ArrayList<>();

        for (int i = 0; i < studentReservations.size(); i++) {
            StudentReservationBean reservation = studentReservations.get(i);
            String courseDate = formattedCourseDates.get(i);
            String reservationDate = formattedReservationDates.get(i);
            if (reservation.getTeacherScheduleBean().getCourseDate().getDayOfWeek() == firstDayOfWeek && !currentWeekReservations.isEmpty()) {
                weeklyReservations.put(weekCounter, new ArrayList<>(currentWeekReservations));
                weeklyCourseDates.put(weekCounter, new ArrayList<>(currentWeekCourseDates));
                weeklyReservationDates.put(weekCounter, new ArrayList<>(currentWeekReservationDates));
                currentWeekReservations.clear();
                currentWeekCourseDates.clear();
                currentWeekReservationDates.clear();
                weekCounter++;
            }
            currentWeekReservations.add(reservation);
            currentWeekCourseDates.add(courseDate);
            currentWeekReservationDates.add(reservationDate);
        }
        // 隔週
        if (!currentWeekReservations.isEmpty()) {
            weeklyReservations.put(weekCounter, currentWeekReservations);
            weeklyCourseDates.put(weekCounter, currentWeekCourseDates);
            weeklyReservationDates.put(weekCounter, currentWeekReservationDates);
        }

        // 分頁邏輯
        int totalPages = weeklyReservations.size();
        int currentPage = Math.min(page - 1, totalPages - 1);
        if (currentPage < 0)
            currentPage = 0;

        List<StudentReservationBean> paginatedReservations = weeklyReservations.getOrDefault(currentPage, new ArrayList<>());
        List<String> paginatedCourseDates = weeklyCourseDates.getOrDefault(currentPage, new ArrayList<>());
        List<String> paginatedReservationDates = weeklyReservationDates.getOrDefault(currentPage, new ArrayList<>());

        model.addAttribute("studentReservations", paginatedReservations);
        model.addAttribute("formattedCourseDates", paginatedCourseDates);
        model.addAttribute("formattedReservationDates", paginatedReservationDates);
        model.addAttribute("currentPage", currentPage + 1); // 分頁從1開始
        model.addAttribute("totalPages", totalPages);

        return "elearning/studentReservation/studentReservationPage.jsp";
    }
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d

}
