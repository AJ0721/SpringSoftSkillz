--會員
--管理員
CREATE TABLE admin (
   admin_id INT IDENTITY(1,1) PRIMARY KEY,
   admin_account NVARCHAR(30) UNIQUE NOT NULL,
   admin_password NVARCHAR(30) NOT NULL,
   admin_level INT NULL
);

INSERT INTO admin VALUES('aaa','123',0)
SELECT * FROM admin;

--學生
CREATE TABLE student (
  student_id INT IDENTITY(1,1) PRIMARY KEY,
  student_first_name NVARCHAR(50) NOT NULL,
  student_last_name NVARCHAR(50) NOT NULL,
  student_username VARCHAR(50) UNIQUE NOT NULL,
  student_nickname NVARCHAR(50) null,
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

--老師
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



--學生忘記密碼
CREATE TABLE s_forgotpwd(
id INT IDENTITY(1,1) PRIMARY KEY,
s_id INT NOT NULL,
token VARCHAR(max) NOT NULL,
student_registration_date DATETIME2 NOT NULL
FOREIGN KEY (s_id) REFERENCES student(student_id)
)

--老師忘記密碼
CREATE TABLE t_forgotpwd(
id INT IDENTITY(1,1) PRIMARY KEY,
t_id INT NOT NULL,
token VARCHAR(max) NOT NULL,
teacher_registration_date DATETIME2 NOT NULL
FOREIGN KEY (t_id) REFERENCES teacher(teacher_id)
)

--課程

CREATE TABLE course
(
    course_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    teacher_id INT NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    course_info NVARCHAR(MAX) NOT NULL,
    course_category NVARCHAR(100) NOT NULL,
    course_price INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);


-- 教師開課課程行事曆資料表(一天一筆資料=一個日期對應一個開課時段)
CREATE TABLE teacher_schedule
(
    teacher_schedule_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    teacher_id INT NOT NULL,
    course_date DATE NOT NULL,
    teacher_time_slots VARCHAR(24) NOT NULL,
    --開課時段(將一天用1小時區分24個單位) 
    -- 0:未開放預約 1:開放預約 2:已被預約
    --222222220000001111110000
    --0:00~7:59無法預約；8:00~13:59、20:00~23:59未開放預約；14:00~19:59開放預約 
    --每筆studentReservation成立,皆對teacherTimeSlot進行CRUD
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);



-- 學生預約單一課程之時段的資料表(一個課程一個預約資料、一個日期可能多筆訂單資料)
CREATE TABLE student_reservation
(
    reservation_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    course_id INT NOT NULL,--可以在畫面顯示教師編號、課程名稱
    teacher_schedule_id INT NOT NULL,--之後要去教師行事曆改時段,可以顯示課程日期
    reservation_date DATE NOT NULL,--新增該筆預約資料的日期
    student_id INT NOT NULL,
    student_time_slots VARCHAR(24) NOT NULL,
    --0:沒預約 1:選擇預約
    --000000000000001111100000
    --選擇預約20:00~23:59的時段 
    total_hours INT NOT NULL,--抓選了幾個student_time_slots
	zoom_meeting_url VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (teacher_schedule_id) REFERENCES teacher_schedule(teacher_schedule_id)
);



-- 學生行事曆資料表(選完課之後呈現的不同課程時段集合資料表)
-- 同一個上課日期可能有不同課程
-- 一個日期一筆資料
CREATE TABLE student_schedule
(
    student_schedule_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    student_course_date DATE NOT NULL,--學生上課日期 做判斷 如果該學生編號在學生行事曆資料表沒有該筆日期(抓教師行事曆的課程日期)，就新增一筆，
    student_time_slots_all VARCHAR(MAX) NOT NULL,--當天不同課程總上課時段
    --'0-0-0-0-0-0-0-0-0-0-0-0-2-2-4-4-0-0-0-0-0-0-0-0'
    --不等於的部分是reservation-id
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);





--課程訂單
CREATE TABLE corder(
order_id NVARCHAR(200) NOT NULL PRIMARY KEY,
student_id INT NOT NULL,
order_price INT NOT NULL,
order_date DATETIME2 NOT NULL,
cancel_date DATETIME2 NOT NULL,
payment_method VARCHAR(50)  NULL,
order_status VARCHAR(50) NOT NULL,
discount_id varchar(255),
discount_percent DECIMAL(5,2) ,
after_price int ,
FOREIGN KEY (student_id) REFERENCES student(student_id),
);





--課程訂單細項
CREATE TABLE corderitem(
item_id INT IDENTITY(1,1) NOT NULL  PRIMARY KEY,
order_id NVARCHAR(200) NOT NULL , 
course_id INT NOT NULL,
course_price INT NOT NULL,
qty INT NOT NULL,
discount_percent DECIMAL(5,2) ,
after_price INT,
subtotal INT,
item_status INT  NULL  DEFAULT 0,
FOREIGN KEY (order_id) REFERENCES corder(order_id),
FOREIGN KEY (course_id) REFERENCES course(course_id),
);


--課程訂單折扣

CREATE TABLE coursediscount(
discount_id varchar(255) PRIMARY KEY NOT NULL,
discount_info VARCHAR(255) NOT NULL,
discount_percent DECIMAL(5,2) NOT NULL CHECK(discount_percent>0 AND discount_percent <=100),
start_date DATETIME2 NOT NULL,
end_date DATETIME2 NOT NULL
);




--教師學生聊天室
create table coursechatroom(
chatroom_id nvarchar(100) NOT NULL primary key,
senduser nvarchar(50) NOT NULL,
receiveuser nvarchar(50) NOT NULL,
lasttime DATETIME2(3) not null
)

--教師學生聊天紀錄
CREATE TABLE coursechat(
id INT IDENTITY(1,1) NOT NULL primary key,
chatroom_id nvarchar(100) NOT NULL,
senduser nvarchar(50) NOT NULL,
msg nvarchar(max)  not null,
sendtime DATETIME2(3) not null
)


--商城
--(商品表)
CREATE TABLE product
(
    product_id         INT            NOT NULL PRIMARY KEY IDENTITY(1,1),
    product_name       NVARCHAR(128)  NOT NULL,
    category           NVARCHAR(32)   NOT NULL,
    image_url          NVARCHAR(256)  NOT NULL,
    price              DECIMAL(10, 2) NOT NULL,
    stock              INT                NULL,
    description        NVARCHAR(1024),
    created_date       DATETIME2       NOT NULL,
    last_modified_date DATETIME2       NOT NULL
);



--商城訂單
--商品訂單

-- 創建 orders 表
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(2001, 1),
    order_date DATETIME2 NOT NULL,
    total_amount INT NOT NULL,
    order_status NVARCHAR(50) DEFAULT N'未付款',
    payment_method NVARCHAR(10) DEFAULT NULL,
    shipment_date DATETIME2 DEFAULT NULL,
    shipment_status NVARCHAR(50) NULL,
    shipping_address NVARCHAR(255) NOT NULL,
    customer_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    postal_code NVARCHAR(10) NOT NULL,
    notes NVARCHAR(255) NULL
);


