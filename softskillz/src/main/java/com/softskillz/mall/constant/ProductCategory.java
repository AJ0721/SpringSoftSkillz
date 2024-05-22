package com.softskillz.mall.constant;

public enum ProductCategory {
    實體教材("精選實體書籍和教材，涵蓋多個學習領域的基礎與進階知識"),
    周邊商品("與學習相關的周邊商品，旨在提升學習效率和學習體驗"),
    教材影片("提供各類教育影片，包括語言學習、專業科目深入講解、音樂教學、運動指導及生活技能等");


    private String description;

    ProductCategory(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
