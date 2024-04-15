package com.softskillz.course.controller;

import com.softskillz.course.model.CourseDTO;
import com.softskillz.course.model.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	private CourseService courseService;

	// 課程CRUD頁面
	@GetMapping("/coursePage/courseAllPage")
	public String courseAllPage() {
		// 在這裡添加任何需要的模型屬性
		return "/course/coursePage/courseAllPage";
	}

	// 根據ID查詢單筆課程的頁面
	@GetMapping("/select")
	public String selectCoursePage() {
		return "/course/coursePage/courseSelect";
	}

	// 根據ID查詢一門課程
	@GetMapping("/onecourse")
	public String getCourse(@RequestParam("course_id") Integer courseId, Model model) {
		CourseDTO courseDTO = courseService.findByCourseId(courseId);
		model.addAttribute("course", courseDTO);
		return "/course/coursePage/courseSelectSuccessed"; // 對應到課程詳情的頁面
	}

	// 查詢所有課程的動作，假設是一個POST請求處理
	@GetMapping("/selectAll")
	public String selectAllCourses(Model model) {
		List<CourseDTO> courses = courseService.findAll();
		model.addAttribute("courses", courses);
		return "/course/coursePage/CourseSelectAll";
	}

	// 新增課程的頁面
	@PostMapping("/insert")
	public String insertCoursePage() {
		return "/course/coursePage/courseInsert";
	}

	// 處理添加課程的請求
	@PostMapping("/add")
	public String addCourse(@ModelAttribute CourseDTO courseDTO, RedirectAttributes redirectAttributes) {
		CourseDTO newCourse = courseService.insertCourse(courseDTO);
		if (newCourse != null && newCourse.getCourseID() != null) {
			// 假設 addCourse 方法設計為在成功添加課程後返回該課程的DTO，並包含由資料庫生成的ID
			redirectAttributes.addFlashAttribute("message", "課程添加成功");
		} else {
			// 如果課程沒有成功添加，或者addCourse方法的實現不是這樣設計的
			redirectAttributes.addFlashAttribute("error", "課程添加失敗");
		}
		return "/course/coursePage/CourseInsertSuccessed"; // 新增課程成功的頁面
	}

	// 刪除課程的頁面
	@PostMapping("/delete")
	public String deleteCoursePage() {
		return "/course/coursePage/courseDelete";
	}

	// 處理刪除課程的請求
	@PostMapping("/deleted")
	public String deleteCourse(@RequestParam("courseID") Integer courseId, RedirectAttributes redirectAttributes) {
		CourseDTO courseDTO = new CourseDTO();
		courseDTO.setCourseID(courseId);
		courseService.deleteByCourseId(courseDTO);
		redirectAttributes.addFlashAttribute("message", "課程刪除成功");
		return "/course/coursePage/CourseDeleteSuccessed";
	}

	// 更新課程的頁面
	@PostMapping("/update")
	public String updateCoursePage() {
		return "/course/coursePage/courseUpdate";
	}

	// 處理更新課程的請求
	@PostMapping("/updated")
	public String updateCourse(@ModelAttribute CourseDTO courseDTO, RedirectAttributes redirectAttributes) {
		courseService.updateCourse(courseDTO);
		redirectAttributes.addFlashAttribute("message", "課程更新成功");
		return "/course/coursePage/CourseUpdateSuccessed"; // 重定向到所有課程的列表頁面
	}

}
