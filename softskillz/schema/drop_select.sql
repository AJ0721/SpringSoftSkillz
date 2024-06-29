SELECT * FROM product_category;
SELECT * FROM test_product;
SELECT * FROM image_url;
SELECT * FROM cart_item;
SELECT * FROM test_order
SELECT * FROM voucher
SELECT * FROM order_item;

DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS cart_item;
DROP TABLE IF EXISTS test_order;
DROP TABLE IF EXISTS voucher;
DROP TABLE IF EXISTS image_url;
DROP TABLE IF EXISTS test_product;
DROP TABLE IF EXISTS product_category;


--DROP ALL
DECLARE @sql NVARCHAR(MAX) = N'';

-- Generate DROP CONSTRAINT statements for each foreign key constraint in the database
SELECT @sql += 'ALTER TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) +
               ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + ';'
FROM sys.foreign_keys AS fk
JOIN sys.tables AS t ON fk.parent_object_id = t.object_id
JOIN sys.schemas AS s ON t.schema_id = s.schema_id;

-- Execute the generated DROP CONSTRAINT statements
EXEC sp_executesql @sql;

-- Reset the @sql variable
SET @sql = N'';

-- Generate DROP TABLE statements for each table in the database
SELECT @sql += 'DROP TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ';'
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id;

-- Execute the generated DROP TABLE statements
EXEC sp_executesql @sql;