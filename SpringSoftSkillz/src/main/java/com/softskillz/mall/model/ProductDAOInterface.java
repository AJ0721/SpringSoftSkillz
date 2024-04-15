package com.softskillz.mall.model;

import java.util.List;

public interface ProductDAOInterface {

        ProductBean insert(ProductBean productBean);

        ProductBean selectById(Integer productId);

        ProductBean selectByName(String productName);

        List<ProductBean> selectAll();

        ProductBean updateOne(ProductBean productBean);

        boolean deleteOne(Integer productId);
}
