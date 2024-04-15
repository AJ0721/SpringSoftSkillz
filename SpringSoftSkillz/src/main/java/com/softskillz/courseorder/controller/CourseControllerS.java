package com.softskillz.courseorder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.softskillz.courseorder.model.bean.Course2;
import com.softskillz.courseorder.model.service.CourseServiceInterface;

@Controller
@SessionAttributes(names = { "course" })
public class CourseControllerS {

	@Autowired
	private CourseServiceInterface service; 
	
	@GetMapping("/course.do")
	public String pocessAction() {
		return "courseorder/html/index";
	}
	
	@GetMapping("/CourseSelect")
	@ResponseBody
	public List<Course2> selectCourse(){
		return service.selectCourse();
	}
	
	@GetMapping("/CourseDetail.do")
	public String doCourseDetail(@RequestParam("courseID") String courseID, Model m) {
		System.out.println(courseID);
		Course2 course = service.selectCourseByID(Integer.parseInt(courseID));
		m.addAttribute("course", course);
		return "courseorder/jsp/CourseDetail";

	}

}
