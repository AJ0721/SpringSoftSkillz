package com.softskillz.forum.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class StudentDto implements UserDto {
    private int studentId;
    private String studentUsername;
    private String studentCountry;

    public StudentDto() {
    }

    public StudentDto(int studentId, String studentUsername, String studentCountry) {
        this.studentId = studentId;
        this.studentUsername = studentUsername;
        this.studentCountry = studentCountry;
    }

    public int getStudentId() {
        return studentId;
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

    @Override
    @JsonIgnore
    public String getIdentifier() {
        return studentUsername;
    }
}