-- 創建 orderitem 表
CREATE TABLE orderitem (
    order_item_id INT PRIMARY KEY IDENTITY(1, 1),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
	product_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    product_price INT NOT NULL,
    sub_total INT NOT NULL
);




--學伴

--資料表1 learning_companion

CREATE TABLE learning_companion(
	companion_id INT IDENTITY PRIMARY KEY,
	student_id INT not null,
	companion_first_language NVARCHAR(50) null,
	companion_speaking_language NVARCHAR(100) null,
	companion_learning_interest NVARCHAR(50) null,
	companion_learning_frequency NVARCHAR(50) CHECK (companion_learning_frequency IN ('每週1-3次','每週4-7次','')) null,
	companion_about_me NVARCHAR(300) null,
	companion_photo VARCHAR(300) null,
	FOREIGN KEY (student_id) REFERENCES student(student_id),
);


-- 資料表2 companion_match 已配對學伴
CREATE TABLE companion_match (
    match_id INT IDENTITY PRIMARY KEY not null,
    fk_student_a_id INT,
    fk_student_b_id INT,
	match_request VARCHAR(10) CHECK (match_request IN ('Yes', 'No')) not null,
    FOREIGN KEY (fk_student_a_id) REFERENCES learning_companion(companion_id),
    FOREIGN KEY (fk_student_b_id) REFERENCES learning_companion(companion_id),
);



--論壇
CREATE TABLE forum_category (
    forum_category_id INT PRIMARY KEY IDENTITY(1,1),
    forum_category_name NVARCHAR(100) NOT NULL,
	forum_category_description NVARCHAR(1000) NULL,
    CONSTRAINT UQ_category_name UNIQUE (forum_category_name)
);



