package com.softskillz.mall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.softskillz.mall.model.Coupon;
import com.softskillz.mall.service.CouponService;

/**
 * 優惠券控制器
 */
@RestController
@RequestMapping("/coupons")
public class CouponController {

    private final CouponService couponService;

    @Autowired
    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    /**
     * 創建優惠券
     *
     * @param coupon 優惠券實體
     * @return 創建成功的優惠券實體
     */
    @PostMapping
    public ResponseEntity<Coupon> createCoupon(@RequestBody Coupon coupon) {
        Coupon createdCoupon = couponService.createCoupon(coupon);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCoupon);
    }

    /**
     * 根據ID獲取優惠券
     *
     * @param id 優惠券ID
     * @return 優惠券實體
     */
    @GetMapping("/{id}")
    public ResponseEntity<Coupon> getCouponById(@PathVariable Integer id) {
        Coupon coupon = couponService.getCouponById(id);
        if (coupon == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Coupon not found");
        }
        return ResponseEntity.ok(coupon);
    }

    /**
     * 獲取所有優惠券
     *
     * @return 所有優惠券列表
     */
    @GetMapping
    public ResponseEntity<List<Coupon>> getAllCoupons() {
        List<Coupon> coupons = couponService.getAllCoupons();
        return ResponseEntity.ok(coupons);
    }

    /**
     * 獲取當前有效的優惠券
     *
     * @return 有效的優惠券列表
     */
    @GetMapping("/active")
    public ResponseEntity<List<Coupon>> getActiveCoupons() {
        List<Coupon> activeCoupons = couponService.getActiveCoupons();
        return ResponseEntity.ok(activeCoupons);
    }

    /**
     * 更新優惠券
     *
     * @param id     優惠券ID
     * @param coupon 優惠券實體
     * @return 更新成功的優惠券實體
     */
//    @PutMapping("/{id}")
//    public ResponseEntity<Coupon> updateCoupon(@PathVariable Integer id, @RequestBody Coupon coupon) {
//        coupon.setCouponId(id);
//        Coupon updatedCoupon = couponService.updateCoupon(coupon);
//        return ResponseEntity.ok(updatedCoupon);
//    }

    /**
     * 刪除優惠券
     *
     * @param id 優惠券ID
     * @return 空響應體
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCoupon(@PathVariable Integer id) {
        couponService.deleteCoupon(id);
        return ResponseEntity.noContent().build();
    }
}
