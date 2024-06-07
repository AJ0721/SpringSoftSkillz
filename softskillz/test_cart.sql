SELECT * FROM product_category;
SELECT * FROM test_product;
SELECT * FROM image_url;
SELECT * FROM cart_item;
SELECT * FROM test_order
SELECT * FROM voucher
SELECT * FROM order_item;

DROP TABLE order_item;
DROP TABLE test_order;
DROP TABLE voucher;
DROP TABLE cart_item;
DROP TABLE image_url;
DROP TABLE test_product;
DROP TABLE product_category; 

CREATE TABLE product_category(
  product_category_id INT PRIMARY KEY IDENTITY(1,1),
  product_category_name NVARCHAR (50) NOT NULL,
  CONSTRAINT UQ_product_category_name UNIQUE(product_category_name)
  );


INSERT INTO product_category (product_category_name) VALUES 
('字典'),
('公務員國考講義'),
('托福滿分秘笈'),
('學習工具'),
('文具用品'),
('課程資料'),
('教育軟體');



CREATE TABLE test_product(
  product_id INT PRIMARY KEY IDENTITY(1,1),
  product_name NVARCHAR(50) NOT NULL,
  price DECIMAL(7,2) NOT NULL,
  description_text NVARCHAR(500) NOT NULL,
  stock INT NOT NULL,
  product_category_id INT NOT NULL,
  product_status NVARCHAR(20) CHECK(product_status IN ('VISIBLE', 'LOCKED', 'DELETED')) DEFAULT 'VISIBLE' NOT NULL, 
  create_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  update_at DATETIME2 NULL,
  CONSTRAINT FK_product_category FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id),
  INDEX IX_product_name NONCLUSTERED (product_name),
  INDEX IX_product_category_id NONCLUSTERED (product_category_id)
);
--use full text scan CONTAINS(table, column, number of rows) to replace LIKE %STRING% query

INSERT INTO test_product (product_name, price, description_text, stock, product_category_id, product_status, create_at, update_at) VALUES
('英漢字典', 300, '全面的英漢字典', 50, 1, 'VISIBLE', SYSDATETIME(), NULL),
('公務員國考講義 - 行政學', 500, '公務員國考必備講義', 30, 2, 'VISIBLE', SYSDATETIME(), NULL),
('托福滿分密集訓練', 1000, '托福考試密集訓練資料', 20, 3, 'VISIBLE', SYSDATETIME(), NULL),
('電子書閱讀器', 1300, '高效能電子書閱讀器', 15, 4, 'VISIBLE', SYSDATETIME(), NULL),
('多功能筆記本', 200, '創意多功能筆記本', 100, 5, 'VISIBLE', SYSDATETIME(), NULL),
('線上課程訂閱', 2000, '一年的線上課程訂閱', 10, 6, 'VISIBLE', SYSDATETIME(), NULL),
('數學練習軟體', 400, '互動數學練習軟體', 25, 7, 'VISIBLE', SYSDATETIME(), NULL),
('英語文法大全', 250, '詳細的英語文法指南', 40, 1, 'VISIBLE', SYSDATETIME(), NULL),
('國中數學講義', 350, '國中數學重點講義', 35, 6, 'VISIBLE', SYSDATETIME(), NULL),
('學習計畫手冊', 150, '有效的學習計畫手冊', 75, 4, 'VISIBLE', SYSDATETIME(), NULL);


CREATE TABLE image_url(
  image_url_id INT PRIMARY KEY IDENTITY(1,1),
  image_url NVARCHAR(MAX) NULL,
  product_id INT NOT NULL,
  CONSTRAINT FK_image_product FOREIGN KEY (product_id) REFERENCES test_product(product_id)
);

INSERT INTO image_url (image_url, product_id) VALUES 
('https://www.9x9.tw/public/files/product/235056284060.jpg', 1),
('https://cdn1.kingstone.com.tw/book/images/product/20180/2018052798903/2018052798903-02.jpg?v=eaed9', 1),
('https://cdnec.sanmin.com.tw/product_images/986/986630633.jpg', 2),
('https://cdnec.sanmin.com.tw/tryread/big/986/986630633_b1.jpg', 2),
('https://cdnec.sanmin.com.tw/product_images/957/957439141.jpg', 3),
('https://cdnec.sanmin.com.tw/product_images/957/957438196.jpg', 3),
('https://i3.momoshop.com.tw/1693169011/goodsimg/0009/929/998/9929998_R.webp', 4),
('https://www.9x9.tw/public/files/product/thumb/230016269539.jpg', 5),
('https://teaches.cc/blog/wp-content/uploads/2021/08/049845e6-2e27-f8c3-dc9b-6a74efe46f9b.png', 6),
('https://ws.moe.edu.tw/001/Upload/photoedittemp/a0ad1235-d474-4f80-ab72-1589177d74e5.png', 7),
('https://cdn1.kingstone.com.tw/book/images/product/20180/2018052934615/2018052934615b.jpg', 8),
('https://cdn1.kingstone.com.tw/book/images/product/20152/2015214876523/2015214876523b.jpg', 9),
('https://cdn1.kingstone.com.tw/book/images/product/20152/2015250073719/2015250073719b.jpg', 10);


