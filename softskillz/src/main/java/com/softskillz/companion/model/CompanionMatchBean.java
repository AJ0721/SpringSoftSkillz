package com.softskillz.companion.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "companion_match")
@Component(value = "companion_match")
public class CompanionMatchBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "match_id")
	private Integer matchId;
	
	@ManyToOne (cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_student_a_id")
	private CompanionBean companionAId;
	
	@ManyToOne (cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_student_b_id")
	private CompanionBean companionBId;

	@Column(name = "match_request")
	private String matchRequest;
	
	public CompanionMatchBean() {
	}

	public CompanionMatchBean(Integer matchId, CompanionBean companionAId, CompanionBean companionBId,
			String matchRequest) {
		super();
		this.matchId = matchId;
		this.companionAId = companionAId;
		this.companionBId = companionBId;
		this.matchRequest = matchRequest;
	}

	public Integer getMatchId() {
		return matchId;
	}

	public void setMatchId(Integer matchId) {
		this.matchId = matchId;
	}

	public CompanionBean getCompanionAId() {
		return companionAId;
	}

	public void setCompanionAId(CompanionBean companionAId) {
		this.companionAId = companionAId;
	}

	public CompanionBean getCompanionBId() {
		return companionBId;
	}

	public void setCompanionBId(CompanionBean companionBId) {
		this.companionBId = companionBId;
	}

	public String getMatchRequest() {
		return matchRequest;
	}

	public void setMatchRequest(String matchRequest) {
		this.matchRequest = matchRequest;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("CompanionMatchBean [matchId=");
		builder.append(matchId);
		builder.append(", companionAId=");
		builder.append(companionAId);
		builder.append(", companionBId=");
		builder.append(companionBId);
		builder.append(", matchRequest=");
		builder.append(matchRequest);
		builder.append("]");
		return builder.toString();
	}
	
	

}
