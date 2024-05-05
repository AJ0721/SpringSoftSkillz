package com.softskillz.courseorder.model.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "coursediscount")
@Component
public class DiscountBean {

	@Id
	@Column(name = "discount_id")
	private Integer disID;

	@Column(name = "discount_info")
	private String disInfo;

	@Column(name = "discount_percent")
	private Double disPercent;

	@JsonFormat(timezone = "GMT+8")
	@Column(name = "start_date")
	private Date startDate;
	
	@JsonFormat(timezone = "GMT+8")
	@Column(name = "end_date")
	private Date endDate;

	public DiscountBean() {
		super();
	}

	public DiscountBean(Integer disID, String disInfo, Double disPercent, Date startDate, Date endDate) {
		super();
		this.disID = disID;
		this.disInfo = disInfo;
		this.disPercent = disPercent;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public Integer getDisID() {
		return disID;
	}

	public void setDisID(Integer disID) {
		this.disID = disID;
	}

	public String getDisInfo() {
		return disInfo;
	}

	public void setDisInfo(String disInfo) {
		this.disInfo = disInfo;
	}

	public Double getDisPercent() {
		return disPercent;
	}

	public void setDisPercent(Double disPercent) {
		this.disPercent = disPercent;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "DiscountBean [disID=" + disID + ", disInfo=" + disInfo + ", disPercent=" + disPercent + ", startDate="
				+ startDate + ", endDate=" + endDate + "]";
	}

}
