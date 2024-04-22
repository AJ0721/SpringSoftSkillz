

----會員
CREATE TABLE teacher (
 teacher_id INT IDENTITY(1,1) PRIMARY KEY,
 teacher_first_name NVARCHAR(50) NOT NULL,
 teacher_last_name NVARCHAR(50) NOT NULL,
 teacher_username VARCHAR(50) UNIQUE NOT NULL,
 teacher_registration_date DATETIME2 DEFAULT GETDATE(),
 teacher_gender VARCHAR(30) CHECK (teacher_gender IN ('male', 'female', 'unspecified')) NOT NULL,
 teacher_birth DATETIME2 NOT NULL,
 teacher_mobile NVARCHAR(50) UNIQUE NOT NULL,
 teacher_email NVARCHAR(100) UNIQUE NOT NULL,
 teacher_password VARCHAR(50) NOT NULL,
 teacher_country NVARCHAR(50) NOT NULL,
 teacher_photo VARCHAR(255),
 subject NVARCHAR(100) NOT NULL,
 experience NVARCHAR(50) NOT NULL,
 status VARCHAR(20) CHECK (status IN ('full_time', 'part_time')) NOT NULL,
 teacher_education NVARCHAR(50) NOT NULL,
 certification NVARCHAR(255),
 teach_time NVARCHAR(50) NOT NULL,
 strength NVARCHAR(255) NOT NULL,
 teacher_forum_status INT CHECK (teacher_forum_status IN (0, 1)) DEFAULT 0,
 teacher_course_status INT CHECK (teacher_course_status IN (0, 1))DEFAULT 0,
 teacher_id_formatted AS ('t' + CAST(teacher_id AS NVARCHAR(10))),
);

INSERT INTO teacher VALUES('汶安','熊','123456','20200101','male','19950402','091234567','123@123','123456','彎彎','img/gege.jpg','全',4,'full_time','國中','無','50','少一個腎',0,0);
--任萱資料(論壇功能所需)
INSERT INTO teacher (teacher_first_name, teacher_last_name, teacher_username, teacher_gender, teacher_birth, teacher_mobile, 
	teacher_email, teacher_password, teacher_country, subject, experience, status, teacher_education, certification, teach_time, strength) 
VALUES 
	('James', 'Miller', 't1', 'male', '1980-05-10', '+15005551001', 'james.miller@example.com', '111', 'USA', 'Mathematics', 
		'10 Years', 'full_time', 'PhD', 'Math Teaching Certification', 'Mornings', 'Problem Solving and Critical Thinking'),
	('Samantha', 'Davis', 't2', 'female', '1985-08-25', '+15005552002', 'samantha.davis@example.com', '222', 'Canada', 'Physics', 
		'8 Years', 'part_time', 'Masters', 'Physics Teaching Certification', 'Afternoons', 'Experimental Physics and Lab Work'),
	('Alex', 'Taylor', 't3', 'unspecified', '1978-11-02', '+15005553003', 'alex.taylor@example.com', '333', 'UK', 'Chemistry', 
		'12 Years', 'full_time', 'PhD', 'Chemistry Teaching Certification', 'Evenings', 'Organic Chemistry and Research');

CREATE TABLE admin (
   admin_id INT IDENTITY(1,1) PRIMARY KEY,
   admin_account NVARCHAR(30) UNIQUE NOT NULL,
   admin_password NVARCHAR(30) NOT NULL,
   admin_level INT NULL
);

INSERT INTO admin VALUES('aaa','123',0)




CREATE TABLE student (
  student_id INT IDENTITY(1,1) PRIMARY KEY,
  student_first_name NVARCHAR(50) NOT NULL,
  student_last_name NVARCHAR(50) NOT NULL,
  student_username VARCHAR(50) UNIQUE NOT NULL,
  student_nickname NVARCHAR(50) UNIQUE,
  student_registration_date DATETIME2 DEFAULT GETDATE(),
  student_gender NVARCHAR(30) CHECK (student_gender IN ('Male', 'Female', 'Unspecified')) NOT NULL,
  student_birth DATETIME2 NOT NULL,
  student_mobile NVARCHAR(50) UNIQUE NOT NULL,
  student_email NVARCHAR(100) UNIQUE NOT NULL,
  student_password VARCHAR(50) NOT NULL,
  student_country NVARCHAR(50),
  student_photo VARCHAR(255), -- Adjusted length for file path
  student_education NVARCHAR(50),
  student_forum_status INT CHECK (student_forum_status IN (0, 1)) DEFAULT 0,
  student_course_status INT CHECK (student_course_status IN (0, 1)) DEFAULT 0,
  first_language NVARCHAR(50),
  learning_frequency NVARCHAR(100),
  student_id_formatted AS ('s' + CAST(student_id AS NVARCHAR(10))),
);

