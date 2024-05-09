package com.softskillz.mall.specifications;

import com.softskillz.mall.model.Product;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ProductSpecifications {

    // 根據商品名稱進行模糊查詢
    public static Specification<Product> hasName(String name) {
        return (root, query, cb) -> cb.like(cb.lower(root.get("productName")), "%" + name.toLowerCase() + "%");
    }

    // 根據價格範圍進行查詢
    public static Specification<Product> priceBetween(BigDecimal minPrice, BigDecimal maxPrice) {
        return (root, query, cb) -> cb.between(root.get("productPrice"), minPrice, maxPrice);
    }

    // 根據商品類型進行查詢
    public static Specification<Product> hasType(Integer typeId) {
        return (root, query, cb) -> cb.equal(root.get("productType").get("id"), typeId);
    }

    // 根據商品狀態進行查詢
    public static Specification<Product> hasStatus(Integer statusId) {
        return (root, query, cb) -> cb.equal(root.get("productStatus").get("id"), statusId);
    }

    // 根據出版日期進行查詢，查詢大於等於指定日期的商品
    public static Specification<Product> isPublishedAfter(LocalDate date) {
        return (root, query, cb) -> cb.greaterThanOrEqualTo(root.get("productPublicationDate"), date);
    }

    // 更多的Specification可以在此添加

}
