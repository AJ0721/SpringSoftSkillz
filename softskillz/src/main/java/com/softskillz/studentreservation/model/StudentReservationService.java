package com.softskillz.studentreservation.model;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.studentschedule.model.StudentScheduleBean;
import com.softskillz.studentschedule.model.StudentScheduleRepository;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleRepository;

@Service
@Transactional
public class StudentReservationService {

	@Autowired
	private StudentReservationRepository studentReservationRepository;

	@Autowired
	private StudentScheduleRepository studentScheduleRepository;

	@Autowired
	private TeacherScheduleRepository teacherScheduleRepository;

	private ObjectMapper objectMapper = new ObjectMapper();

	// 新增學生預約
	public StudentReservationBean insertStudentReservation(StudentReservationBean studentReservationBean)
			throws ReservationException {

		// 解析 JSON 字串為時間段列表
		List<String> timeSlotsList;
		try {
			timeSlotsList = objectMapper.readValue(studentReservationBean.getStudentTimeSlots(),
					new TypeReference<List<String>>() {
					});
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

		return savedReservation;
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
		System.out.println("課程日期" + courseDate);// 有抓到課程日期

		// 檢查是否已有對應的學生行事曆
		Optional<StudentScheduleBean> existingSchedule = studentScheduleRepository
				.findByStudentIDAndCourseDate(reservation.getStudentID(), courseDate);
		System.out.println("查詢新增的學生預約日期在有沒有資料表有沒有舊資料" + existingSchedule);
		// 格式化和準備新的時間段數據
		String newTimeSlotsAll = formatTimeSlotsAll(reservation);

		// 根據是否存在現有記錄進行更新或新增操作
		if (existingSchedule.isPresent()) {
			// 更新已存在的行事曆
			StudentScheduleBean schedule = existingSchedule.get();
			schedule.setStudentTimeSlotsAll(mergeStudentTimeSlots(schedule.getStudentTimeSlotsAll(), newTimeSlotsAll));
			studentScheduleRepository.save(schedule);
			System.out.println("更新資料" + schedule);
		} else {
			// 新建行事曆條目
			StudentScheduleBean newSchedule = new StudentScheduleBean();
			newSchedule.setStudentID(reservation.getStudentID());
			newSchedule.setStudentCourseDate(courseDate);
			newSchedule.setStudentTimeSlotsAll(newTimeSlotsAll);
			studentScheduleRepository.save(newSchedule);
			System.out.println("全新資料" + newSchedule);
		}
	}

	private String formatTimeSlotsAll(StudentReservationBean reservation) {
		// 這裡需要改寫以包含預約編號和時段
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

	// 根據ID查詢單筆教師行事曆
	public StudentReservationBean findStudentReservationById(Integer studentReservationID) {
		return studentReservationRepository.findById(studentReservationID).orElse(null);
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

	// 刪除單筆學生預約
	public void deleteByStudentReservationId(Integer studentReservationID) {
		studentReservationRepository.deleteById(studentReservationID);
	}
}
