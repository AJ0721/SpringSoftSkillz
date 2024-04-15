package com.softskillz.mall.model;

import jakarta.persistence.*;


@Entity
@Table(name = "product_category")
public class ProductCategoryBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_category_id")
    private Integer productCategoryId;

    @Column(name = "product_category_name")
    private String productCategoryName;

    @Column(name = "product_category_description")
    private String productCategoryDescription;

    public ProductCategoryBean() {
    }

    public ProductCategoryBean(Integer productCategoryId, String productCategoryName, String productCategoryDescription) {
        super();
        this.productCategoryId = productCategoryId;
        this.productCategoryName = productCategoryName;
        this.productCategoryDescription = productCategoryDescription;
    }

    public Integer getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(Integer productCategoryId) {
        this.productCategoryId = productCategoryId;
    }

    public String getProductCategoryName() {
        return productCategoryName;
    }

    public void setProductCategoryName(String productCategoryName) {
        this.productCategoryName = productCategoryName;
    }

    public String getProductCategoryDescription() {
        return productCategoryDescription;
    }

    public void setProductCategoryDescription(String productCategoryDescription) {
        this.productCategoryDescription = productCategoryDescription;
    }

    @Override
    public String toString() {
        return "ProductCategoryBean [productCategoryId=" + productCategoryId + ", productCategoryName=" + productCategoryName + ", productCategoryDescription=" + productCategoryDescription + "]";
    }
}