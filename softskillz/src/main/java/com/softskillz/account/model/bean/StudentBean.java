package com.softskillz.account.model.bean;

import java.util.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.softskillz.companion.model.CompanionBean;
import com.softskillz.forum.model.model.ForumThreadModel;
import com.softskillz.studentreservation.model.StudentReservationBean;
import com.softskillz.studentschedule.model.StudentScheduleBean;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "student")
@Component
public class StudentBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "student_id")
	private Integer studentId;

	@Column(name = "student_first_name")
	private String studentFirstName;

	@Column(name = "student_last_name")
	private String studentLastName;

	@Column(name = "student_username")
	private String studentUsername;

	@Column(name = "student_nickname")
	private String studentNickname;

	@Column(name = "student_registration_date")
	private Date studentRegistrationDate;

	@Column(name = "student_gender")
	private String studentGender;

	@Column(name = "student_birth")
	private Date studentBirth;

	@Column(name = "student_mobile")
	private String studentMobile;

	@Column(name = "student_email")
	private String studentEmail;

	@Column(name = "student_password")
	private String studentPassword;

	@Column(name = "student_country")
	private String studentCountry;

	@Column(name = "student_photo")
	private String studentPhoto;

	@Column(name = "student_education")
	private String studentEducation;

	@Column(name = "student_forum_status")
	private Integer studentForumStatus;

	@Column(name = "student_course_status")
	private Integer studentCourseStatus;

	@Column(name = "first_language")
	private String firstLanguage;

	@Column(name = "learning_frequency")
	private String learningFrequency;

