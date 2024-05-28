package com.softskillz.studentreservation.model;

import java.io.IOException;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.jdbc.core.JdbcTemplate;

import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;
import com.softskillz.courseorder.model.service.impl.CourseOrderItemServiceImpl;
import com.softskillz.studentschedule.model.StudentScheduleBean;
import com.softskillz.studentschedule.model.StudentScheduleRepository;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleRepository;
import com.softskillz.zoom.model.ZoomService;

@Service
@Transactional
public class StudentReservationService {

	@Autowired
	private StudentReservationRepository studentReservationRepository;

	@Autowired
	private StudentScheduleRepository studentScheduleRepository;

	@Autowired
	private TeacherScheduleRepository teacherScheduleRepository;

	@Autowired
	private ZoomService zoomService;

	@Autowired
	private CourseService courseService;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private CourseOrderItemServiceImpl coiService;

	// 檢查預約時數是否超過購買時數
	public boolean checkHoursLimit(int studentId, int courseId, int requestedHours) {
		String sql = "SELECT " + "SUM(ci.qty) AS total_purchased_hours, "
//				+ "(SELECT SUM(sr.total_hours) FROM student_reservation sr WHERE sr.student_id = ? AND sr.course_id = ?) + "
				+ "SUM(ci.item_status) AS total_used_hours " + "FROM corderitem ci "
				+ "JOIN corder co ON ci.order_id = co.order_id AND co.order_status = '已付款' "
				+ "WHERE co.student_id = ? AND ci.course_id = ? " + "GROUP BY ci.course_id";

		List<Boolean> results = jdbcTemplate.query(sql, ps -> {
			ps.setInt(1, studentId);
			ps.setInt(2, courseId);
		}, (rs, rowNum) -> {
			int totalPurchasedHours = rs.getInt("total_purchased_hours");
			int totalUsedHours = rs.getInt("total_used_hours");
			System.out.println("totalPurchasedHours" + totalPurchasedHours);
			System.out.println("totalUsedHours" + totalUsedHours);

			return (totalUsedHours + requestedHours) <= totalPurchasedHours;
		});

		return results.isEmpty() ? false : results.get(0);
	}

	// 新增學生預約 將網址用彈窗顯示在網頁的版本
	public StudentReservationBean insertStudentReservation(StudentReservationBean studentReservationBean)
			throws ReservationException {

		int studentId = studentReservationBean.getStudentID();
		int courseId = studentReservationBean.getCourseID();
		int requestedHours = studentReservationBean.getTotalHours();

		// 檢查是否超過購買時數
		if (!checkHoursLimit(studentId, courseId, requestedHours)) {
			throw new ReservationException("總預約時數超過購買時數");
		}

		// 解析 JSON 字串為時間段列表
		List<String> timeSlotsList;
		try {
			timeSlotsList = JsonUtil.parseTimeSlots(studentReservationBean.getStudentTimeSlots());
		} catch (IOException e) {
			throw new RuntimeException("解析時間段 JSON 失敗", e);
		}
		// 轉換時間段列表為字串
		String studentTimeSlotsString = convertTimeSlotsToString(timeSlotsList.toArray(new String[0]));
		studentReservationBean.setStudentTimeSlots(studentTimeSlotsString);

		// 首先檢查教師行事曆是否開放這些時段
		TeacherScheduleBean teacherScheduleBean = teacherScheduleRepository
				.findById(studentReservationBean.getTeacherScheduleID()).orElseThrow(() -> new ReservationException(
						"教師行事曆不存在，ID: " + studentReservationBean.getTeacherScheduleID(), "TEACHER_SCHEDULE_NOT_FOUND"));

		// 檢查是否所有選擇的時段都開放
		if (!areTimeSlotsAvailable(teacherScheduleBean.getTeacherTimeSlots(), studentTimeSlotsString)) {
			throw new ReservationException("選擇的時段中含有未開放預約的時間，無法完成預約。", "TIME_SLOT_NOT_AVAILABLE");
		}
		// 儲存學生預約資料
		StudentReservationBean savedReservation = studentReservationRepository.save(studentReservationBean);

		// 更新教師行事曆
		updateTeacherScheduleTimeSlots(teacherScheduleBean, studentTimeSlotsString);

		// 更新學生行事曆
		updateStudentSchedule(savedReservation);

		// 創建Zoom會議
		String meetingUrl = createZoomMeeting(savedReservation, teacherScheduleBean);

		// 設置Zoom會議URL
		savedReservation.setZoomMeetingUrl(meetingUrl);

		coiService.updateStatus(studentId, courseId, requestedHours);

		return savedReservation;
	}