CREATE TABLE forum_thread (
    thread_id INT PRIMARY KEY IDENTITY(1,1),
    forum_category_id INT NOT NULL,
	thread_student_id INT NULL,
	thread_teacher_id INT NULL,
	thread_admin_id INT NULL,
	thread_title VARCHAR(255) NOT NULL,
    thread_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    thread_content NVARCHAR(4000) NOT NULL,
    thread_upvote_count INT DEFAULT 0,
    thread_response_count INT DEFAULT 0,
    thread_status VARCHAR(20) CHECK (thread_status IN ('VISIBLE', 'EDITED', 'LOCKED', 'DELETED')) NOT NULL,
	CONSTRAINT FK_thread_category FOREIGN KEY(forum_category_id) REFERENCES forum_category(forum_category_id),
    CONSTRAINT FK_thread_student FOREIGN KEY(thread_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_thread_teacher FOREIGN KEY(thread_teacher_id) REFERENCES teacher(teacher_id),
	CONSTRAINT FK_thread_admin FOREIGN KEY(thread_admin_id) REFERENCES admin(admin_id)
);



CREATE TABLE forum_post (
    post_id INT PRIMARY KEY IDENTITY(1,1),
	post_student_id INT NULL,
	post_teacher_id INT NULL,
	post_admin_id INT NULL,
	thread_id INT NOT NULL,
    parent_post_id INT NULL,
    post_content NVARCHAR(1200) NOT NULL,
    post_upvote_count INT DEFAULT 0,
	post_response_count INT DEFAULT 0, 
    post_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    post_status VARCHAR(10) CHECK (post_status IN ('VISIBLE', 'EDITED', 'LOCKED', 'DELETED')) NOT NULL,
    CONSTRAINT FK_thread_id FOREIGN KEY(thread_id) REFERENCES forum_thread(thread_id) ON DELETE CASCADE,
	CONSTRAINT FK_post_creator1 FOREIGN KEY(post_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_post_creator2 FOREIGN KEY(post_teacher_id) REFERENCES teacher(teacher_id),
	CONSTRAINT FK_post_parent_post FOREIGN KEY (parent_post_id) REFERENCES forum_post(post_id) ON DELETE NO ACTION,
	CONSTRAINT CHK_post_hierarchy CHECK (parent_post_id IS NULL OR parent_post_id <> post_id),
);


CREATE TABLE forum_image (
    forum_image_id INT IDENTITY(1,1) PRIMARY KEY,
    thread_id INT NULL,
    post_id INT NULL,
    forum_image_path NVARCHAR(MAX),
    forum_image_upload_date DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    CONSTRAINT FK_image_thread_id FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id),
    CONSTRAINT FK_image_post_id FOREIGN KEY (post_id) REFERENCES forum_post(post_id)
);

--test購物車(延伸project)

CREATE TABLE product_category(
  product_category_id INT PRIMARY KEY IDENTITY(1,1),
  product_category_name NVARCHAR (50) NOT NULL,
  CONSTRAINT UQ_product_category_name UNIQUE(product_category_name)
);

CREATE TABLE test_product(
  product_id INT PRIMARY KEY IDENTITY(1,1),
  product_name NVARCHAR(50) NOT NULL,
  price DECIMAL(7,2) NOT NULL,
  description_text NVARCHAR(500) NOT NULL,
  stock INT NOT NULL,
  product_category_id INT NOT NULL,
  product_status NVARCHAR(20) CHECK(product_status IN ('VISIBLE', 'LOCKED', 'DELETED')) DEFAULT 'VISIBLE' NOT NULL, 
  image_id INT,
  create_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  update_at DATETIME2 NULL,
  CONSTRAINT FK_product_category FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id),
  INDEX IX_product_name NONCLUSTERED (product_name),
  INDEX IX_product_category_id NONCLUSTERED (product_category_id)
);
--use full text scan CONTAINS(table, column, number of rows) to replace LIKE %STRING% query


CREATE TABLE image_url(
  image_url_id INT PRIMARY KEY IDENTITY(1,1),
  image_url NVARCHAR(MAX) NULL,
  product_id INT NOT NULL,
  CONSTRAINT FK_image_product FOREIGN KEY (product_id) REFERENCES test_product(product_id)
);

CREATE TABLE voucher(
  voucher_id INT PRIMARY KEY IDENTITY(1,1),
  voucher_name NVARCHAR(50) NOT NULL,
  voucher_value DECIMAL(3,2) NOT NULL
);

CREATE TABLE test_order(
  order_id INT PRIMARY KEY IDENTITY(1,1),
  student_id INT NOT NULL,
  order_subtotal DECIMAL(7,2) NOT NULL, 
  payment_method NVARCHAR (20) NOT NULL DEFAULT 'CASH ON DELIVERY',
  shipping_address NVARCHAR (256) NOT NULL,
  order_status NVARCHAR(20) CHECK(order_status IN ('TO BE PAID', 'PAID', 'SELLER CONFIRMED', 'SHIPPING', 'ARRIVED', 'COMPLETED', 'CANCELLED')) DEFAULT 'TO BE PAID' NOT NULL,
  invoice VARCHAR (11) NULL,
  create_at DATETIME2 DEFAULT SYSDATETIME(),
  update_at DATETIME2 DEFAULT SYSDATETIME() ,
  voucher_id INT NULL,
  CONSTRAINT FK_order_student FOREIGN KEY (student_id) REFERENCES student(student_id),
  CONSTRAINT FK_order_voucher FOREIGN KEY (voucher_id) REFERENCES voucher(voucher_id),
  INDEX order_student_id NONCLUSTERED (student_id)
);

CREATE TABLE cart_item(
  cart_item_id INT PRIMARY KEY IDENTITY(1,1),
  student_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  CONSTRAINT FK_cart_item_product FOREIGN KEY (product_id) REFERENCES test_product(product_id),
  CONSTRAINT FK_cart_student FOREIGN KEY (student_id) REFERENCES student(student_id)
);

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
