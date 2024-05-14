package com.softskillz.mall.exception;

/**
 * 自定義異常類，用於處理實體未找到的情況。
 */
public class EntityNotFoundException extends RuntimeException {

    private String entityName;

    /**
     * 構造一個含有詳細錯誤信息的異常。
     * @param message 錯誤信息。
     */
    public EntityNotFoundException(String message) {
        super(message);
    }

    /**
     * 構造一個含有錯誤信息和導致異常的原因的異常。
     * @param message 錯誤信息。
     * @param cause 導致異常的原因。
     */
    public EntityNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * 構造一個指定實體名稱和ID的異常。
     * @param entityName 實體的名稱。
     * @param id 實體的ID。
     */
    public EntityNotFoundException(String entityName, Integer id) {
        super(entityName + " 的 ID " + id + " 未找到。");
        this.entityName = entityName;
    }

    /**
     * 獲取引發異常的實體名稱。
     * @return 實體名稱。
     */
    public String getEntityName() {
        return entityName;
    }
}