	// 創建Zoom會議
	private String createZoomMeeting(StudentReservationBean reservation, TeacherScheduleBean teacherScheduleBean) {
		try {
			// 獲取課程資料
			CourseBean course = courseService.findCourseById(reservation.getCourseID());
			if (course != null) {
				String courseName = course.getCourseName();
				LocalDate courseDate = teacherScheduleBean.getCourseDate();
				String studentTimeSlots = reservation.getStudentTimeSlots();

				// 找到第一個被預約的時間
				int startHour = studentTimeSlots.indexOf('1');
				OffsetDateTime startTime = courseDate.atTime(startHour, 0).atOffset(ZoneOffset.ofHours(8));

				// 呼叫ZoomService創建會議
				String meetingUrl = zoomService.createMeeting(startTime, courseName, 2);
				System.out.println("Zoom meeting URL: " + meetingUrl);
				return meetingUrl;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("創建Zoom會議失敗", e);
		}
		return null;
	}

	// 檢查學生選擇的時段是否全部開放
	private boolean areTimeSlotsAvailable(String teacherTimeSlots, String studentTimeSlots) {
		for (int i = 0; i < studentTimeSlots.length(); i++) {
			if (studentTimeSlots.charAt(i) == '1' && teacherTimeSlots.charAt(i) != '1') {
				return false; // 學生選擇的時段在教師行事曆中不是開放的
			}
		}
		return true;
	}

	// 更新教師行事曆時段
	private void updateTeacherScheduleTimeSlots(TeacherScheduleBean teacherScheduleBean, String studentTimeSlots) {
		String updatedTimeSlots = mergeTimeSlots(teacherScheduleBean.getTeacherTimeSlots(), studentTimeSlots);
		teacherScheduleBean.setTeacherTimeSlots(updatedTimeSlots);
		teacherScheduleRepository.save(teacherScheduleBean);
	}

	// 合併教師和學生的時間段
	private String mergeTimeSlots(String teacherTimeSlots, String studentTimeSlots) {
		StringBuilder updatedTimeSlots = new StringBuilder(teacherTimeSlots);
		for (int i = 0; i < studentTimeSlots.length(); i++) {
			if (studentTimeSlots.charAt(i) == '1') {
				updatedTimeSlots.setCharAt(i, '2'); // 更新為已被預約
			}
		}
		return updatedTimeSlots.toString();
	}

	private void updateStudentSchedule(StudentReservationBean reservation) {
		// 從教師行事曆獲取開課日期
		LocalDate courseDate = teacherScheduleRepository.findById(reservation.getTeacherScheduleID())
				.orElseThrow(() -> new IllegalStateException("教師行事曆數據缺失")).getCourseDate();
		System.out.println("課程日期: " + courseDate); // 有抓到課程日期

		// 檢查是否已有對應的學生行事曆
		Optional<StudentScheduleBean> existingSchedule = studentScheduleRepository
				.findByStudentIDAndCourseDate(reservation.getStudentID(), courseDate);
		System.out.println("查詢新增的學生預約日期在資料表中是否有舊資料: " + existingSchedule);

		// 格式化和準備新的時間段數據
		String newTimeSlotsAll = formatTimeSlotsAll(reservation);

		// 根據是否存在現有記錄進行更新或新增操作
		if (existingSchedule.isPresent()) {
			// 更新已存在的行事曆
			StudentScheduleBean schedule = existingSchedule.get();
			schedule.setStudentTimeSlotsAll(mergeStudentTimeSlots(schedule.getStudentTimeSlotsAll(), newTimeSlotsAll));
			studentScheduleRepository.save(schedule);
			System.out.println("更新資料: " + schedule);
		} else {
			// 新建行事曆條目
			StudentScheduleBean newSchedule = new StudentScheduleBean();
			newSchedule.setStudentID(reservation.getStudentID());
			newSchedule.setStudentCourseDate(courseDate);
			newSchedule.setStudentTimeSlotsAll(newTimeSlotsAll);
			studentScheduleRepository.save(newSchedule);
			System.out.println("全新資料: " + newSchedule);
		}
	}

	private String formatTimeSlotsAll(StudentReservationBean reservation) {
		// 包含預約編號和時段
		String[] timeSlots = new String[24];
		Arrays.fill(timeSlots, "0");
		String studentTimeSlots = reservation.getStudentTimeSlots();
		for (int i = 0; i < studentTimeSlots.length(); i++) {
			if (studentTimeSlots.charAt(i) == '1') {
				timeSlots[i] = String.valueOf(reservation.getStudentReservationID());
			}
		}
		return String.join("-", timeSlots);
	}

	private String mergeStudentTimeSlots(String existingSlots, String newSlots) {
		String[] partsExisting = existingSlots.split("-");
		String[] partsNew = newSlots.split("-");
		StringBuilder merged = new StringBuilder();

		for (int i = 0; i < partsExisting.length; i++) {
			// 如果原始時段為「0」且新時段不為「0」，則使用新的預約ID，否則保留原始時段
			if (partsExisting[i].equals("0") && !partsNew[i].equals("0")) {
				merged.append(partsNew[i]);
			} else {
				merged.append(partsExisting[i]);
			}
			if (i < partsExisting.length - 1) {
				merged.append('-');
			}
		}
		return merged.toString();
	}

	// 轉換時間段數組為時間段字串
	private String convertTimeSlotsToString(String[] timeSlotsArray) {
		String timeSlots = "000000000000000000000000";
		for (String slot : timeSlotsArray) {
			int index = Integer.parseInt(slot.substring(0, slot.indexOf(":")));
			timeSlots = setTimeSlot(timeSlots, index);
		}
		return timeSlots;
	}

	// 標記選定的時段
	private String setTimeSlot(String timeSlots, int index) {
		return timeSlots.substring(0, index) + "1" + timeSlots.substring(index + 1);
	}

	// 根據ID查詢單筆學生預約
	public StudentReservationBean findStudentReservationById(Integer studentReservationID) {
		return studentReservationRepository.findById(studentReservationID).orElse(null);
	}

	// 根據ID查詢單筆教師行事曆
	public TeacherScheduleBean findTeacherScheduleById(int teacherScheduleID) {
		return teacherScheduleRepository.findById(teacherScheduleID).orElse(null);
	}

	// 查詢單名學生所有預約
	public List<StudentReservationBean> getStudentReservationsById(int studentId) {
		return studentReservationRepository.findByStudentID(studentId);
	}

	// 查詢所有學生預約
//	public List<StudentReservationBean> findAllStudentReservations() {
//		return studentReservationRepository.findAll();
//	}

	public List<StudentReservationBean> findAllStudentReservations() {
		List<StudentReservationBean> reservations = studentReservationRepository.findAll();
		System.out.println("All student reservations: " + reservations);
		return reservations;
	}

	// 刪除單筆學生預約並更新相關行事曆
	public void deleteStudentReservationAndUpdateSchedules(Integer studentReservationID) throws Exception {
		StudentReservationBean reservation = studentReservationRepository.findById(studentReservationID)
				.orElseThrow(() -> new IllegalStateException("預約不存在"));

		// 打印預約記錄以檢查Zoom會議URL
		System.out.println("Reservation: " + reservation);

		// 獲取相關的教師行事曆
		TeacherScheduleBean teacherSchedule = teacherScheduleRepository.findById(reservation.getTeacherScheduleID())
				.orElseThrow(() -> new IllegalStateException("教師行事曆不存在"));

		// 更新教師行事曆時段，把已被預約的「2」改為「1」
		updateTeacherScheduleTimeSlotsForCancellation(teacherSchedule, reservation.getStudentTimeSlots());

		// 更新學生行事曆，把預約時段改為「0」
		updateStudentScheduleForCancellation(reservation);

		// 刪除Zoom會議
//		String zoomMeetingUrl = reservation.getZoomMeetingUrl();
//		if (zoomMeetingUrl != null) {
//			zoomService.deleteMeeting(zoomMeetingUrl);
//		}
//		String zoomMeetingUrl = reservation.getZoomMeetingUrl();
//		if (zoomMeetingUrl != null) {
//			System.out.println("Attempting to delete Zoom meeting with URL: " + zoomMeetingUrl);
//			zoomService.deleteMeeting(zoomMeetingUrl);
//		} else {
//			System.out.println("No Zoom meeting URL found for reservation ID: " + studentReservationID);
//		}

		// 刪除學生預約
		studentReservationRepository.deleteById(studentReservationID);
	}

	// 更新教師行事曆時段
	private void updateTeacherScheduleTimeSlotsForCancellation(TeacherScheduleBean teacherSchedule,
			String studentTimeSlots) {
		char[] slots = teacherSchedule.getTeacherTimeSlots().toCharArray();
		for (int i = 0; i < studentTimeSlots.length(); i++) {
			if (studentTimeSlots.charAt(i) == '1') {
				if (slots[i] == '2') {
					slots[i] = '1'; // 預約取消，更新為開放預約
				}
			}
		}
		teacherSchedule.setTeacherTimeSlots(new String(slots));
		teacherScheduleRepository.save(teacherSchedule);
	}

	// 更新學生行事曆
	private void updateStudentScheduleForCancellation(StudentReservationBean reservation) {
		LocalDate courseDate = teacherScheduleRepository.findById(reservation.getTeacherScheduleID())
				.orElseThrow(() -> new IllegalStateException("教師行事曆數據缺失")).getCourseDate();

		StudentScheduleBean studentSchedule = studentScheduleRepository
				.findByStudentIDAndCourseDate(reservation.getStudentID(), courseDate)
				.orElseThrow(() -> new IllegalStateException("學生行事曆不存在"));

		String[] slots = studentSchedule.getStudentTimeSlotsAll().split("-");
		for (int i = 0; i < slots.length; i++) {
			if (slots[i].equals(String.valueOf(reservation.getStudentReservationID()))) {
				slots[i] = "0"; // 預約取消，更新時段為「0」
			}
		}
		studentSchedule.setStudentTimeSlotsAll(String.join("-", slots));
		studentScheduleRepository.save(studentSchedule);
	}

}