--line item, not physical individual item
CREATE TABLE order_item(
  order_item_id INT PRIMARY KEY IDENTITY(1,1),
  product_id INT NOT NULL,
  order_id INT NOT NULL,
  price DECIMAL(7,2) NOT NULL,
  quantity INT NOT NULL,
  item_subtotal AS (quantity*price) PERSISTED,
  CONSTRAINT FK_order_item_product FOREIGN KEY (product_id) REFERENCES test_product(product_id),
  CONSTRAINT FK_order_item_order FOREIGN KEY (order_id) REFERENCES test_order(order_id)
  );

INSERT INTO order_item (product_id, order_id, price, quantity) VALUES 
(1, 1, 300, 1),
(2, 2, 500, 2),
(3, 3, 1000, 1),
(4, 4, 1300, 1),
(5, 5, 200, 3),
(6, 6, 2000, 1),
(7, 7, 400, 2),
(8, 8, 250, 1),
(9, 9, 350, 2),
(10, 10, 150, 1);



CREATE TABLE cart_item(
  cart_item_id INT PRIMARY KEY IDENTITY(1,1),
  student_id INT NOT NULL,
  product_id INT NOT NULL,
  price DECIMAL(7,2) NOT NULL,
  quantity INT NOT NULL,
  item_subtotal AS (quantity*price) PERSISTED,
  CONSTRAINT FK_cart_item_product FOREIGN KEY (product_id) REFERENCES test_product(product_id),
  CONSTRAINT FK_cart_student FOREIGN KEY (student_id) REFERENCES student(student_id)

  );

INSERT INTO cart_item (student_id, product_id, price, quantity) VALUES 
(1, 1, 300, 1),
(2, 2, 500, 2),
(3, 3, 1000, 1),
(4, 4, 1300, 10),
(5, 5, 200, 3),
(6, 6, 2000, 1),
(7, 7, 400, 2),
(8, 8, 250, 1),
(9, 9, 350, 2),
(10, 10, 150, 1);

CREATE TABLE voucher(
  voucher_id INT PRIMARY KEY IDENTITY(1,1),
  voucher_name NVARCHAR(50) NOT NULL,
  voucher_value DECIMAL(3,2) NOT NULL,
);

alter table voucher
drop column order_id

INSERT INTO voucher (voucher_name, voucher_value) VALUES 
('新年特惠 60%OFF', 0.40),
('黑色星期五 80%OFF', 0.20),
('網購星期一 70%OFF', 0.30),
('學生折扣 95%OFF', 0.05),
('春季特賣 88%OFF', 0.12),
('夏季特賣 92%OFF', 0.08),
('秋季特賣 90%OFF', 0.10),
('冬季特賣 85%OFF', 0.15),
('週年慶 82%OFF', 0.18),
('會員專屬優惠 75%OFF', 0.25);

CREATE TABLE test_order(
  order_id INT PRIMARY KEY IDENTITY(1,1),
  student_id INT NOT NULL,
  order_subtotal DECIMAL(7,2) NOT NULL, 
  payment_method NVARCHAR (20) NOT NULL DEFAULT 'CASH ON DELIVERY',
  shipping_address NVARCHAR (256) NOT NULL,
  order_status NVARCHAR(20) CHECK(order_status IN ('TO BE PAID', 
  'PAID', 'SELLER CONFIRMED', 'SHIPPING', 'ARRIVED', 'COMPLETED', 'CANCELLED')) DEFAULT 'TO BE PAID' NOT NULL,
  create_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  update_at DATETIME2 NULL,
  voucher_id INT NULL,
  CONSTRAINT FK_order_student FOREIGN KEY (student_id) REFERENCES student(student_id),
  CONSTRAINT FK_order_voucher FOREIGN KEY (voucher_id) REFERENCES voucher(voucher_id),
  INDEX order_student_id NONCLUSTERED (student_id) 
);

INSERT INTO test_order (student_id, order_subtotal, payment_method, shipping_address, order_status, create_at, update_at) VALUES 
(1, 300, 'CASH ON DELIVERY', '台北市中正區忠孝東路一段', 'TO BE PAID', SYSDATETIME(), NULL),
(2, 1000, 'CASH ON DELIVERY', '新北市板橋區文化路二段', 'PAID', SYSDATETIME(), NULL),
(3, 1000, 'CASH ON DELIVERY', '台中市西屯區市政北二路', 'SELLER CONFIRMED', SYSDATETIME(), NULL),
(4, 1300, 'CASH ON DELIVERY', '台南市東區崇德路一段', 'SHIPPING', SYSDATETIME(), NULL),
(5, 600, 'CASH ON DELIVERY', '高雄市鼓山區美術東四路', 'ARRIVED', SYSDATETIME(), NULL),
(6, 2000, 'CASH ON DELIVERY', '台北市信義區基隆路一段', 'TO BE PAID', SYSDATETIME(), NULL),
(7, 800, 'CASH ON DELIVERY', '新竹市東區公園路二段', 'PAID', SYSDATETIME(), NULL),
(8, 250, 'CASH ON DELIVERY', '嘉義市西區文化路三段', 'SELLER CONFIRMED', SYSDATETIME(), NULL),
(9, 700, 'CASH ON DELIVERY', '彰化市中山路二段', 'SHIPPING', SYSDATETIME(), NULL),
(10, 150, 'CASH ON DELIVERY', '台東市中興路四段', 'ARRIVED', SYSDATETIME(), NULL);

