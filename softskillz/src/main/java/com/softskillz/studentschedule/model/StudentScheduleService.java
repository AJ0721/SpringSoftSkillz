package com.softskillz.studentschedule.model;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.studentreservation.model.StudentReservationBean;
import com.softskillz.studentreservation.model.StudentReservationService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleRepository;

@Service
@Transactional
public class StudentScheduleService {

	@Autowired
	private StudentScheduleRepository studentScheduleRepository;

	// 示例方法，用於在應用中直接測試studentScheduleRepository.findByStudentIDAndCourseDate()
	public void testFindByStudentIDAndCourseDate(int studentID, LocalDate courseDate) {
		Optional<StudentScheduleBean> result = studentScheduleRepository.findByStudentIDAndCourseDate(studentID,
				courseDate);
		if (result.isPresent()) {
			System.out.println("找到學生行事曆: " + result.get());
		} else {
			System.out.println("未找到對應的學生行事曆");
		}
	}

//	@Autowired
//	private StudentReservationService studentReservationService;
//
//	@Autowired
//	private TeacherScheduleRepository teacherScheduleRepository;
//
//	// 更新或新增學生行事曆條目
//	public void updateOrCreateStudentSchedule(int studentId, String studentTimeSlotsAll) {
//		String[] reservationIds = parseReservationIds(studentTimeSlotsAll);
//		for (String reservationId : reservationIds) {
//			if (!reservationId.equals("0")) {
//				StudentReservationBean reservation = studentReservationService
//						.findStudentReservationById(Integer.parseInt(reservationId));
//				TeacherScheduleBean teacherSchedule = teacherScheduleRepository
//						.findById(reservation.getTeacherScheduleID())
//						.orElseThrow(() -> new IllegalStateException("教師行事曆不存在"));
//
//				LocalDate courseDate = teacherSchedule.getCourseDate();
//				Optional<StudentScheduleBean> existingSchedule = studentScheduleRepository
//						.findByStudentIDAndCourseDate(studentId, courseDate);
//
//				if (existingSchedule.isPresent()) {
//					updateExistingSchedule(existingSchedule.get(), reservationId);
//				} else {
//					createNewSchedule(studentId, courseDate, reservationId);
//				}
//			}
//		}
//	}
//
//	// 解析 student_time_slots_all 字段以找到所有 reservation_id
//	private String[] parseReservationIds(String slotsAll) {
//		return slotsAll.split("-");
//	}
//
//	// 更新現有的學生行事曆條目
//	private void updateExistingSchedule(StudentScheduleBean schedule, String reservationId) {
//		// 更新邏輯，例如合併時段數據等
//	}
//
//	// 創建新的學生行事曆條目
//	private void createNewSchedule(int studentId, LocalDate courseDate, String reservationId) {
//		StudentScheduleBean newSchedule = new StudentScheduleBean();
//		newSchedule.setStudentID(studentId);
//		newSchedule.setStudentTimeSlotsAll(formatInitialTimeSlots(reservationId));
//		studentScheduleRepository.save(newSchedule);
//	}
//
//	// 格式化新建學生行事曆的初始時段數據
//	private String formatInitialTimeSlots(String reservationId) {
//		// 格式化邏輯
//		return "formatted_time_slots";
//	}
}
// 查詢學生行事曆

// 查詢該學生所有行事曆

// 刪除學生行事曆

// 修改學生行事曆
