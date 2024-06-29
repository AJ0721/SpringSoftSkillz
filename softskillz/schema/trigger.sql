CREATE TRIGGER trg_update_order
ON test_order
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE test_order
    SET update_at = SYSDATETIME()
    FROM test_order
    INNER JOIN inserted ON test_order.order_id = inserted.order_id;
END;

CREATE TRIGGER trg_update_at_test_product
ON test_product
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE test_product
    SET update_at = SYSDATETIME()
    FROM test_product
    INNER JOIN inserted ON test_product.product_id = inserted.product_id;
END;