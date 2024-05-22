package com.softskillz.productorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.softskillz.mall.model.Coupon;
import com.softskillz.mall.model.Product;
import com.softskillz.productorder.model.ProductCartItem;
import com.softskillz.mall.service.CouponService;
import com.softskillz.mall.service.ProductService;

@Controller
@RequestMapping("/productcart")
public class ShoppingCartController {

 @Autowired
 private ProductService productService;

 @Autowired
 private CouponService couponService; // 注入 CouponService

 // 處理產品詳細資料
 @GetMapping("/detail")
 public String getProductDetail(@RequestParam("id") Integer productId, Model model, HttpServletResponse response)
   throws IOException {
  Product product = productService.findProductById(productId);
  if (product == null) {
   response.sendError(HttpServletResponse.SC_NOT_FOUND, "找不到指定的產品");
   return null; // 或者可以重定向到一個錯誤頁面
  }
  model.addAttribute("product", product);
  return "productDetail"; // JSP 檔案名
 }

 // 模擬的商品數據
 private static final Map<Integer, Product> productData = new HashMap<>();
 static {
  // 模擬數據，根據實際需求修改
 }

 // 新增假資料到 session
 @GetMapping("/addtestdata")
 public String addTestDataToSession(HttpSession session) {
  Map<Integer, ProductCartItem> cart = new HashMap<>();
  for (Map.Entry<Integer, Product> entry : productData.entrySet()) {
   ProductCartItem item = new ProductCartItem(entry.getValue(), 1);
   cart.put(entry.getKey(), item);
  }
  session.setAttribute("cart", cart);
  System.err.println("cart" + cart);
  return "redirect:view";
 }

 // 添加產品到購物車
 @PostMapping("/add")
 public ResponseEntity<String> addToCart(@RequestParam("productId") Integer productId, @RequestParam("quantity") Integer quantity,
   HttpSession session) {
  Product product = productService.findProductById(productId);
  if (product == null) {
   return ResponseEntity.status(HttpStatus.NOT_FOUND).body("產品未找到");
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
   cart.put(productId, new ProductCartItem(product, quantity));
  }

  // 更新會話中的購物車
  session.setAttribute("cart", cart);
  return ResponseEntity.ok("產品已成功添加到購物車");
 }


 // 查看購物車
 @GetMapping("/view")
 public String viewCart(HttpSession session, Model model) {

  // 獲取推薦商品
  //        List<Product> product = productService.findAllProducts(); // 可以修改此處以便獲取真正的推薦商品邏輯
  //        System.out.println(product);
  //        model.addAttribute("product", product);
  //        model.addAttribute("productName", product.get(0).getProductName());
  //        model.addAttribute("recommendedProducts", recommendedProducts);
  //        model.addAttribute("cart", cart);

  // 獲取已應用的優惠券
  //        Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
  //        model.addAttribute("appliedCoupon", appliedCoupon);

  return "elearning/productorder/shoppingcart.html";
 }

 // 更新購物車項目
 @PostMapping("/update")
 public String updateCartItem(@RequestParam("productId") Integer productId,
   @RequestParam("quantity") Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
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

 @GetMapping("/cartdata")
 @ResponseBody
 public Map<Integer, ProductCartItem> getCartData(HttpSession session) {
  Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
  if (cart == null) {
   cart = new HashMap<>();
   session.setAttribute("cart", cart);
  }
  System.err.println("cart" + cart);
  return cart;
 }

 // 從購物車移除項目
 @PostMapping("/remove")
 public String removeFromCart(@RequestParam("productId") Integer productId, HttpSession session,
   RedirectAttributes redirectAttributes) {
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
  session.removeAttribute("appliedCoupon"); // 清除應用的優惠券
  return "redirect:view";
 }
 
 
String GrandTotal;
 // 結帳頁面
 @GetMapping("/checkout")
 public String checkout(@RequestParam String grandTotal) {
	 GrandTotal=grandTotal;
	 System.out.println(grandTotal);
	 return "elearning/productorder/checkout.html";
 
 }
 
 
 
 

 
 /*@GetMapping("/testtesttest")
 public String qewrqwer() {
	 
	 return GrandTotal;
 }*/
 

 // 應用優惠券
 @PostMapping("/apply-coupon")
 public String applyCoupon(@RequestParam("couponCode") String couponCode, HttpSession session,
   RedirectAttributes redirectAttributes) {
  Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");
  if (cart == null) {
   redirectAttributes.addFlashAttribute("error", "購物車未找到");
   return "redirect:view";
  }

  try {
   // 嘗試將 couponCode 轉換為 Integer
   Integer couponId = Integer.parseInt(couponCode);
   Optional<Coupon> coupon = couponService.findCouponById(couponId);
   if (coupon.isPresent()) {
    session.setAttribute("appliedCoupon", coupon.get());
    redirectAttributes.addFlashAttribute("success", "優惠券已成功應用");
   } else {
    redirectAttributes.addFlashAttribute("error", "無效的優惠券代碼");
   }
  } catch (NumberFormatException e) {
   redirectAttributes.addFlashAttribute("error", "無效的優惠券代碼");
  }

  return "redirect:view";
 }
}