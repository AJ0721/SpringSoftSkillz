package com.softskillz.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductViewController {

    @GetMapping("/demo")
    public String showDemo1Page() {
        return "/dist/demo.html";
    }

    @GetMapping("/mall/mallProductAll")
    public String showDemoPage() {
        return "/dist/mall/mallProductAll.html";
    }

    @GetMapping("/mall/index")
    public String showIndexPage() {
        return "/mall/html/index.html";
    }


    @GetMapping("/mall/mallfrontend")
    public String showfrontPage() {
        return "/elearning/mall/mallfrontend.html";
    }
}
