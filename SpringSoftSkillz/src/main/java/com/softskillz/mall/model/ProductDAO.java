package com.softskillz.mall.model;


import jakarta.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class ProductDAO implements ProductDAOInterface {

    @Autowired
    private SessionFactory factory;

    //新增
    @Override
    public ProductBean insert(ProductBean proBean) {
        Session session = factory.openSession();

        try {
            session.persist(proBean);
            session.flush();
            session.close();

            return proBean;


        } catch (NoResultException e) {
            System.out.println(e);
            return null;

        }
    }

    //查詢單筆 利用商品編號
    @Override
    public ProductBean selectById(Integer productId) {
        Session session = factory.openSession();

        String hql = "from ProductBean p where p.productId = :id";

        try {
            Query<ProductBean> query = session.createQuery(hql, ProductBean.class)
                    .setParameter("id", productId);

            ProductBean result = query.getSingleResult();
            session.close();

            return result;
        } catch (NoResultException e) {
            System.out.println(e);
            return null;
        }
    }

    //查詢單筆 利用商品名稱
    @Override
    public ProductBean selectByName(String productName) {
        Session session = factory.openSession();

        String hql = "from ProductBean p where p.productName = :name";

        try {
            Query<ProductBean> query = session.createQuery(hql, ProductBean.class)
                    .setParameter("name", productName);

            ProductBean result = query.getSingleResult();
            session.close();

            return result;
        } catch (NoResultException e) {
            System.out.println(e);
            return null;
        }
    }

    //查詢全部
    @Override
    public List<ProductBean> selectAll() {
        Session session = factory.openSession();

        Query<ProductBean> query = session.createQuery("from ProductBean", ProductBean.class);

        List<ProductBean> result = query.getResultList();
        session.close();

        return result;
    }

    //修改單筆
    @Override
    public ProductBean updateOne(ProductBean proBean) {
        Session session = factory.openSession();
        ProductBean productBean = session.get(ProductBean.class, proBean.getProductId());
        try {
            if (productBean != null) {
                productBean.setProductId(proBean.getProductId());
                productBean.setProductCategoryId(proBean.getProductCategoryId());
                productBean.setProductName(proBean.getProductName());
                productBean.setProductDescription(proBean.getProductDescription());
                productBean.setProductPrice(proBean.getProductPrice());
                productBean.setProductStock(proBean.getProductStock());
                productBean.setProductImageUrl(proBean.getProductImageUrl());
                productBean.setProductTargetAudience(proBean.getProductTargetAudience());
                productBean.setProductCreateDate(proBean.getProductCreateDate());
                productBean.setProductUpdateDate(proBean.getProductUpdateDate());
                session.merge(productBean);
                session.flush();
                session.close();

                return productBean;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //刪除單筆
    @Override
    public boolean deleteOne(Integer productId) {

        Session session = factory.openSession();
        ProductBean productBean = session.get(ProductBean.class, productId);

        if (productBean != null) {
            session.remove(productBean);

            session.flush();
            session.close();

            return true;
        }

        return false;


    }
}


