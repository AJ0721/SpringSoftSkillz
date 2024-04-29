package com.softskillz.studentreservation.model;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleRepository;

@Service
@Transactional
public class StudentReservationService {

	@Autowired
	private StudentReservationRepository studentReservationRepository;

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

		return savedReservation;
		// return studentReservationRepository.save(studentReservationBean);
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
	public List<StudentReservationBean> findAllStudentReservations() {
		return studentReservationRepository.findAll();
	}

	// 刪除單筆學生預約
	public void deleteByStudentReservationId(Integer studentReservationID) {
		studentReservationRepository.deleteById(studentReservationID);
	}
	
}
