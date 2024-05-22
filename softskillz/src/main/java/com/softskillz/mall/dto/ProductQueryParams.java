package com.softskillz.mall.dto;

import com.softskillz.mall.constant.ProductCategory;

public class ProductQueryParams {

    private ProductCategory category;
    private String search;
    private String orderBy;
    private String sort;
    private Integer limit;
    private Integer offset;

    public ProductCategory getCategory() {
        return category;
    }

    public void setCategory(ProductCategory category) {
        this.category = category;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public String getOrderByColumn() {
        switch (this.orderBy) {
            case "productId":
                return "product_id";
            case "productName":
                return "product_name";
            case "category":
                return "category";
            case "price":
                return "price";
            case "stock":
                return "stock";
            case "createdDate":
                return "created_date";
            case "lastModifiedDate":
                return "last_modified_date";
            default:
                return "created_date"; // 默認排序列
        }
    }
}
