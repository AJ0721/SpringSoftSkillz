package com.softskillz.teacherschedule.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	// 教師行事曆CRUD頁面
	@GetMapping("/teacherSchedulePage/teacherScheduleAllPage")
	public String teacherScheduleAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleAllPage.jsp";
	}

	// 根據教師編號及開課日期查詢單筆教師行事曆的頁面
	@GetMapping("/select")
	public String selectTeacherSchedulePage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleSelect.jsp";
	}

	@GetMapping("/oneTeacherSchedule")
	public String getTeacherSchedule(@RequestParam("teacherID") int teacherID,
			@RequestParam("courseDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate courseDate,
			Model model) {
		TeacherScheduleBean schedule = teacherScheduleService.getTeacherSchedule(teacherID, courseDate);
		model.addAttribute("teacherSchedule", schedule);
		return "teacherSchedule/teacherSchedulePage/TeacherScheduleSelectSuccessed.jsp"; // 指向查詢成功的頁面
	}

	// 根據教師編號查詢該教師所有行事曆的頁面
	@GetMapping("/selectAll")
	public String selectAllTeacherSchedulePage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleSelectAll.jsp";
	}

	@GetMapping("/allSchedules")
	public String getTeacherSchedules(@RequestParam("teacherID") int teacherID, Model model) {
		List<TeacherScheduleBean> schedules = teacherScheduleService.getTeacherSchedulesById(teacherID);
		model.addAttribute("teacherSchedules", schedules);
		return "teacherSchedule/teacherSchedulePage/TeacherScheduleSelectAllById.jsp";
	}

	// 新增課程的頁面
	@PostMapping("/insert")
	public String insertTeacherSchedulePage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleInsert.jsp";
	}

	@GetMapping("/check")
	@ResponseBody
	public String checkDuplicate(@RequestParam("teacherID") int teacherID,
			@RequestParam("courseDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate courseDate) {
		boolean exists = teacherScheduleService.existsByTeacherIDAndCourseDate(teacherID, courseDate);
		return String.valueOf(exists);
	}

	@PostMapping("/add")
	public String addTeacherSchedule(@ModelAttribute TeacherScheduleBean teacherScheduleBean,
			RedirectAttributes redirectAttributes) throws Exception {
		TeacherScheduleBean newTeacherSchedule = teacherScheduleService.insertTeacherSchedule(teacherScheduleBean);
		if (newTeacherSchedule != null && newTeacherSchedule.getTeacherScheduleID() > 0) {
			redirectAttributes.addFlashAttribute("message", "教師行事曆新增成功");
		} else {
			redirectAttributes.addFlashAttribute("error", "教師行事曆新增失敗");
		}
		return "/teacherSchedule/teacherSchedulePage/TeacherScheduleInsertSuccessed.jsp"; // 這裡填寫成功頁面的路徑
	}

	// 刪除課程的頁面
	@PostMapping("/delete")
	public String deleteTeacherSchedulePage(Model model) {
		List<TeacherScheduleBean> teacherSchedules = teacherScheduleService.findAllTeacherSchedules();
		model.addAttribute("teacherSchedules", teacherSchedules);
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleDelete.jsp";
	}

	// 處理刪除課程的請求
	@PostMapping("/deleted")
	public String deleteTeacherSchedule(@RequestParam("teacherScheduleID") Integer teacherScheduleID,
			RedirectAttributes redirectAttributes) {
		teacherScheduleService.deleteByTeacherScheduleId(teacherScheduleID);
		redirectAttributes.addFlashAttribute("message", "課程刪除成功");
		return "/teacherSchedule/teacherSchedulePage/TeacherScheduleDeleteSuccessed.jsp";
	}

	// 更新課程的頁面
	@PostMapping("/update")
	public String updateTeacherSchedulePage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/teacherSchedule/teacherSchedulePage/teacherScheduleUpdate.jsp";
	}

	@GetMapping("/selectUpdate")
	public String teacherScheduleSelectUpdate(@RequestParam("teacherID") int teacherID,
			@RequestParam("courseDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate courseDate,
			Model model) {
		TeacherScheduleBean schedule = teacherScheduleService.getTeacherSchedule(teacherID, courseDate);
		model.addAttribute("teacherSchedule", schedule);
		return "teacherSchedule/teacherSchedulePage/TeacherScheduleEdit.jsp"; // 指向查詢修改頁面
	}

	@PostMapping("/updated")
	public String updateTeacherSchedule(@ModelAttribute TeacherScheduleBean teacherScheduleBean,
			RedirectAttributes redirectAttributes) {
		TeacherScheduleBean newTeacherSchedule = teacherScheduleService.updateTeacherSchedule(teacherScheduleBean);
		if (newTeacherSchedule != null && newTeacherSchedule.getTeacherScheduleID() > 0) {
			redirectAttributes.addFlashAttribute("message", "教師行事曆修改成功");
		} else {
			redirectAttributes.addFlashAttribute("error", "教師行事曆修改失敗");
		}
		return "/teacherSchedule/teacherSchedulePage/TeacherScheduleUpdateSuccessed.jsp"; // 這裡填寫成功頁面的路徑
	}
}