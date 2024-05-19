package com.softskillz.productorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.util.HashMap;
import java.util.Optional;

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
        Optional<Product> product = productService.findProductById(productId);
        if (!product.isPresent()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "找不到指定的產品");
            return null; // 或者可以重定向到一個錯誤頁面
        }
        model.addAttribute("product", product.get());
        return "productDetail"; // JSP 檔案名
    }
    
 // 模擬的商品數據
    private static final Map<Integer, Product> productData = new HashMap<>();
    static {
        productData.put(1, new Product(1, "學習小夥伴筆記本", "精緻設計的筆記本，伴隨您學習之路", null, null, null, 599, null, null, null, null, null, null, null));
        productData.put(2, new Product(2, "靜心瑜珈墊", "優質材質、防滑設計，適合居家健身", null, null, null, 849, null, null, null, null, null, null, null));
        productData.put(3, new Product(3, "智能記憶手環", "記錄學習數據、提醒作息時間", null, null, null, 1077, null, null, null, null, null, null, null));
    }

    // 添加產品到購物車
    @GetMapping("/add")
    public String addToCart(@RequestParam("productId") Integer productId, @RequestParam("quantity") Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        Optional<Product> product = productService.findProductById(productId);
        if (!product.isPresent()) {
            redirectAttributes.addFlashAttribute("error", "產品未找到");
            // 重定向到產品列表或首頁，並顯示錯誤訊息
            return "redirect:/productList";
        }

        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        // 檢查購物車是否已包含該商品
        if (cart.containsKey(productId)) {
            // 如果購物車已有此商品，增加數量
            ProductCartItem existingItem = cart.get(productId);
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            // 如果購物車中沒有此商品，創建新的購物車項目
            cart.put(productId, new ProductCartItem(product.get(), quantity));
        }

        // 更新會話中的購物車
        session.setAttribute("cart", cart);
        redirectAttributes.addFlashAttribute("success", "產品已成功添加到購物車");
        return "redirect:view";
    }

    // 查看購物車
    @GetMapping("/view")
    public String viewCart(HttpSession session, Model model) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        // 获取推荐商品
        List<Product> recommendedProducts = productService.findAllProducts(); // 可以修改此處以便獲取真正的推薦商品邏輯
        model.addAttribute("recommendedProducts", recommendedProducts);

        model.addAttribute("cart", cart);
        return "elearning/productorder/shoppingcart.html";
    }

    // 更新購物車項目
    @PostMapping("/update")
    public String updateCartItem(@RequestParam("productId") Integer productId, @RequestParam("quantity") Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null) {
            redirectAttributes.addFlashAttribute("error", "購物車未找到");
            return "redirect:view";
        }

        ProductCartItem item = cart.get(productId);
        if (item != null) {
            item.setQuantity(quantity);
            cart.put(productId, item);
            session.setAttribute("cart", cart);
        } else {
            redirectAttributes.addFlashAttribute("error", "購物車項目未找到");
        }
        return "redirect:view";
    }

    // 從購物車移除項目
    @PostMapping("/remove")
    public String removeFromCart(@RequestParam("productId") Integer productId, HttpSession session, RedirectAttributes redirectAttributes) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
        if (cart == null || !cart.containsKey(productId)) {
            redirectAttributes.addFlashAttribute("error", "購物車項目未找到");
            return "redirect:view";
        }

        cart.remove(productId);
        session.setAttribute("cart", cart);
        return "redirect:view";
    }

    // 清空購物車
    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:view";
    }

    // 結帳頁面
    @GetMapping("/checkout")
    public String checkout() {
        return "elearning/productorder/checkout.html";
    }
}
