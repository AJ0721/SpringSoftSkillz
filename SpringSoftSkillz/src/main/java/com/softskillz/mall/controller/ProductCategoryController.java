package com.softskillz.mall.controller;

import com.softskillz.mall.model.ProductCategoryBean;
import com.softskillz.mall.model.ProductCategoryDAOInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

@Controller
public class ProductCategoryController {

    @Autowired
    private ProductCategoryDAOInterface productCategoryDAO;

    @RequestMapping(value = "/GetAllProductCategorys", method = RequestMethod.POST)
    public ModelAndView getAllProductCategorys() {
        ModelAndView view = new ModelAndView("Mall/MallInsert/insert");
        try {
            List<ProductCategoryBean> categories = productCategoryDAO.selectAllCategories();
            System.out.println(categories);
            view.addObject("categories", categories);
        } catch (Exception e) {
            e.printStackTrace();
            view.addObject("errorMessage", "An error occurred: " + e.getMessage());
        }
        return view;
    }
}
