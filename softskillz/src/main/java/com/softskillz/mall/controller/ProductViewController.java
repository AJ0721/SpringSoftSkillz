package com.softskillz.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductViewController {

    @GetMapping("/")
    public String showBackendPage() {
        return "/mall/html/backendPage.html";
    }

    @GetMapping("/mall/index")
    public String showIndexPage() {
        return "/mall/html/index.html";
    }

    @GetMapping("/mall/addProduct")
    public String showAddProductPage() {
        return "/mall/html/addProduct.html";
    }

    @GetMapping("/mall/updateProduct")
    public String showUpdateProductPage() {
        return "/mall/html/updateProduct.html";
    }
}
