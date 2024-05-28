package com.softskillz.productorder.controller;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;
import com.softskillz.productorder.model.Order;
import com.softskillz.productorder.model.OrderItem;
import com.softskillz.productorder.model.OrderItemService;
import com.softskillz.productorder.model.OrderService;
import com.softskillz.productorder.model.ProductCartItem;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
@RequestMapping("/productcart")
public class ShoppingCartController {

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemService orderItemService;

    private static final AtomicInteger counter = new AtomicInteger(1);

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

    // 新增假資料到 session
    @GetMapping("/addtestdata")
    public String addTestDataToSession(HttpSession session) {
        Map<Integer, ProductCartItem> cart = new HashMap<>();
        // 根據實際需求新增模擬數據
        session.setAttribute("cart", cart);
        return "redirect:view";
    }

    // 添加產品到購物車
    @PostMapping("/add")
    public ResponseEntity<String> addToCart(@RequestParam("productId") Integer productId,
            @RequestParam("quantity") Integer quantity,
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
        return "redirect:view";
    }

    // 結帳頁面
    @GetMapping("/checkout")
    public String checkout(@RequestParam String grandTotal) {
        // 設置總金額，可能需要進一步處理
        System.out.println(grandTotal);
        return "elearning/productorder/checkout.html";
    }

    // 新增訂單生成並跳轉到 Line Pay 的控制器方法
    @PostMapping("/createOrder")
    public ResponseEntity<String> createOrder(@RequestBody Order order, HttpSession session) {
        Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("購物車為空");
        }

        // 不需要設置 orderId,讓資料庫自動生成
        // order.setOrderId(counter.getAndIncrement());

        order.setOrderDate(LocalDateTime.now());
        order.setOrderStatus("未付款");
        Order savedOrder = orderService.insertOrder(order);
        session.setAttribute("orderId", savedOrder.getOrderId());
        session.setAttribute("total", order.getTotalAmount());  // 將 total 設置到 session 中

        for (Map.Entry<Integer, ProductCartItem> entry : cart.entrySet()) {
            ProductCartItem cartItem = entry.getValue();
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(savedOrder.getOrderId());
            orderItem.setProductId(cartItem.getProduct().getProductId());
            orderItem.setProductName(cartItem.getProduct().getProductName());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setProductPrice(cartItem.getProduct().getProductPrice().intValue());
            orderItem.setSubTotal(cartItem.getQuantity() * cartItem.getProduct().getProductPrice().intValue());
            orderItemService.createOrderItem(orderItem);
        }

        System.out.println("創建訂單成功,訂單編號：" + savedOrder.getOrderId());
        return ResponseEntity.ok(savedOrder.getOrderId().toString());
    }

}
