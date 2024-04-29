package com.softskillz.course.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.service.TeacherService;
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;

@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherService teacherService;

	// 課程CRUD頁面
	@GetMapping("/coursePage/courseAllPage")
	public String courseAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/course/coursePage/courseAllPage.jsp";
	}

	// 根據ID查詢單筆課程的頁面
	@GetMapping("/select")
	public String selectCoursePage(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);
		return "/course/coursePage/courseSelect.jsp";
	}

	// 根據ID查詢一門課程
	@GetMapping("/onecourse")
	public String getCourse(@RequestParam("courseID") Integer courseId, Model model) {
		CourseBean courseBean = courseService.findCourseById(courseId);
		model.addAttribute("course", courseBean);
		return "/course/coursePage/courseSelectSuccessed.jsp"; // 對應到課程詳情的頁面
	}
	// 查詢所有課程的動作
	@GetMapping("/selectAll")
	public String selectAllCourses(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);
		return "/course/coursePage/CourseSelectAll.jsp";
	}

	// 新增課程的頁面
	@PostMapping("/insert")
	public String insertCoursePage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/course/coursePage/courseInsert.jsp";
	}

	// 處理添加課程的請求
	@PostMapping("/add")
	public String addCourse(@ModelAttribute CourseBean courseBean, RedirectAttributes redirectAttributes) {
		CourseBean newCourse = courseService.insertCourse(courseBean);
		if (newCourse != null && newCourse.getCourseID() != null) {
			redirectAttributes.addFlashAttribute("message", "課程添加成功");
		} else {
			redirectAttributes.addFlashAttribute("error", "課程添加失敗");
		}
		return "/course/coursePage/CourseInsertSuccessed.jsp"; // 新增課程成功的頁面
	}

	// 刪除課程的頁面
	@PostMapping("/delete")
	public String deleteCoursePage(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);
		return "/course/coursePage/courseDelete.jsp";
	}

	// 處理刪除課程的請求
	@PostMapping("/deleted")
	public String deleteCourse(@RequestParam("courseID") Integer courseID, RedirectAttributes redirectAttributes) {
//		CourseBean courseBean = new CourseBean();
//		courseBean.setCourseID(courseID);
		courseService.deleteByCourseId(courseID);
		redirectAttributes.addFlashAttribute("message", "課程刪除成功");
		return "/course/coursePage/CourseDeleteSuccessed.jsp";
	}

	// 更新課程的頁面
	@PostMapping("/update")
	public String updateCoursePage(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/course/coursePage/courseUpdate.jsp";
	}

	// 處理更新課程的請求
	@PostMapping("/updated")
	public String updateCourse(@ModelAttribute CourseBean courseBean, RedirectAttributes redirectAttributes) {
		CourseBean updatedCourse = courseService.updateCourse(courseBean);
		if (updatedCourse != null) {
			redirectAttributes.addFlashAttribute("message", "課程更新成功");
		} else {
			redirectAttributes.addFlashAttribute("error", "課程更新失敗");
		}
		return "/course/coursePage/CourseUpdateSuccessed.jsp";
	}
}
