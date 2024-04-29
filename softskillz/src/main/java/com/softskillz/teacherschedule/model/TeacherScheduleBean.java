package com.softskillz.teacherschedule.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.TeacherBean;
import com.softskillz.studentreservation.model.StudentReservationBean;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "teacher_schedule")
@Component
public class TeacherScheduleBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "teacher_schedule_id")
	private int teacherScheduleID;

	@Column(name = "teacher_id")
	private int teacherID;

	@Column(name = "course_date")
	private LocalDate courseDate;

	@Column(name = "teacher_time_slots")
	private String teacherTimeSlots;

	@JoinColumn(name = "teacher_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private TeacherBean teacherBean;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "teacherScheduleBean", cascade = CascadeType.ALL)
	private Set<StudentReservationBean> studentReservation = new HashSet<StudentReservationBean>();

	public TeacherScheduleBean() {
	}

	public TeacherScheduleBean(int teacherID, LocalDate courseDate, String teacherTimeSlots, TeacherBean teacherBean) {
		super();
		this.teacherID = teacherID;
		this.courseDate = courseDate;
		this.teacherTimeSlots = teacherTimeSlots;
		this.teacherBean = teacherBean;
	}

	public TeacherScheduleBean(int teacherScheduleID, int teacherID, LocalDate courseDate, String teacherTimeSlots,
			TeacherBean teacherBean) {
		super();
		this.teacherScheduleID = teacherScheduleID;
		this.teacherID = teacherID;
		this.courseDate = courseDate;
		this.teacherTimeSlots = teacherTimeSlots;
		this.teacherBean = teacherBean;
	}

	public int getTeacherScheduleID() {
		return teacherScheduleID;
	}

	public void setTeacherScheduleID(int teacherScheduleID) {
		this.teacherScheduleID = teacherScheduleID;
	}

	public int getTeacherID() {
		return teacherID;
	}

	public void setTeacherID(int teacherID) {
		this.teacherID = teacherID;
	}

	public LocalDate getCourseDate() {
		return courseDate;
	}

	public void setCourseDate(LocalDate courseDate) {
		this.courseDate = courseDate;
	}

	public String getTeacherTimeSlots() {
		return teacherTimeSlots;
	}

	public void setTeacherTimeSlots(String teacherTimeSlots) {
		this.teacherTimeSlots = teacherTimeSlots;
	}

	public TeacherBean getTeacherBean() {
		return teacherBean;
	}

	public void setTeacherBean(TeacherBean teacherBean) {
		this.teacherBean = teacherBean;
	}

	public String getFormattedCourseDate() {
		return this.courseDate != null ? this.courseDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
	}

	public String getTeacherUserName() {
		return this.teacherBean != null ? this.teacherBean.getTeacherUserName() : null;
	}

	public Set<StudentReservationBean> getStudentReservation() {
		return studentReservation;
	}

	public void setStudentReservation(Set<StudentReservationBean> studentReservation) {
		this.studentReservation = studentReservation;
	}

}