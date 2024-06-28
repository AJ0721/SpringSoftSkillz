package com.softskillz.cart.bean.model;

import java.math.BigDecimal;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Component
@Entity
@Table(name = "voucher")
public class Voucher {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "voucher_id")
	private Long voucherId;
	
	@Column(name = "voucher_name")
	private String voucherName;
	
	@Column(name = "voucher_value")
	private BigDecimal voucherValue;

	//insert
	public Voucher(String voucherName, BigDecimal voucherValue) {
		this.voucherName = voucherName;
		this.voucherValue = voucherValue;
	}

	//update
	public Voucher(Long voucherId, String voucherName, BigDecimal voucherValue) {
		this.voucherId = voucherId;
		this.voucherName = voucherName;
		this.voucherValue = voucherValue;
	}
	
	
	

}
