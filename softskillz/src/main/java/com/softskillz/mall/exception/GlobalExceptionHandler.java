package com.softskillz.mall.exception;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    // 處理 ResponseStatusException 並自訂錯誤響應
    @ExceptionHandler(ResponseStatusException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseEntity<Object> handleResponseStatusException(ResponseStatusException ex) {
        Map<String, Object> errorDetails = new HashMap<>();
        errorDetails.put("message", ex.getReason());  // 錯誤訊息
        errorDetails.put("status", ex.getStatusCode().value()); // HTTP 狀態碼
        errorDetails.put("timestamp", LocalDateTime.now()); // 發生時間
        return new ResponseEntity<>(errorDetails, ex.getStatusCode());
    }

    // 可以添加其他的異常處理器
}
