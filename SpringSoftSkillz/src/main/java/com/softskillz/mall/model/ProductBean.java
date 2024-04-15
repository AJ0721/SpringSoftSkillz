package com.softskillz.mall.model;


import jakarta.persistence.*;


@Entity
@Table(name = "product")
public class ProductBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_category_id")
    private Integer productCategoryId;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_description")
    private String productDescription;

    @Column(name = "product_price")
    private Integer productPrice;

    @Column(name = "product_stock")
    private Integer productStock;

    @Column(name = "product_image_url")
    private String productImageUrl;

    @Column(name = "product_target_audience")
    private String productTargetAudience;

    @Column(name = "product_create_date")
    private String productCreateDate;
//    private LocalDate productCreateDate;

    @Column(name = "product_update_date")
    private String productUpdateDate;
//    private LocalDate productUpdateDate;

    public ProductBean() {
    }

    public ProductBean(Integer productId, Integer productCategoryId, String productName, String productDescription, Integer productPrice, Integer productStock, String productImageUrl, String productTargetAudience, String productCreateDate, String productUpdateDate) {
        super();
        this.productId = productId;
        this.productCategoryId = productCategoryId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.productPrice = productPrice;
        this.productStock = productStock;
        this.productImageUrl = productImageUrl;
        this.productTargetAudience = productTargetAudience;
        this.productCreateDate = productCreateDate;
        this.productUpdateDate = productUpdateDate;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(Integer productCategoryId) {
        this.productCategoryId = productCategoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public Integer getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Integer productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductStock() {
        return productStock;
    }

    public void setProductStock(Integer productStock) {
        this.productStock = productStock;
    }

    public String getProductImageUrl() {
        return productImageUrl;
    }

    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }

    public String getProductTargetAudience() {
        return productTargetAudience;
    }

    public void setProductTargetAudience(String productTargetAudience) {
        this.productTargetAudience = productTargetAudience;
    }

    public String getProductCreateDate() {
        return productCreateDate;
    }

    public void setProductCreateDate(String productCreateDate) {
        this.productCreateDate = productCreateDate;
    }

    public String getProductUpdateDate() {
        return productUpdateDate;
    }

    public void setProductUpdateDate(String productUpdateDate) {
        this.productUpdateDate = productUpdateDate;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("ProductBean [productId=");
        builder.append(productId);
        builder.append(", productCategoryId=");
        builder.append(productCategoryId);
        builder.append(", productName=");
        builder.append(productName);
        builder.append(", productDescription=");
        builder.append(productDescription);
        builder.append(", productPrice=");
        builder.append(productPrice);
        builder.append(", productStock=");
        builder.append(productStock);
        builder.append(", productImageUrl=");
        builder.append(productImageUrl);
        builder.append(", productTargetAudience=");
        builder.append(productTargetAudience);
        builder.append(", productCreateDate=");
        builder.append(productCreateDate);
        builder.append(", productUpdateDate=");
        builder.append(productUpdateDate);
        builder.append("]");
        return builder.toString();
    }
}