INSERT INTO student VALUES('成圓','羅','123456','阿瘸','20200101','male','19920716','091234567','123@123','123456','彎彎','img/roger.jpg','大學',0,0,'中文','每週1-3次')
--任萱資料(論壇功能所需)
INSERT INTO student (student_first_name, student_last_name, student_username, student_nickname, student_gender, student_birth, 
	student_mobile, student_email, student_password, student_country, student_education, first_language, learning_frequency) 
VALUES 
	('Alice', 'Johnson', 's1', 'Ally', 'Female', '2001-02-03', 
		'+15005550006', 'alice.johnson@example.com', '111', 'USA', 'Undergraduate', 'English', 'Occasionally'),
	('Brian', 'Walker', 's2', 'Bri', 'Male', '2002-03-04', 
		'+15005550007', 'brian.walker@example.com', '222', 'Canada', 'Graduate', 'French', 'Regularly'),
	('Caitlyn', 'Smith', 's3', 'Catie', 'Unspecified', '2003-04-05', 
		'+15005550008', 'caitlyn.smith@example.com', '333', 'UK', 'Postgraduate', 'English', 'Daily');



----課程

CREATE TABLE course ( 
course_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
teacher_id INT NOT NULL, 
course_name VARCHAR(100) NOT NULL,
course_info NVARCHAR(MAX) NOT NULL,
course_category VARCHAR(50) NOT NULL,
course_price INT NOT NULL
FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);​​


INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price) VALUES(1,'高中國文','窩不知道PEKO','國文',1500)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price)VALUES(1,'高中數學','窩不知道PEKO','數學',1600)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price)VALUES(1,'國中國文','窩不知道PEKO','國文',1000)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price)VALUES(1,'高中英文','窩不知道PEKO','英文',1700)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price) VALUES(1,'JAVA','從入門到放棄','程式',2000)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price) VALUES(1,'C#','窩不知道PEKO','程式',1900)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price) VALUES(1,'國中數學','窩不知道PEKO','數學',1300)
INSERT INTO course (teacher_id,course_name,course_info,course_category,course_price) VALUES(1,'高中歷史','窩不知道PEKO','歷史',1200)



---課程訂單

CREATE TABLE corder(
order_id NVARCHAR(200) NOT NULL PRIMARY KEY,
student_id INT NOT NULL,
order_price INT NOT NULL,
order_date DATETIME2 NOT NULL,
payment_method VARCHAR(50) NOT NULL,
order_status VARCHAR(50) NOT NULL,
FOREIGN KEY (student_id) REFERENCES student(student_id),
);

INSERT INTO corder VALUES('123',1,1233,'20240301','123','已付款')
INSERT INTO corder VALUES('1231',1,1233,'20240307','123','已付款')
INSERT INTO corder VALUES('1232',1,1233,'20240309','123','已付款')
INSERT INTO corder VALUES('1233',1,1233,'20240501','123','已付款')
INSERT INTO corder VALUES('1',1,1500,'20240319','linepay','已付款')



CREATE TABLE corderitem(
item_id INT IDENTITY(1,1) NOT NULL  PRIMARY KEY,
order_id NVARCHAR(200) NOT NULL , 
course_id INT NOT NULL,
course_price INT NOT NULL,
qty INT NOT NULL,
item_status INT  NULL  DEFAULT 0,
FOREIGN KEY (order_id) REFERENCES corder(order_id),
FOREIGN KEY (course_id) REFERENCES course(course_id),
);

INSERT INTO corderitem VALUES('1','2',1500,1,0)



