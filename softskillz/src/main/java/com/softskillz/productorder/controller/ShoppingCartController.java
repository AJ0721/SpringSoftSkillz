package com.softskillz.productorder.controller;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;
import com.softskillz.productorder.model.ProductCartItem;
import com.softskillz.productorder.model.ShoppingCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/ShoppingCart")
public class ShoppingCartController {
    
    @Autowired
    private ProductService productService;

    // 加入商品到購物車
    @PostMapping("/add")
    public ResponseEntity<ShoppingCart> addToCart(@RequestBody ProductCartItem cartItem, HttpSession session) {
        Product product = productService.getProductById(cartItem.getProduct().getProductId());
        if (product == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "找不到商品");
        }

        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        cart.addItem(new ProductCartItem(product, cartItem.getQuantity()));
        session.setAttribute("cart", cart);
        return ResponseEntity.ok(cart);
    }

    // 查看購物車内容
    @GetMapping("/view")
    public ResponseEntity<ShoppingCart> viewCart(HttpSession session) {
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(cart);
    }

    // 從購物車中移除內容
    @DeleteMapping("/remove/{productId}")
    public ResponseEntity<?> removeItemFromCart(@PathVariable Integer productId, HttpSession session) {
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            return ResponseEntity.notFound().build();
        }

        cart.removeItem(productId);
        session.setAttribute("cart", cart);
        return ResponseEntity.ok(cart);
    }

    // 清空購物車
    @PostMapping("/clear")
    public ResponseEntity<?> clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return ResponseEntity.ok().build();
    }

    // 更新購物車中商品的數量
    @PutMapping("/update/{productId}/{quantity}")
    public ResponseEntity<?> updateCartItem(@PathVariable Integer productId,
                                            @PathVariable Integer quantity,
                                            HttpSession session) {
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            return ResponseEntity.notFound().build();
        }

        cart.updateItemQuantity(productId, quantity);
        session.setAttribute("cart", cart);
        return ResponseEntity.ok(cart);
    }
}
