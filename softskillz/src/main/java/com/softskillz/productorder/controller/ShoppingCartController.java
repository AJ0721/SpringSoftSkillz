package com.softskillz.productorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.HttpStatus;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import java.io.IOException;
import java.util.HashMap;
import com.softskillz.mall.model.Product;
import com.softskillz.productorder.model.ProductCartItem;
import com.softskillz.mall.service.ProductService;

@Controller
@RequestMapping("/productcart")
public class ShoppingCartController {

    @Autowired
    private ProductService productService;

    // 處理產品詳細資料
    @GetMapping("/detail")
    public String getProductDetail(@RequestParam("id") Integer productId, Model model, HttpServletResponse response) throws IOException {
        Product product = productService.getProductById(productId);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "找不到指定的產品");
            return null; // 或者可以重定向到一個錯誤頁面
        }
        model.addAttribute("product", product);
        return "productDetail"; // JSP 檔案名
    }

    // 添加產品到購物車
    @PostMapping("/add")
    public String addToCart(@RequestParam Integer productId, @RequestParam Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        Product product = productService.getProductById(productId);
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "產品未找到");
            return "redirect:/errorPage";
        }

        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        ProductCartItem item = cart.getOrDefault(productId, new ProductCartItem(product, 0));
        item.setQuantity(item.getQuantity() + quantity);
        cart.put(productId, item);

        session.setAttribute("cart", cart);
        return "redirect:/cartPage"; 
    }

    // 查看購物車
    @GetMapping("/view")
    public String viewCart(HttpSession session, Model model) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        model.addAttribute("cart", cart);
        return "cartPage"; 
    }

    // 更新購物車項目
    @PostMapping("/update")
    public String updateCartItem(@RequestParam Integer productId, @RequestParam Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null || !cart.containsKey(productId)) {
            redirectAttributes.addFlashAttribute("error", "Cart item not found");
            return "redirect:/errorCartPage";
        }

        ProductCartItem item = cart.get(productId);
        item.setQuantity(quantity);
        cart.put(productId, item);

        session.setAttribute("cart", cart);
        return "redirect:/cartPage"; 
    }

    // 從購物車移除項目
    @DeleteMapping("/remove")
    public String removeFromCart(@RequestParam Integer productId, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null || !cart.containsKey(productId)) {
            redirectAttributes.addFlashAttribute("error", "Cart item not found");
            return "redirect:/errorCartPage";
        }

        cart.remove(productId);
        session.setAttribute("cart", cart);
        return "redirect:/cartPage";
    }

    // 清空購物車
    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/productList"; 
    }
}
