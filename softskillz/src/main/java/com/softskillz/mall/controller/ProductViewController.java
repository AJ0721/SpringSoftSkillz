package com.softskillz.mall.controller;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mall")
public class ProductViewController {

    private final ProductService productService;

    @Autowired
    public ProductViewController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/backend")
    public String showBackendPage() {
        return "/dist/mall/mallbackend.html";
    }

    @GetMapping("/frontend")
    public String showFrontendPage() {
        return "/elearning/mall/mallfrontend.html";
    }

    // 新增的商品詳情頁面映射方法
    @GetMapping("/frontend/{productId}")
    public String getProductDetail(@PathVariable Integer productId, Model model) {
        Product product = productService.findProductById(productId);
        if (product == null) {
            return "error/404"; // 如果找不到商品，返回404頁面
        }
        model.addAttribute("product", product);
        return "/elearning/mall/product-detail.html"; // 返回商品詳情頁面的視圖名稱
    }


}


