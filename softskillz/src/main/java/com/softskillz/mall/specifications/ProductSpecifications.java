package com.softskillz.mall.specifications;

import com.softskillz.mall.model.Product;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品規格化查詢類
 * 提供方法以動態構建用於查詢的條件
 */
public class ProductSpecifications {

    /**
     * 基於多種參數動態生成查詢條件的規格化方法
     *
     * @param name 商品名稱，用於模糊查詢
     * @param productId 商品編號，用於精確查詢
     * @param typeId 商品類型編號，用於精確查詢
     * @param statusId 商品狀態編號，用於精確查詢
     * @param minPrice 商品的最低價格
     * @param maxPrice 商品的最高價格
     * @return 返回構建的規格化對象
     */
    public static Specification<Product> withDynamicQuery(String name, Integer productId, Integer typeId, Integer statusId, BigDecimal minPrice, BigDecimal maxPrice) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 根據商品名稱進行模糊查詢
            if (name != null && !name.isEmpty()) {
                predicates.add(cb.like(cb.lower(root.get("productName")), "%" + name.toLowerCase() + "%"));
            }
            // 根據商品編號進行精確查詢
            if (productId != null) {
                predicates.add(cb.equal(root.get("productId"), productId));
            }
            // 根據商品類型編號進行精確查詢
            if (typeId != null) {
                predicates.add(cb.equal(root.get("productType").get("id"), typeId));
            }
            // 根據商品狀態編號進行精確查詢
            if (statusId != null) {
                predicates.add(cb.equal(root.get("productStatus").get("id"), statusId));
            }
            // 根據價格範圍進行查詢
            if (minPrice != null && maxPrice != null) {
                predicates.add(cb.between(root.get("productPrice"), minPrice, maxPrice));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