SELECT * from course

TRUNCATE TABLE course


---學伴
--資料表1 learning_companion
CREATE TABLE learning_companion(
	companion_id INT IDENTITY PRIMARY KEY,
	student_id INT not null,
	companion_username NVARCHAR(50) not null,
	companion_gender VARCHAR(20) CHECK (companion_gender IN ('Male', 'Female', 'Unspecified')) not null,
	companion_birth DATETIME2 not null,
	companion_first_language NVARCHAR(50) not null,
	companion_speaking_language NVARCHAR(100) not null,
	companion_learning_interest NVARCHAR(50) not null,
	companion_learning_frequency NVARCHAR(50) CHECK (companion_learning_frequency IN ('每週1-3次','每週4-7次')) not null,
	companion_photo VARCHAR(200) not null,
);

INSERT INTO [learning_companion] ([student_id], [companion_username], [companion_gender], [companion_birth], [companion_first_language], [companion_speaking_language], [companion_learning_interest], [companion_learning_frequency], [companion_photo])
VALUES 
(1003, 'Wendy', 'Female', '1999-01-02 00:00:00.0000000', '日文', '英文', '程式設計', '每週4-7次', 'Companion/CompanionImg/Wendy.jpg'),
(1004, 'Joe', 'Male', '1996-02-03 00:00:00.0000000', '中文', '英文', '程式設計', '每週1-3次', 'Companion/CompanionImg/Joe.jpg'),
(1005, 'Cindy', 'Female', '2002-12-06 00:00:00.0000000', '中文', '日文', '電腦繪圖', '每週1-3次', 'Companion/CompanionImg/Cindy.jpg'),
(1007, 'Chris', 'Male', '2003-05-25 00:00:00.0000000', '日文', '中文', '語言學習', '每週1-3次', 'Companion/CompanionImg/Chris.jpg'),
(1006, 'Lily', 'Female', '1998-10-20 00:00:00.0000000', '英文', '英文', '語言學習', '每週4-7次', 'Companion/CompanionImg/Lily.jpg'),
(1008, 'David', 'Male', '1995-08-18 00:00:00.0000000', '英文', '中文', '電腦繪圖', '每週4-7次', 'Companion/CompanionImg/David.jpg');

-- 資料表2 加PK companion_match 已配對學伴
CREATE TABLE companion_match (
    match_id INT IDENTITY PRIMARY KEY not null,
    fk_student_a_id INT,
    fk_student_b_id INT,
    FOREIGN KEY (fk_student_a_id) REFERENCES learning_companion(companion_id),
    FOREIGN KEY (fk_student_b_id) REFERENCES learning_companion(companion_id),
);




----商品

-- 資料表1: product_category 商品分類表
CREATE TABLE product_category (
   product_category_id INT IDENTITY PRIMARY KEY,
   product_category_name NVARCHAR(50) NOT NULL,
   product_category_description NVARCHAR(400)
);

INSERT INTO product_category (product_category_name, product_category_description) 
VALUES
('教材影片', '提供各類教育影片，包括語言學習、專業科目深入講解、音樂教學、運動指導及生活技能等'),
('實體教材', '精選實體書籍和教材，涵蓋多個學習領域的基礎與進階知識'),
('周邊商品', '與學習相關的周邊商品，旨在提升學習效率和學習體驗');


-- 資料表2: product 商品表
CREATE TABLE product (
    product_id INT IDENTITY PRIMARY KEY,
    product_category_id INT NOT NULL,
    product_name NVARCHAR(50) NOT NULL,
    product_description NVARCHAR(1000),
    product_price INT NOT NULL,
    product_stock INT,
    product_image_url NVARCHAR(200)  NULL,  
    product_target_audience NVARCHAR(100),
    product_create_date DATETIME2,
    product_update_date DATETIME2,
    FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);

