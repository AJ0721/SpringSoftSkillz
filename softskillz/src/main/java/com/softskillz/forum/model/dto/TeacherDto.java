package com.softskillz.forum.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class TeacherDto implements UserDto {
	private int teacherId;
	private String teacherUserName;
	private String teacherCountry;

	public TeacherDto() {
	}

	public TeacherDto(int teacherId, String teacherUserName, String teacherCountry) {
		this.teacherId = teacherId;
		this.teacherUserName = teacherUserName;
		this.teacherCountry = teacherCountry;
	}

	public int getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(int teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherUserName() {
		return teacherUserName;
	}

	public void setTeacherUserName(String teacherUserName) {
		this.teacherUserName = teacherUserName;
	}

	public String getTeacherCountry() {
		return teacherCountry;
	}

	public void setTeacherCountry(String teacherCountry) {
		this.teacherCountry = teacherCountry;
	}

	@Override
    @JsonIgnore
	public String getIdentifier() {
		return teacherUserName;
	}
}