package com.softskillz.mall.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;

/**
 * 商品庫存的自定義序列化器。
 * 當庫存值為 null 時，在 JSON 中顯示為「無限」。
 * 當庫存值為 0 時，在 JSON 中顯示為「無庫存」。
 * 其他情況顯示實際的庫存數字。
 */
public class ProductStockSerializer extends JsonSerializer<Integer> {

    @Override
    public void serialize(Integer value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (value == null) {
            gen.writeString("無限");  // 顯示「無限」表示庫存不受限制
        } else if (value == 0) {
            gen.writeString("無庫存"); // 顯示「無庫存」表示目前無可用庫存
        } else {
            gen.writeNumber(value);    // 顯示實際的庫存數字
        }
    }
}