//	@Transient
	@Column(name = "student_id_formatted",insertable = false,updatable = false)
	private String studentIdFormatted;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "studentBean", cascade = CascadeType.ALL)
	@JsonManagedReference("student-studentReservation")
	private Set<StudentReservationBean> studentReservation = new HashSet<StudentReservationBean>();
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "studentBean", cascade = CascadeType.ALL)
	@JsonManagedReference("student-studentSchedule")
	private Set<StudentScheduleBean> studentSchedule = new HashSet<StudentScheduleBean>();

	//任萱forum
	@OneToMany (mappedBy = "studentBean",cascade=CascadeType.ALL)
	private List<ForumThreadModel> threads= new ArrayList<>();
	
	public List<ForumThreadModel> getThreads() {
		return threads;
	}

	public void setThreads(List<ForumThreadModel> threads) {
		this.threads = threads;
	}
	
	//京田compainon
	@OneToOne (mappedBy = "studentBeanID")
	private CompanionBean companionBean;
	
	public CompanionBean getCompanionBean() {
		return companionBean;
	}

	public void setCompanionBean(CompanionBean companionBean) {
		this.companionBean = companionBean;
	}
	
	
	public StudentBean() {
	}

	// 有studentId
	public StudentBean(Integer studentId, String studentFirstName, String studentLastName, String studentUsername,
			String studentNickname, Date studentRegistrationDate, String studentGender, Date studentBirth,
			String studentMobile, String studentEmail, String studentPassword, String studentCountry,
			String studentPhoto, String studentEducation, Integer studentForumStatus, Integer studentCourseStatus,
			String firstLanguage, String learningFrequency, String studentIdFormatted) {
		super();
		this.studentId = studentId;
		this.studentFirstName = studentFirstName;
		this.studentLastName = studentLastName;
		this.studentUsername = studentUsername;
		this.studentNickname = studentNickname;
		this.studentRegistrationDate = studentRegistrationDate;
		this.studentGender = studentGender;
		this.studentBirth = studentBirth;
		this.studentMobile = studentMobile;
		this.studentEmail = studentEmail;
		this.studentPassword = studentPassword;
		this.studentCountry = studentCountry;
		this.studentPhoto = studentPhoto;
		this.studentEducation = studentEducation;
		this.studentForumStatus = studentForumStatus;
		this.studentCourseStatus = studentCourseStatus;
		this.firstLanguage = firstLanguage;
		this.learningFrequency = learningFrequency;
		this.studentIdFormatted = studentIdFormatted;
	}

	// 沒有studentId
	public StudentBean(String studentFirstName, String studentLastName, String studentUsername, String studentNickname,
			Date studentRegistrationDate, String studentGender, Date studentBirth, String studentMobile,
			String studentEmail, String studentPassword, String studentCountry, String studentPhoto,
			String studentEducation, Integer studentForumStatus, Integer studentCourseStatus, String firstLanguage,
			String learningFrequency, String studentIdFormatted) {
		this.studentFirstName = studentFirstName;
		this.studentLastName = studentLastName;
		this.studentUsername = studentUsername;
		this.studentNickname = studentNickname;
		this.studentRegistrationDate = studentRegistrationDate;
		this.studentGender = studentGender;
		this.studentBirth = studentBirth;
		this.studentMobile = studentMobile;
		this.studentEmail = studentEmail;
		this.studentPassword = studentPassword;
		this.studentCountry = studentCountry;
		this.studentPhoto = studentPhoto;
		this.studentEducation = studentEducation;
		this.studentForumStatus = studentForumStatus;
		this.studentCourseStatus = studentCourseStatus;
		this.firstLanguage = firstLanguage;
		this.learningFrequency = learningFrequency;
		this.studentIdFormatted = studentIdFormatted;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public String getStudentFirstName() {
		return studentFirstName;
	}

	public void setStudentFirstName(String studentFirstName) {
		this.studentFirstName = studentFirstName;
	}

	public String getStudentLastName() {
		return studentLastName;
	}

	public void setStudentLastName(String studentLastName) {
		this.studentLastName = studentLastName;
	}

	public String getStudentUsername() {
		return studentUsername;
	}

	public void setStudentUsername(String studentUsername) {
		this.studentUsername = studentUsername;
	}

	public String getStudentNickname() {
		return studentNickname;
	}

	public void setStudentNickname(String studentNickname) {
		this.studentNickname = studentNickname;
	}

	public Date getStudentRegistrationDate() {
		return studentRegistrationDate;
	}

	public void setStudentRegistrationDate(Date studentRegistrationDate) {
		this.studentRegistrationDate = studentRegistrationDate;
	}

	public String getStudentGender() {
		return studentGender;
	}

	public void setStudentGender(String studentGender) {
		this.studentGender = studentGender;
	}

	public Date getStudentBirth() {
		return studentBirth;
	}

	public void setStudentBirth(Date studentBirth) {
		this.studentBirth = studentBirth;
	}

	public String getStudentMobile() {
		return studentMobile;
	}

	public void setStudentMobile(String studentMobile) {
		this.studentMobile = studentMobile;
	}

	public String getStudentEmail() {
		return studentEmail;
	}

	public void setStudentEmail(String studentEmail) {
		this.studentEmail = studentEmail;
	}

	public String getStudentPassword() {
		return studentPassword;
	}

	public void setStudentPassword(String studentPassword) {
		this.studentPassword = studentPassword;
	}

	public String getStudentCountry() {
		return studentCountry;
	}

	public void setStudentCountry(String studentCountry) {
		this.studentCountry = studentCountry;
	}

	public String getStudentPhoto() {
		return studentPhoto;
	}

	public void setStudentPhoto(String studentPhoto) {
		this.studentPhoto = studentPhoto;
	}

	public String getStudentEducation() {
		return studentEducation;
	}

	public void setStudentEducation(String studentEducation) {
		this.studentEducation = studentEducation;
	}

	public Integer getStudentForumStatus() {
		return studentForumStatus;
	}

	public void setStudentForumStatus(Integer studentForumStatus) {
		this.studentForumStatus = studentForumStatus;
	}

	public Integer getStudentCourseStatus() {
		return studentCourseStatus;
	}

	public void setStudentCourseStatus(Integer studentCourseStatus) {
		this.studentCourseStatus = studentCourseStatus;
	}

	public String getFirstLanguage() {
		return firstLanguage;
	}

	public void setFirstLanguage(String firstLanguage) {
		this.firstLanguage = firstLanguage;
	}

	public String getLearningFrequency() {
		return learningFrequency;
	}

	public void setLearningFrequency(String learningFrequency) {
		this.learningFrequency = learningFrequency;
	}

	public String getStudentIdFormatted() {
		return studentIdFormatted;
	}

	public void setStudentIdFormatted(String studentIdFormatted) {
		this.studentIdFormatted = studentIdFormatted;
	}

	public Set<StudentReservationBean> getStudentReservation() {
		return studentReservation;
	}

	public void setStudentReservation(Set<StudentReservationBean> studentReservation) {
		this.studentReservation = studentReservation;
	}

	public Set<StudentScheduleBean> getStudentSchedule() {
		return studentSchedule;
	}

	public void setStudentSchedule(Set<StudentScheduleBean> studentSchedule) {
		this.studentSchedule = studentSchedule;
	}

}
