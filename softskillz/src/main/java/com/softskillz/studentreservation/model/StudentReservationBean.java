package com.softskillz.studentreservation.model;

import java.io.Serializable;
import java.time.LocalDate;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.course.model.CourseBean;
import com.softskillz.studentschedule.model.StudentScheduleBean;
import com.softskillz.teacherschedule.model.TeacherScheduleBean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "student_reservation")
@Component
public class StudentReservationBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "reservation_id")
	private int studentReservationID;

	@Column(name = "course_id")
	private int courseID;

	@Column(name = "teacher_schedule_id")
	private int teacherScheduleID;

	@Column(name = "reservation_date")
	private LocalDate reservationDate;

	@Column(name = "student_id")
	private int studentID;

	@Column(name = "student_time_slots")
	private String studentTimeSlots;

	@Column(name = "total_hours")
	private int totalHours;

	@JoinColumn(name = "course_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private CourseBean courseBean;

	@JoinColumn(name = "student_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private StudentBean studentBean;

	@JoinColumn(name = "teacher_schedule_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private TeacherScheduleBean teacherScheduleBean;


	public StudentReservationBean() {
	}

//有ID
	public StudentReservationBean(int studentReservationID, int courseID, int teacherScheduleID,
			LocalDate reservationDate, int studentID, String studentTimeSlots, int totalHours, StudentBean studentBean,
			TeacherScheduleBean teacherScheduleBean) {
		super();
		this.studentReservationID = studentReservationID;
		this.courseID = courseID;
		this.teacherScheduleID = teacherScheduleID;
		this.reservationDate = reservationDate;
		this.studentID = studentID;
		this.studentTimeSlots = studentTimeSlots;
		this.totalHours = totalHours;
		this.studentBean = studentBean;
		this.teacherScheduleBean = teacherScheduleBean;
	}

//沒ID
	public StudentReservationBean(int courseID, int teacherScheduleID, LocalDate reservationDate, int studentID,
			String studentTimeSlots, int totalHours, StudentBean studentBean, TeacherScheduleBean teacherScheduleBean) {
		super();
		this.courseID = courseID;
		this.teacherScheduleID = teacherScheduleID;
		this.reservationDate = reservationDate;
		this.studentID = studentID;
		this.studentTimeSlots = studentTimeSlots;
		this.totalHours = totalHours;
		this.studentBean = studentBean;
		this.teacherScheduleBean = teacherScheduleBean;
	}

	public int getStudentReservationID() {
		return studentReservationID;
	}

	public void setStudentReservationID(int studentReservationID) {
		this.studentReservationID = studentReservationID;
	}

	public int getCourseID() {
		return courseID;
	}

	public void setCourseID(int courseID) {
		this.courseID = courseID;
	}

	public int getTeacherScheduleID() {
		return teacherScheduleID;
	}

	public void setTeacherScheduleID(int teacherScheduleID) {
		this.teacherScheduleID = teacherScheduleID;
	}

	public LocalDate getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(LocalDate reservationDate) {
		this.reservationDate = reservationDate;
	}

	public int getStudentID() {
		return studentID;
	}

	public void setStudentID(int studentID) {
		this.studentID = studentID;
	}

	public String getStudentTimeSlots() {
		return studentTimeSlots;
	}

	public void setStudentTimeSlots(String studentTimeSlots) {
		this.studentTimeSlots = studentTimeSlots;
	}

	public int getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(int totalHours) {
		this.totalHours = totalHours;
	}

	public CourseBean getCourseBean() {
		return courseBean;
	}

	public void setCourseBean(CourseBean courseBean) {
		this.courseBean = courseBean;
	}

	public StudentBean getStudentBean() {
		return studentBean;
	}

	public void setStudentBean(StudentBean studentBean) {
		this.studentBean = studentBean;
	}

	public TeacherScheduleBean getTeacherScheduleBean() {
		return teacherScheduleBean;
	}

	public void setTeacherScheduleBean(TeacherScheduleBean teacherScheduleBean) {
		this.teacherScheduleBean = teacherScheduleBean;
	}
}