INSERT INTO product (product_category_id, product_name, product_description, product_price, product_stock, product_image_url, product_target_audience, product_create_date, product_update_date)
VALUES
((SELECT product_category_id FROM product_category WHERE product_category_name = '教材影片'), '2024 Python全攻略', '面向初學者的Python學習基礎課程', 2090, NULL, 'Mall/MallImg/Pythonbeginner.jpg', '初學者', '2024-01-01', '2024-02-15'),
((SELECT product_category_id FROM product_category WHERE product_category_name = '教材影片'), '2024 網頁全端開發', '深入淺出的網頁開發課程', 2090, NULL, 'Mall/MallImg/WebDevfullstack.jpg', '初學者至中級開發者', '2024-01-08', '2024-03-20'),
((SELECT product_category_id FROM product_category WHERE product_category_name = '實體教材'), '來學日本語上級', '適合有基礎的學生準備JLPT N1的教材', 288, 3, 'Mall/MallImg/JapaneseAdvanced.jpg', '中級至高級學習者', '2024-02-11', '2024-04-05'),
((SELECT product_category_id FROM product_category WHERE product_category_name = '實體教材'), '新制多益單字大全', '全面覆蓋新制多益考試的單字大全', 394, 10, 'Mall/MallImg/TOEICVocab.jpg', '多益考生', '2024-02-19', '2024-04-08'),
((SELECT product_category_id FROM product_category WHERE product_category_name = '周邊商品'), '軟線圈筆記本', '高質感的筆記本，適合日常記錄與學習使用', 304, 31, 'Mall/MallImg/SoftRingNotebook.jpg', '學生與上班族', '2024-01-11', '2024-01-30'),
((SELECT product_category_id FROM product_category WHERE product_category_name = '周邊商品'), '2024春季文具特惠組', '春季限定文具套裝，包含筆記本、筆和其他辦公用品', 199, 5, 'Mall/MallImg/SpringStationerySet.jpg', '學生與上班族', '2024-02-22', '2024-02-23');


----商品訂單

CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1, 1),
    student_id INT NOT NULL FOREIGN KEY REFERENCES student(student_id),
    order_date DATE NOT NULL,
    total_amount INT NOT NULL,
    order_status NVARCHAR(50) DEFAULT N'未付款',
    payment_method NVARCHAR(10) DEFAULT NULL,
    shipment_date DATE DEFAULT NULL,
    shipment_status NVARCHAR(50) NULL, 
    shipping_address NVARCHAR(100) NOT NULL
);

CREATE TABLE orderitem (
    order_item_id INT PRIMARY KEY IDENTITY(1, 1),
    order_id INT NOT NULL FOREIGN KEY REFERENCES orders(order_id),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    product_price INT NOT NULL,
    sub_total INT NOT NULL
);
INSERT INTO orders
    (student_id, order_date, total_amount, order_status, shipment_date, shipping_address)
VALUES
    (1, '2024-03-20', 1000,'支付成功','2024-03-25','地址1')


--論壇

CREATE TABLE forum_category (
    forum_category_id INT PRIMARY KEY IDENTITY(1,1),
    forum_category_name NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_category_name UNIQUE (forum_category_name)
);

INSERT INTO forum_category(forum_category_name)
VALUES
('Programming'),
('Languages'),
('Art'),
('Music');

SELECT*FROM forum_category
ORDER BY forum_category_id;


