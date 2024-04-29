package com.softskillz.teacherschedule.model;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TeacherScheduleService {

	@Autowired
	private TeacherScheduleRepository teacherScheduleRepository;

	private ObjectMapper objectMapper = new ObjectMapper();

	// 檢查是否存在相同教師編號和課程日期的行事曆
	public boolean existsByTeacherIDAndCourseDate(int teacherID, LocalDate courseDate) {
		return teacherScheduleRepository.findByTeacherIDAndCourseDate(teacherID, courseDate).size() > 0;
	}

	// 新增教師行事曆
	public TeacherScheduleBean insertTeacherSchedule(TeacherScheduleBean teacherScheduleBean) throws Exception {
		if (existsByTeacherIDAndCourseDate(teacherScheduleBean.getTeacherID(), teacherScheduleBean.getCourseDate())) {
			throw new Exception("該教師的行事曆在此日期已存在，請修改現有行事曆。");
		}
		// 解析 JSON 字串為時間段列表
		List<String> timeSlotsList;
		try {
			timeSlotsList = objectMapper.readValue(teacherScheduleBean.getTeacherTimeSlots(),
					new TypeReference<List<String>>() {
					});
		} catch (IOException e) {
			throw new RuntimeException("解析時間段 JSON 失敗", e);
		}

		// 轉換時間段列表為字串
		String timeSlotsString = convertTimeSlotsToString(timeSlotsList.toArray(new String[0]));
		teacherScheduleBean.setTeacherTimeSlots(timeSlotsString);

		return teacherScheduleRepository.save(teacherScheduleBean);
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

	// 用教師編號、課程日期查詢單筆教師行事曆
	public TeacherScheduleBean getTeacherSchedule(int teacherID, LocalDate courseDate) {
		return teacherScheduleRepository.findByTeacherIDAndCourseDate(teacherID, courseDate).stream().findFirst()
				.orElse(null); // 使用 Java Stream API 取代 if 判斷式
	}

	// 根據ID查詢單筆教師行事曆
	public TeacherScheduleBean findTeacherScheduleById(Integer teacherScheduleID) {
		return teacherScheduleRepository.findById(teacherScheduleID).orElse(null);
	}

	// 查詢單名教師所有行事曆
	public List<TeacherScheduleBean> getTeacherSchedulesById(int teacherID) {
		return teacherScheduleRepository.findByTeacherID(teacherID);
	}

	// 查詢所有行事曆
	public List<TeacherScheduleBean> findAllTeacherSchedules() {
		return teacherScheduleRepository.findAll();
	}

	// 刪除單筆教師行事曆
	public void deleteByTeacherScheduleId(Integer teacherScheduleID) {
		teacherScheduleRepository.deleteById(teacherScheduleID);
	}

	// 修改單筆教師行事曆
	public TeacherScheduleBean updateTeacherSchedule(TeacherScheduleBean teacherScheduleBean) {
		// 解析 JSON 字串為時間段列表
		List<String> timeSlotsList;
		try {
			timeSlotsList = objectMapper.readValue(teacherScheduleBean.getTeacherTimeSlots(),
					new TypeReference<List<String>>() {
					});
		} catch (IOException e) {
			throw new RuntimeException("解析時間段 JSON 失敗", e);
		}

		// 轉換時間段列表為字串
		String timeSlotsString = convertTimeSlotsToString(timeSlotsList.toArray(new String[0]));
		teacherScheduleBean.setTeacherTimeSlots(timeSlotsString);

		return teacherScheduleRepository.save(teacherScheduleBean);
	}
}