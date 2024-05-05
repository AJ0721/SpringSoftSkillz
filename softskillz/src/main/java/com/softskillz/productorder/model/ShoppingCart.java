package com.softskillz.productorder.model;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
    private List<ProductCartItem> items = new ArrayList<>();

    public void addItem(ProductCartItem item) {
        for (ProductCartItem existingItem : items) {
            if (existingItem.getProduct().getProductId().equals(item.getProduct().getProductId())) {
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public void removeItem(Integer productId) {
        items.removeIf(item -> item.getProduct().getProductId().equals(productId));
    }

    public void clearCart() {
        items.clear();
    }

    public int getTotalPrice() {
        return (int) items.stream().mapToDouble(item -> item.getProduct().getProductPrice() * item.getQuantity()).sum();
    }

    public List<ProductCartItem> getItems() {
        return items;
    }

    public void updateItemQuantity(Integer productId, Integer quantity) {
        ProductCartItem itemToUpdate = items.stream()
            .filter(item -> item.getProduct().getProductId().equals(productId))
            .findFirst()
            .orElse(null);

        if (itemToUpdate != null) {
            if (quantity > 0) {
                itemToUpdate.setQuantity(quantity);
            } else {
                items.remove(itemToUpdate); // 如果數量為0，就移除商品
            }
        } 
    
    }
}
