package com.softskillz.forum.model.dto;

public class StudentDto {
    private int studentId;
    private String studentUsername;
    private String studentCountry;

    public StudentDto() {
    }

	public int getStudentId() {
		return studentId;
	}
	
	

	public StudentDto(int studentId, String studentUsername, String studentCountry) {
		super();
		this.studentId = studentId;
		this.studentUsername = studentUsername;
		this.studentCountry = studentCountry;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getStudentUsername() {
		return studentUsername;
	}

	public void setStudentUsername(String studentUsername) {
		this.studentUsername = studentUsername;
	}

	public String getStudentCountry() {
		return studentCountry;
	}

	public void setStudentCountry(String studentCountry) {
		this.studentCountry = studentCountry;
	}


    

}