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
('�r��'),
('���ȭ�������q'),
('���ֺ������D'),
('�ǲߤu��'),
('���Ϋ~'),
('�ҵ{���'),
('�Ш|�n��');



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
('�^�~�r��', 300, '�������^�~�r��', 50, 1, 'VISIBLE', SYSDATETIME(), NULL),
('���ȭ�������q - ��F��', 500, '���ȭ���ҥ������q', 30, 2, 'VISIBLE', SYSDATETIME(), NULL),
('���ֺ����K���V�m', 1000, '���֦ҸձK���V�m���', 20, 3, 'VISIBLE', SYSDATETIME(), NULL),
('�q�l�Ѿ\Ū��', 1300, '���į�q�l�Ѿ\Ū��', 15, 4, 'VISIBLE', SYSDATETIME(), NULL),
('�h�\�൧�O��', 200, '�зN�h�\�൧�O��', 100, 5, 'VISIBLE', SYSDATETIME(), NULL),
('�u�W�ҵ{�q�\', 2000, '�@�~���u�W�ҵ{�q�\', 10, 6, 'VISIBLE', SYSDATETIME(), NULL),
('�ƾǽm�߳n��', 400, '���ʼƾǽm�߳n��', 25, 7, 'VISIBLE', SYSDATETIME(), NULL),
('�^�y��k�j��', 250, '�ԲӪ��^�y��k���n', 40, 1, 'VISIBLE', SYSDATETIME(), NULL),
('�ꤤ�ƾ����q', 350, '�ꤤ�ƾǭ��I���q', 35, 6, 'VISIBLE', SYSDATETIME(), NULL),
('�ǲ߭p�e��U', 150, '���Ī��ǲ߭p�e��U', 75, 4, 'VISIBLE', SYSDATETIME(), NULL);


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
('�s�~�S�f 60%OFF', 0.40),
('�¦�P���� 80%OFF', 0.20),
('���ʬP���@ 70%OFF', 0.30),
('�ǥͧ馩 95%OFF', 0.05),
('�K�u�S�� 88%OFF', 0.12),
('�L�u�S�� 92%OFF', 0.08),
('��u�S�� 90%OFF', 0.10),
('�V�u�S�� 85%OFF', 0.15),
('�g�~�y 82%OFF', 0.18),
('�|���M���u�f 75%OFF', 0.25);

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
(1, 300, 'CASH ON DELIVERY', '�x�_�������ϩ����F���@�q', 'TO BE PAID', SYSDATETIME(), NULL),
(2, 1000, 'CASH ON DELIVERY', '�s�_���O���Ϥ�Ƹ��G�q', 'PAID', SYSDATETIME(), NULL),
(3, 1000, 'CASH ON DELIVERY', '�x������ٰϥ��F�_�G��', 'SELLER CONFIRMED', SYSDATETIME(), NULL),
(4, 1300, 'CASH ON DELIVERY', '�x�n���F�ϱR�w���@�q', 'SHIPPING', SYSDATETIME(), NULL),
(5, 600, 'CASH ON DELIVERY', '���������s�Ϭ��N�F�|��', 'ARRIVED', SYSDATETIME(), NULL),
(6, 2000, 'CASH ON DELIVERY', '�x�_���H�q�ϰ򶩸��@�q', 'TO BE PAID', SYSDATETIME(), NULL),
(7, 800, 'CASH ON DELIVERY', '�s�˥��F�Ϥ�����G�q', 'PAID', SYSDATETIME(), NULL),
(8, 250, 'CASH ON DELIVERY', '�Ÿq����Ϥ�Ƹ��T�q', 'SELLER CONFIRMED', SYSDATETIME(), NULL),
(9, 700, 'CASH ON DELIVERY', '���ƥ����s���G�q', 'SHIPPING', SYSDATETIME(), NULL),
(10, 150, 'CASH ON DELIVERY', '�x�F���������|�q', 'ARRIVED', SYSDATETIME(), NULL);

