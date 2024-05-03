package com.softskillz.studentschedule.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.studentreservation.model.StudentReservationBean;

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
@Table(name = "student_schedule")
@Component
public class StudentScheduleBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "student_schedule_id")
	private int studentScheduleID;

	@Column(name = "student_id")
	private int studentID;

	@Column(name = "student_course_date")
	private LocalDate studentCourseDate;

	@Column(name = "student_time_slots_all")
	private String studentTimeSlotsAll;

	@JoinColumn(name = "student_id", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private StudentBean studentBean;

	@OneToMany(mappedBy = "studentScheduleBean", fetch = FetchType.LAZY)
	private Set<StudentReservationBean> reservations = new HashSet<>();

	public StudentScheduleBean() {
	}

	// 有id
	public StudentScheduleBean(int studentScheduleID, int studentID, LocalDate studentCourseDate,
			String studentTimeSlotsAll, StudentBean studentBean, Set<StudentReservationBean> reservations) {
		super();
		this.studentScheduleID = studentScheduleID;
		this.studentID = studentID;
		this.studentCourseDate = studentCourseDate;
		this.studentTimeSlotsAll = studentTimeSlotsAll;
		this.studentBean = studentBean;
		this.reservations = reservations;
	}

	// 沒id
	public StudentScheduleBean(int studentID, LocalDate studentCourseDate, String studentTimeSlotsAll,
			StudentBean studentBean, Set<StudentReservationBean> reservations) {
		super();
		this.studentID = studentID;
		this.studentCourseDate = studentCourseDate;
		this.studentTimeSlotsAll = studentTimeSlotsAll;
		this.studentBean = studentBean;
		this.reservations = reservations;
	}

	// getter setter
	public int getStudentScheduleID() {
		return studentScheduleID;
	}

	public void setStudentScheduleID(int studentScheduleID) {
		this.studentScheduleID = studentScheduleID;
	}

	public int getStudentID() {
		return studentID;
	}

	public void setStudentID(int studentID) {
		this.studentID = studentID;
	}

	public LocalDate getStudentCourseDate() {
		return studentCourseDate;
	}

	public void setStudentCourseDate(LocalDate studentCourseDate) {
		this.studentCourseDate = studentCourseDate;
	}

	public String getStudentTimeSlotsAll() {
		return studentTimeSlotsAll;
	}

	public void setStudentTimeSlotsAll(String studentTimeSlotsAll) {
		this.studentTimeSlotsAll = studentTimeSlotsAll;
	}

	public StudentBean getStudentBean() {
		return studentBean;
	}

	public void setStudentBean(StudentBean studentBean) {
		this.studentBean = studentBean;
	}

	public Set<StudentReservationBean> getReservations() {
		return reservations;
	}

	public void setReservations(Set<StudentReservationBean> reservations) {
		this.reservations = reservations;
	}

	@Override
	public String toString() {
		return "StudentScheduleBean [studentScheduleID=" + studentScheduleID + ", studentID=" + studentID
				+ ", studentTimeSlotsAll=" + studentTimeSlotsAll + ", studentBean=" + studentBean + ", reservations="
				+ reservations + "]";
	}

	// 測試用 測完關掉
	public void setCourseDate(LocalDate now) {
		// TODO Auto-generated method stub

	}

	// 測試用 測完關掉
	public Object[] getCourseDate() {
		// TODO Auto-generated method stub
		return null;
	}
}
