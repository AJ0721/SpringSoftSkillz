package com.softskillz.mall.dao.impl;

import com.softskillz.mall.dao.ProductDao;
import com.softskillz.mall.dto.ProductQueryParams;
import com.softskillz.mall.dto.ProductRequest;
import com.softskillz.mall.model.Product;
import com.softskillz.mall.rowmapper.ProductRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ProductDaoImpl implements ProductDao {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ProductDaoImpl(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    // 查詢商品總數
    @Override
    public Integer countProduct(ProductQueryParams productQueryParams) {
        String sql = "SELECT count(*) FROM product WHERE 1=1";

        Map<String, Object> map = new HashMap<>();

        // 查詢條件
        sql = addFilteringSql(sql, map, productQueryParams);

        Integer total = namedParameterJdbcTemplate.queryForObject(sql, map, Integer.class);

        return total;
    }

    // 查詢商品列表
    @Override
    public List<Product> findProducts(ProductQueryParams productQueryParams) {
        String sql = "SELECT product_id, product_name, category, image_url, price, stock, description, "
                + "created_date, last_modified_date "
                + "FROM product WHERE 1=1";

        Map<String, Object> map = new HashMap<>();

        // 查詢條件
        sql = addFilteringSql(sql, map, productQueryParams);

        // 增加列名檢查，確保 orderBy 是有效的列名
        String orderBy = productQueryParams.getOrderByColumn();
        if (!isValidColumn(orderBy)) {
            throw new IllegalArgumentException("Invalid orderBy column: " + orderBy);
        }

        // 排序
        sql = sql + " ORDER BY " + orderBy + " " + productQueryParams.getSort();

        // 分頁
        sql = sql + " OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY";
        map.put("limit", productQueryParams.getLimit());
        map.put("offset", productQueryParams.getOffset());

        List<Product> productList = namedParameterJdbcTemplate.query(sql, map, new ProductRowMapper());

        return productList;
    }

    // 確認列名是否有效的方法
    private boolean isValidColumn(String column) {
        return column != null && (
                column.equals("product_id") ||
                        column.equals("product_name") ||
                        column.equals("category") ||
                        column.equals("image_url") ||
                        column.equals("price") ||
                        column.equals("stock") ||
                        column.equals("description") ||
                        column.equals("created_date") ||
                        column.equals("last_modified_date")
        );
    }

    // 查詢單個商品 by productId
    @Override
    public Product findProductById(Integer productId) {
        String sql = "SELECT  product_id, product_name, category, image_url, price, stock, description, "
                + "created_date, last_modified_date "
                + "FROM product WHERE product_id = :product_id";

        Map<String, Object> map = new HashMap<>();
        map.put("product_id", productId);

        List<Product> productList = namedParameterJdbcTemplate.query(sql, map, new ProductRowMapper());

        if (!productList.isEmpty()) {
            return productList.get(0);
        } else {
            return null;
        }
    }

    // 新增商品
    @Override
    public Integer createProduct(ProductRequest productRequest) {
        String sql = "INSERT INTO product (product_name, category, price, stock, description, image_url, created_date, last_modified_date) " +
                "VALUES (:productName, :category, :price, :stock, :description, :imageUrl, :createdDate, :lastModifiedDate)";

        Map<String, Object> map = new HashMap<>();
        map.put("productName", productRequest.getProductName());
        map.put("category", productRequest.getCategory().toString());
        map.put("imageUrl", productRequest.getImageUrl());
        map.put("price", productRequest.getProductPrice());
        map.put("stock", productRequest.getStock());
        map.put("description", productRequest.getDescription());

        Date now = new Date();
        map.put("createdDate", now);
        map.put("lastModifiedDate", now);

        KeyHolder keyHolder = new GeneratedKeyHolder();
        namedParameterJdbcTemplate.update(sql, new MapSqlParameterSource(map), keyHolder);

        return keyHolder.getKey().intValue();
    }

    // 修改商品 by productId
    @Override
    public void updateProduct(Integer productId, ProductRequest productRequest) {
        String sql = "UPDATE product SET product_name = :productName, category = :category, image_url = :imageUrl, price = :price, stock = :stock, description = :description, last_modified_date = :lastModifiedDate " +
                "WHERE product_id = :productId";

        Map<String, Object> map = new HashMap<>();
        map.put("productId", productId);
        map.put("productName", productRequest.getProductName());
        map.put("category", productRequest.getCategory().toString());
        map.put("imageUrl", productRequest.getImageUrl());
        map.put("price", productRequest.getProductPrice());
        map.put("stock", productRequest.getStock());
        map.put("description", productRequest.getDescription());
        map.put("lastModifiedDate", new Date());

        namedParameterJdbcTemplate.update(sql, map);
    }

    // 訂單完成後更新商品庫存
//    @Override
//    public void updateStock(Integer productId, Integer stock) {
//        String sql = "UPDATE product SET stock = :stock, last_modified_date = :lastModifiedDate" +
//                " WHERE product_id = :productId";
//
//        Map<String, Object> map = new HashMap<>();
//        map.put("productId", productId);
//        map.put("stock", stock);
//        map.put("lastModifiedDate", new Date());
//
//        namedParameterJdbcTemplate.update(sql, map);
//    }

    // 刪除商品 by productId
    @Override
    public void deleteProductById(Integer productId) {
        String sql = "DELETE FROM product WHERE product_id = :product_id";

        Map<String, Object> map = new HashMap<>();
        map.put("product_id", productId);

        namedParameterJdbcTemplate.update(sql, map);
    }

    private String addFilteringSql(String sql, Map<String, Object> map, ProductQueryParams productQueryParams) {
        // 查詢條件
        if (productQueryParams.getCategory() != null) {
            sql += " AND category = :category";
            map.put("category", productQueryParams.getCategory().name());
        }

        if (productQueryParams.getSearch() != null) {
            sql += " AND product_name LIKE :search";
            map.put("search", "%" + productQueryParams.getSearch() + "%");
        }

        return sql;
    }
}