CREATE TABLE forum_thread (
    thread_id INT PRIMARY KEY IDENTITY(1,1),
    forum_category_id INT,
	thread_student_id INT NULL,
	thread_teacher_id INT NULL,
	thread_title VARCHAR(255) NOT NULL,
    thread_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    thread_content NVARCHAR(4000) NOT NULL,
    thread_upvote_count INT,
    thread_response_count INT,
    thread_status VARCHAR(20) CHECK (thread_status IN ('VISIBLE', 'LOCKED', 'DELETED')) NOT NULL,
	CONSTRAINT FK_thread_category FOREIGN KEY(forum_category_id) REFERENCES forum_category(forum_category_id),
    CONSTRAINT FK_thread_student_id FOREIGN KEY(thread_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_thread_teacher_id FOREIGN KEY(thread_teacher_id) REFERENCES teacher(teacher_id)
);


-- Revised thread insertions with updated response counts
INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(1, 1, NULL, 'Title1 (s1)', 'Thread Content 1 (s1)', 'VISIBLE', 42, 3);

INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(2, NULL, 1, 'Title2 (t1)', 'Thread Content 2 (t1)', 'LOCKED', 35, 3);

INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(3, 2, NULL, '文章標題3 (s2)', '主文內容3 (s2)', 'VISIBLE', 58, 3);

INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(4, NULL, 2, '文章標題4 (t2)', '主文內容4 (t2)', 'VISIBLE', 47, 3);

INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(1, 3, NULL, 'Title5(s3)', 'Thread Content 5 (s3)', 'DELETED', 22, 3);

SELECT* FROM forum_thread;


CREATE TABLE forum_post (
    post_id INT PRIMARY KEY IDENTITY(1,1),
	post_student_id INT,
	post_teacher_id INT,
	thread_id INT,
    parent_post_id INT,
    post_content NVARCHAR(1200) NOT NULL,
    post_upvote_count INT,
	post_response_count INT, 
    post_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    post_status VARCHAR(10) CHECK (post_status IN ('VISIBLE', 'MODERATED', 'DELETED')) NOT NULL,
    CONSTRAINT FK_thread_id FOREIGN KEY(thread_id) REFERENCES forum_thread(thread_id),
	CONSTRAINT FK_post_creator1 FOREIGN KEY(post_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_post_creator2 FOREIGN KEY(post_teacher_id) REFERENCES teacher(teacher_id),
	CONSTRAINT FK_post_parent_post FOREIGN KEY (parent_post_id) REFERENCES forum_post(post_id),
	CONSTRAINT CHK_post_hierarchy CHECK (parent_post_id IS NULL OR parent_post_id <> post_id),
);

-- First post for Thread ID 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 1, NULL, 'Post Content 1 (s1)', 10, 0, 'VISIBLE');

-- Second post for Thread ID 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 1, NULL, 'Post Content 2 (s3)', 15, 1, 'VISIBLE');

-- Replies to the second post for Thread ID 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 1, 2, 'Reply 1 to Post Content 2 (s1)', 20, 1, 'VISIBLE');

INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 1, 3, 'Reply to Reply 1 to Post Content 2 (s1)', 5, 0, 'VISIBLE');

-- First post for Thread ID 2
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 2, NULL, 'Post Content 1 (t1)', 12, 0, 'VISIBLE');

-- Second post for Thread ID 2
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 2, NULL, 'Post Content 2 (t1)', 18, 1, 'VISIBLE');

-- Replies to the second post for Thread ID 2
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 2, 6, 'Reply 1 to Post Content 2 (t2)', 22, 1, 'VISIBLE');

INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 2, 7, 'Reply to Reply 1 to Post Content 2 (t2)', 9, 0, 'VISIBLE');

-- First post for Thread ID 3
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 3, NULL, '回文內容1 (s2)', 14, 0, 'VISIBLE');

-- Second post for Thread ID 3
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 3, NULL, '回文內容2 (s2)', 17, 1, 'VISIBLE');

-- Replies to the second post for Thread ID 3
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 3, 10, '回覆回文內容2 (s2)', 21, 1, 'VISIBLE');

INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 3, 11, '二次回覆回文內容2 (s2)', 8, 0, 'VISIBLE');

-- First post for Thread ID 4
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 4, NULL, '回文內容1 (t2)', 13, 0, 'VISIBLE');

-- Second post for Thread ID 4
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 4, NULL, '回文內容2 (t2)', 16, 1, 'VISIBLE');

-- Replies to the second post for Thread ID 4
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 4, 14, '回覆回文內容2 (t2)', 19, 1, 'VISIBLE');

INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 4, 15, '二次回覆回文內容2 (t2)', 6, 0, 'VISIBLE');

-- First post for Thread ID 5
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 5, NULL, 'Post Content 1 (s3)', 11, 0, 'VISIBLE');

-- Second post for Thread ID 5
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 5, NULL, 'Post Content 2 (s3)', 20, 1, 'VISIBLE');

-- Replies to the second post for Thread ID 5
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 5, 18, 'Reply 1 to Post Content 2 (s3)', 23, 1, 'VISIBLE');

INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 5, 19, 'Reply to Reply 1 to Post Content 2 (s3)', 10, 0, 'VISIBLE');


SELECT* FROM forum_post;





