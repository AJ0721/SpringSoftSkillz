package com.softskillz.forum.model.dto;

public class TeacherDto {
    private int teacherId;
    private String teacherUsername;
    private String country;

    public TeacherDto() {
    }

	public TeacherDto(int teacherId, String teacherUsername, String country) {
		super();
		this.teacherId = teacherId;
		this.teacherUsername = teacherUsername;
		this.country = country;
	}

	public int getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(int teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherUsername() {
		return teacherUsername;
	}

	public void setTeacherUsername(String teacherUsername) {
		this.teacherUsername = teacherUsername;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
    
    

}
