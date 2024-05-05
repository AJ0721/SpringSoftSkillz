package com.softskillz.forum.model.dto;

public class StudentDto {
    private int studentId;
    private String studentUsername;
    private String country;

    public StudentDto() {
    }

	public int getStudentId() {
		return studentId;
	}
	
	

	public StudentDto(int studentId, String studentUsername, String country) {
		super();
		this.studentId = studentId;
		this.studentUsername = studentUsername;
		this.country = country;
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

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
    
    

}