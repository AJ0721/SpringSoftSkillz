package com.softskillz.course.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.softskillz.course.model.CourseBean;
import com.softskillz.course.model.CourseService;

@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private TeacherService teacherService;

	// 新增課程CRUD頁面
	@GetMapping("/insertPage")
	public String courseInsertPage(Model model) {
		List<TeacherBean> teachers = teacherService.findAllTeachers();
		model.addAttribute("teachers", teachers);
		return "/dist/course/courseinsert.jsp";
	}

	// 處理添加課程的請求
	@PostMapping("/add")
	@ResponseBody // 確保返回的是響應體而非視圖名
	public ResponseEntity<?> addCourse(@ModelAttribute CourseBean courseBean) {
		CourseBean newCourse = courseService.insertCourse(courseBean);
		if (newCourse != null && newCourse.getCourseID() != null) {
			return ResponseEntity.ok("課程添加成功");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("課程添加失敗");
		}
	}

	@PostMapping("/update")
	@ResponseBody
	public ResponseEntity<?> updateCourse(@RequestBody CourseBean updatedCourse) {
		try {
			CourseBean existingCourse = courseService.findCourseById(updatedCourse.getCourseID());
			if (existingCourse != null) {
				existingCourse.setCourseCategory(updatedCourse.getCourseCategory());
				existingCourse.setCourseName(updatedCourse.getCourseName());
				existingCourse.setCourseInfo(updatedCourse.getCourseInfo());
				existingCourse.setCoursePrice(updatedCourse.getCoursePrice());
				courseService.updateCourse(existingCourse);
				return ResponseEntity.ok().body("課程更新成功");
			} else {
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body("找不到該課程");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("課程更新失敗: " + e.getMessage());
		}
	}

	// 查詢所有課程的動作
	@GetMapping("/selectAllPage")
	public String selectAllCourses(Model model) {
		List<CourseBean> courses = courseService.findAllCourses();
		model.addAttribute("courses", courses);
		return "/dist/course/courseSelectAll.jsp";
	}

	// 處理刪除課程的請求
	@PostMapping("/deleted")
	@ResponseBody
	public ResponseEntity<?> deleteCourse(@RequestParam("courseID") Integer courseID) {
		try {
			courseService.deleteByCourseId(courseID);
			return ResponseEntity.ok().body("課程刪除成功");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("課程刪除失敗");
		}
	}

}
