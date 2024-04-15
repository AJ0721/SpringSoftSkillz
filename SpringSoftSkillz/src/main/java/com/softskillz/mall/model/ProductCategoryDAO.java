package com.softskillz.mall.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class ProductCategoryDAO implements ProductCategoryDAOInterface{

    @Autowired
    private SessionFactory factory;

    // 查詢所有商品分類
    public List<ProductCategoryBean> selectAllCategories() {
        Session session = factory.openSession();
        Query<ProductCategoryBean> query = session.createQuery("FROM ProductCategoryBean", ProductCategoryBean.class);
        List<ProductCategoryBean> result = query.getResultList();
        session.close();

        return result;
    }

}
