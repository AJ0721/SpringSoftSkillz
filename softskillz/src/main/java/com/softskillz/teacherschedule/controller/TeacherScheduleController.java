package com.softskillz.teacherschedule.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.TeacherService;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleService;

@Controller
@RequestMapping("/teacherSchedule")
public class TeacherScheduleController {

	@Autowired
	private TeacherScheduleService teacherScheduleService;

	@Autowired
	private TeacherService teacherService;

	// 模版新增教師行事曆CRUD頁面
	@GetMapping("/insertPage")
	public String teacherScheduleInsertPage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/dist/teacherSchedule/teacherScheduleInsert.jsp";
	}

	@GetMapping("/check")
	@ResponseBody
	public String checkDuplicate(@RequestParam("teacherID") int teacherID,
			@RequestParam("courseDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate courseDate) {
		boolean exists = teacherScheduleService.existsByTeacherIDAndCourseDate(teacherID, courseDate);
		return String.valueOf(exists);
	}

	@PostMapping("/add")
	@ResponseBody // 標記為返回響應體
	public ResponseEntity<?> addTeacherSchedule(@ModelAttribute TeacherScheduleBean teacherScheduleBean) {
		try {
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

	// 根據教師編號查詢該教師所有行事曆的頁面
	@GetMapping("/selectAllPage")
	public String selectAllTeacherSchedules(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/dist/teacherSchedule/teacherScheduleSelect.jsp";
	}

	@GetMapping("/allSchedules")
	public String getTeacherSchedules(@RequestParam("teacherID") int teacherID, Model model) {
		List<TeacherScheduleBean> schedules = teacherScheduleService.getTeacherSchedulesById(teacherID);
		model.addAttribute("teacherSchedules", schedules);
		return "/dist/teacherSchedule/teacherScheduleSelectAll.jsp";
	}

	// 處理刪除教師行事曆的請求
	@PostMapping("/deleted")
	@ResponseBody
	public ResponseEntity<?> deleteTeacherSchedule(@RequestParam("teacherScheduleID") Integer teacherScheduleID) {
		try {
			teacherScheduleService.deleteByTeacherScheduleId(teacherScheduleID);
			return ResponseEntity.ok().body("行事曆刪除成功");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("行事曆刪除失敗");
		}
	}

	// 查詢教師行事曆
	@GetMapping("/update")
	public ResponseEntity<?> getTeacherSchedule(@RequestParam("teacherScheduleID") int teacherScheduleID) {
		try {
			TeacherScheduleBean schedule = teacherScheduleService.findTeacherScheduleById(teacherScheduleID);
			return ResponseEntity.ok(schedule);
		} catch (Exception e) {
			return ResponseEntity.internalServerError().body("查詢教師行事曆時發生錯誤: " + e.getMessage());
		}
	}

	// 更新教師行事曆
	@PostMapping("/updated")
	public ResponseEntity<?> updateTeacherSchedule(@RequestBody TeacherScheduleBean teacherScheduleBean) {
		System.out.println(teacherScheduleBean.getTeacherScheduleID());
		try {
			TeacherScheduleBean updatedSchedule = teacherScheduleService.updateTeacherSchedule(teacherScheduleBean);
			if (updatedSchedule != null && updatedSchedule.getTeacherScheduleID() != 0) {
				return ResponseEntity.ok("教師行事曆修改成功");
			} else {
				return ResponseEntity.badRequest().body("教師行事曆修改失敗");
			}
		} catch (Exception e) {
			return ResponseEntity.internalServerError().body("教師行事曆修改過程中發生錯誤: " + e.getMessage());
		}
	}

}