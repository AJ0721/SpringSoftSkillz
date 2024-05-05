--會員
--管理員
CREATE TABLE admin (
   admin_id INT IDENTITY(1,1) PRIMARY KEY,
   admin_account NVARCHAR(30) UNIQUE NOT NULL,
   admin_password NVARCHAR(30) NOT NULL,
   admin_level INT NULL
);

INSERT INTO admin VALUES('aaa','123',0)

--學生
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
INSERT INTO student VALUES('生達','蔡','999999','vincent','20210202','male','19850716','099999999','999@999','999999','桃園','img/vincent.jpg','大學',0,0,'英文','無')
INSERT INTO student VALUES('奕兆','陳','888888','leon','20220303','male','19860515','091212567','1231@123','123456','彎彎','img/roger.jpg','大學',0,0,'中文','無')

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

INSERT INTO teacher VALUES('汶安','熊','123456','20200101','male','19950402','091234567','123@123','123456','彎彎','img/gege.jpg','全',4,'full_time','國中','無','50','少一個腎',0,0)
INSERT INTO teacher VALUES('惠民','郭','000000','19991201','male','19750802','090000000','456@456','000000','桃園','img/guo.jpg','全',20,'full_time','大學','有','100','愛念',0,0)
INSERT INTO teacher VALUES('建輝','李','111111','20001101','male','19850302','091111111','789@789','111111','台北','img/gary.jpg','全',10,'full_time','大學','有','80','啥都不會',0,0)

SELECT * FROM teacher;

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

INSERT INTO course
    (teacher_id, course_name, course_info, course_category, course_price)
VALUES
    (1, '高中英文', '高中英文超前部署', '英文', 1000),
    (2, '基礎化學', '打好化學基礎', '化學', 2000),
    (3, '進階Java', '從入門到放棄','Java', 3000);

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

INSERT INTO teacher_schedule
    (teacher_id, course_date, teacher_time_slots)
VALUES
    (1, '2024-04-19', '000000000011111000000000'),
    (2, '2024-04-20', '000000011000011000000000'),
    (3, '2024-04-21', '000000000000001111000000');

INSERT INTO teacher_schedule
    (teacher_id, course_date, teacher_time_slots)
VALUES
    (1, '2024-04-19', '000000000011111000000000'),
    (2, '2024-04-20', '000000011000011000000000'),
    (3, '2024-04-21', '000000000000001111000000');

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
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (teacher_schedule_id) REFERENCES teacher_schedule(teacher_schedule_id)
);

INSERT INTO student_reservation
    (course_id, teacher_schedule_id, reservation_date,student_id,student_time_slots,total_hours)
VALUES
    (1, 1, '2024-01-20', 1, '000000000000011000000000', 2),
    (2, 2, '2024-01-21', 2, '000000000000000100000000', 1),
    (3, 3, '2024-01-22', 3, '000000000000000000011000', 2);

-- 學生行事曆資料表(選完課之後呈現的不同課程時段集合資料表)
-- 同一個上課日期可能有不同課程
-- 一個日期一筆資料
CREATE TABLE student_schedule
(
    student_schedule_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    student_course_date DATE NOT NULL,--學生上課日期 做判斷 如果該學生編號在學生行事曆資料表沒有該筆日期(抓教師行事曆的課程日期)，就新增一筆，
    student_time_slots_all VARCHAR(24) NOT NULL,--當天不同課程總上課時段
    --0:沒預約 1:已預約 
    --000000001111001111100000
    --預約14:00~17:59、20:00~23:59的時段
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT INTO student_schedule
    (student_id, student_course_date, student_time_slots_all)
VALUES
    (1, '2024-05-01', '0-0-0-0-0-0-0-0-0-0-0-0-2-2-4-4-0-0-0-0-0-0-0-0'),
    (2, '2024-05-02', '0-0-0-0-0-0-0-0-0-0-0-0-3-3-0-0-0-0-0-0-0-0-0-0');

--課程訂單
CREATE TABLE corder(
order_id NVARCHAR(200) NOT NULL PRIMARY KEY,
student_id INT NOT NULL,
order_price INT NOT NULL,
order_date DATETIME2 NOT NULL,
cancel_date DATETIME2 NOT NULL,
payment_method VARCHAR(50)  NULL,
order_status VARCHAR(50) NOT NULL,
FOREIGN KEY (student_id) REFERENCES student(student_id),
);


INSERT INTO corder VALUES('1','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('2','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('3','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('4','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('5','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('6','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')

--課程訂單細項
CREATE TABLE corderitem(
item_id INT IDENTITY(1,1) NOT NULL  PRIMARY KEY,
order_id NVARCHAR(200) NOT NULL , 
course_id INT NOT NULL,
course_price INT NOT NULL,
--discount_price INT NOT NULL,
qty INT NOT NULL,
item_status INT  NULL  DEFAULT 0,
FOREIGN KEY (order_id) REFERENCES corder(order_id),
FOREIGN KEY (course_id) REFERENCES course(course_id),
);

--課程訂單折扣
DROP TABLE IF EXISTS coursediscount
CREATE TABLE coursediscount(
discount_id INT PRIMARY KEY NOT NULL,
discount_info VARCHAR(255) NOT NULL,
discount_percent DECIMAL(5,2) NOT NULL CHECK(discount_percent>0 AND discount_percent <=100),
start_date DATETIME2 NOT NULL,
end_date DATETIME2 NOT NULL
);

INSERT INTO coursediscount VALUES(1,'原價',100,'1970-01-01','2050-01-01');
INSERT INTO coursediscount VALUES(5,'5%off',95,'1970-01-01','2050-01-01');
INSERT INTO coursediscount VALUES(10,'10%off',90,'1970-01-01','2050-01-01');
INSERT INTO coursediscount VALUES(20,'15%off',85,'1970-01-01','2050-01-01');


SELECT * FROM coursediscount;






--商城
-- 商品狀態表
CREATE TABLE product_status (
    product_status_id INT IDENTITY(1,1), -- 商品狀態編號(自增)
    product_status_name NVARCHAR(50) NOT NULL, -- 商品狀態名稱
    CONSTRAINT PK_product_status PRIMARY KEY (product_status_id), -- 主鍵
    CONSTRAINT UQ_product_status_name UNIQUE (product_status_name) -- 商品狀態名稱唯一性約束
);

 -- 插入商品狀態
INSERT INTO product_status (product_status_name)
VALUES
    ('未指定'),
    ('已上架'),
    ('已下架'),
    ('預購中'),
    ('售罄'),
    ('暫停銷售'),
    ('待補貨'),
    ('補貨中'),
    ('促銷中'),
    ('特價中'),
    ('限量供應');

-- 商品類型表
CREATE TABLE product_type (
    product_type_id INT IDENTITY(1,1), -- 商品類型編號(自增)
    product_type_name NVARCHAR(100) NOT NULL, -- 商品類型名稱
    product_type_description NVARCHAR(255), -- 商品類型描述
    CONSTRAINT PK_product_type PRIMARY KEY (product_type_id), -- 主鍵
    CONSTRAINT UQ_product_type_name UNIQUE (product_type_name) -- 商品類型名稱唯一性約束
);

 -- 插入商品類型
INSERT INTO product_type (product_type_name, product_type_description)
VALUES
    ('周邊商品', '與學習相關的周邊商品，旨在提升學習效率和學習體驗'),
    ('教材影片', '提供各類教育影片，包括語言學習、專業科目深入講解、音樂教學、運動指導及生活技能等'),
    ('實體教材', '精選實體書籍和教材，涵蓋多個學習領域的基礎與進階知識');

-- 優惠券類型表
CREATE TABLE coupon_type (
    coupon_type_id INT IDENTITY(1,1), -- 優惠券類型編號(自增)
    coupon_type_name NVARCHAR(50) NOT NULL, -- 優惠券類型名稱
    CONSTRAINT PK_coupon_type PRIMARY KEY (coupon_type_id) -- 主鍵
);

 -- 插入優惠券類型
INSERT INTO coupon_type (coupon_type_name)
VALUES
    ('折扣'),
    ('滿額減免'),
    ('買一送一');

-- 優惠券表
CREATE TABLE coupon (
    coupon_id INT IDENTITY(1,1), -- 優惠券編號(自增)
    coupon_code NVARCHAR(50) NOT NULL UNIQUE, -- 優惠券代碼，獨特且不為空
    coupon_name NVARCHAR(100) NOT NULL, -- 優惠券名稱
    coupon_description NVARCHAR(255), -- 優惠券描述
    coupon_type_id INT NOT NULL, -- 優惠券類型編號
    coupon_amount DECIMAL(10, 2) NOT NULL DEFAULT 0, -- 優惠金額，預設為0
    coupon_rate DECIMAL(5,2) NOT NULL DEFAULT 0, -- 優惠折扣率，預設為0
    coupon_buy_quantity INT NOT NULL DEFAULT 0, -- 購買數量條件，預設為0
    coupon_get_quantity INT NOT NULL DEFAULT 0, -- 贈送數量，預設為0
    coupon_start_date DATETIME2(0) NOT NULL, -- 優惠券開始日期
    coupon_end_date DATETIME2(0), -- 優惠券結束日期
    CONSTRAINT PK_coupon PRIMARY KEY (coupon_id), -- 主鍵
    CONSTRAINT FK_coupon_coupon_type FOREIGN KEY (coupon_type_id) REFERENCES coupon_type(coupon_type_id), -- 外鍵，參考優惠券類型表
    CONSTRAINT CHK_coupon_amount CHECK (coupon_amount >= 0), -- 優惠金額不得為負
    CONSTRAINT CHK_coupon_rate CHECK (coupon_rate >= 0 AND coupon_rate <= 1), -- 優惠折扣率在0到1之間
    CONSTRAINT CHK_coupon_buy_quantity CHECK (coupon_buy_quantity >= 0), -- 購買數量條件不得為負
    CONSTRAINT CHK_coupon_get_quantity CHECK (coupon_get_quantity >= 0), -- 贈送數量不得為負
    CONSTRAINT CHK_coupon_date CHECK (coupon_end_date >= coupon_start_date) -- 結束日期必須大於等於開始日期
);

 -- 插入優惠券
INSERT INTO coupon (coupon_code, coupon_name, coupon_description, coupon_type_id, coupon_amount, coupon_rate, coupon_buy_quantity, coupon_get_quantity, coupon_start_date, coupon_end_date)
VALUES 
	('1B817AD5', '新用戶折扣', '新註冊用戶專享折扣10%', 1, 0, 0.10, 0, 0, '2024-01-01', '2024-12-31'),
	('537EC7A2', '滿1000減100', '購物滿1000元減免100元', 2, 100, 0, 1000, 0, '2024-01-01', '2024-06-30'),
	('3DC89E92', '買一送一', '特定商品買一送一', 3, 0, 0, 1, 1, '2024-04-01', '2024-04-30'),
	('B588328F', '週年慶特價', '週年慶期間全店特價20%', 1, 0, 0.20, 0, 0, '2024-05-01', '2024-05-07'),
    ('BB0B5E34', '新品上市折扣', '新品推出，限時折扣15%', 1, 0, 0.15, 0, 0, '2024-06-01', '2024-06-14'),
    ('EF0BCFFB', '學生專享折扣', '凡是學生證持有者，即享折扣12%', 1, 0, 0.12, 0, 0, '2024-09-01', '2024-09-30'),
    ('D442A457', '暑期學習大放送', '暑假期間購買任何教材影片減免15元', 2, 15, 0, 0, 0, '2024-07-01', '2024-08-31'),
    ('71079FAD', '教師節感恩回饋', '教師節期間，教師憑證可享受10%折扣', 1, 0, 0.10, 0, 0, '2024-09-28', '2024-10-05'),
    ('873BFA40', '全額回饋免運費', '單次購物滿1000元免運費', 2, 30, 0, 1000, 0, '2024-01-01', '2024-12-31'),
    ('7FC9B1CF', '限時快閃折扣', '限時24小時內購物，享受全店8%折扣', 1, 0, 0.08, 0, 0, '2024-10-01', '2024-10-01'),
    ('4C385E42', '秋季特賣', '秋季特賣期間，指定商品折扣10%', 1, 0, 0.10, 0, 0, '2024-10-15', '2024-11-15'),
    ('5E60B6B0', '年終回饋', '年底購物滿2000減200', 2, 200, 0, 2000, 0, '2024-12-01', '2024-12-31'),
    ('EBB8878E', '新年快樂購', '新年期間購物享受一次性折扣20%', 1, 0, 0.20, 0, 0, '2024-01-01', '2024-01-31');

-- 商品表
CREATE TABLE product (
    product_id INT IDENTITY(1,1), -- 商品編號(自增)
    product_name NVARCHAR(100) NOT NULL, -- 商品名稱
    product_description NVARCHAR(255), -- 商品描述
    product_type_id INT NOT NULL, -- 商品分類編號(外鍵)
    product_status_id INT NOT NULL DEFAULT 1, -- 商品狀態編號(外鍵)
    product_price DECIMAL(10,2) NOT NULL, -- 商品價格
    product_stock INT DEFAULT 0, -- 商品庫存，預設為0
    product_target_audience NVARCHAR(50) NOT NULL DEFAULT '初學者', -- 目標客群，預設為"初學者"
    product_author_name NVARCHAR(100) NULL, -- 作者名稱
    product_isbn NVARCHAR(20) NULL, -- ISBN編號
    product_publication_date DATE NULL, -- 出版日期
    product_create_date DATETIME2(0) NULL, -- 商品建立日期，預設為空值
    product_update_date DATETIME2(0) NULL, -- 商品更新日期，預設為空值
    coupon_id INT NULL, -- 優惠券編號(外鍵，商品可能沒有任何促銷活動)
    CONSTRAINT PK_product PRIMARY KEY (product_id), -- 主鍵
    CONSTRAINT FK_product_product_type FOREIGN KEY (product_type_id) REFERENCES product_type(product_type_id), -- 外鍵，參考商品類型表
    CONSTRAINT FK_product_status FOREIGN KEY (product_status_id) REFERENCES product_status(product_status_id), -- 外鍵，參考商品狀態表
    CONSTRAINT FK_product_coupon FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id), -- 外鍵，參考優惠券表
    CONSTRAINT CHK_product_price CHECK (product_price >= 0), -- 商品價格不得為負
    CONSTRAINT CHK_product_stock CHECK (product_stock >= 0), -- 商品庫存不得為負
    CONSTRAINT CHK_product_physical_material CHECK (
        (product_type_id != 3 OR (product_author_name IS NOT NULL AND product_isbn IS NOT NULL AND product_publication_date IS NOT NULL))
    ) -- 只有當商品類型為實體教材時，作者名稱、ISBN和出版日期才必需填寫
);

-- 插入商品
INSERT INTO product (product_name, product_description, product_author_name, product_isbn, product_publication_date, product_status_id, product_target_audience, product_price, product_stock, product_create_date, product_update_date, product_type_id, coupon_id)
VALUES 
    ('初學者日語', '針對初學者設計的日語教學書', '田中太郎', '978-4-123456-78-9', '2023-03-01', 2, '初學者', 313, 100, '2024-01-01 01:00:00', '2024-02-27 15:24:31', 3, NULL),
    ('高級日語會話', '適合有基礎的學習者提升會話能力', '山田花子', '978-4-876543-21-6', '2023-05-01', 2, '進階學習者', 349, 50, '2024-01-11 05:21:45', '2024-04-24 12:07:28', 3, 1),
    ('學習用筆記本', '專為語言學習者設計的筆記本', NULL, NULL, NULL, 6, '所有學習者', 52, 200, '2024-02-13 14:55:20', '2024-05-20 17:20:31', 1, NULL),
    ('基礎物理教學', '針對高中生設計的物理基礎教學影片', NULL, NULL, NULL, 5, '高中生', 150, 50, '2024-02-15 10:00:00', '2024-02-27 12:30:20', 2, NULL),
    ('進階程式設計', '包含多種程式語言的進階教學影片', NULL, NULL, NULL, 3, '進階學習者', 300, 50, '2024-03-01 11:00:00', '2024-03-10 16:45:31', 2, NULL),
    ('英語會話實戰', '針對即將出國的學習者，提供實戰英語會話練習', NULL, NULL, NULL, 7, '即將出國學習者', 200, 50, '2024-01-20 08:20:00', '2024-02-11 13:11:45', 2, 3),
    ('數學解題技巧', '包含高中數學所有重要考點的解題技巧', NULL, NULL, NULL, 8, '高中生', 180, 75, '2024-01-25 09:30:00', '2024-02-15 11:40:30', 2, NULL),
    ('化學元素深度解析', '深入解析化學元素及其反應', NULL, NULL, NULL, 4, '大學生', 220, 30, '2024-03-05 14:00:00', '2024-03-25 18:05:00', 2, NULL),
    ('瑜伽初學指南', '從基礎到進階的瑜伽動作教學', NULL, NULL, NULL, 9, '健身愛好者', 120, 40, '2024-02-12 17:00:00', '2024-03-02 19:24:50', 2, 2),
    ('古典音樂欣賞與分析', '深入了解古典音樂的歷史和風格', NULL, NULL, NULL, 1, '音樂愛好者', 170, 60, '2024-02-18 12:30:00', '2024-03-05 20:00:00', 2, NULL),
    ('學習型耳機', '特製降噪功能，適合在嘈雜環境中學習使用', NULL, NULL, NULL, 10, '學生及上班族', 99, 150, '2024-03-03 11:30:00', '2024-04-15 14:20:31', 1, NULL),
    ('便攜式書燈', '便於攜帶，適合夜晚閱讀使用的LED書燈', NULL, NULL, NULL, 11, '所有讀者', 210, 200, '2024-03-01 13:00:00', '2024-04-01 17:25:28', 1, 3),
    ('高級數學解析', '提供大學數學和工程數學的深入教材', '劉偉', '978-3-456789-01-2', '2023-10-15', 2, '大學生', 250, 60, '2024-01-15 09:00:00', '2024-02-18 16:30:20', 3, NULL),
    ('現代物理學入門', '現代物理的基礎知識和理論介紹', '陳大明', '978-2-987654-32-1', '2023-11-01', 2, '大學生', 299, 40, '2024-01-12 10:00:00', '2024-03-01 12:45:00', 3, NULL),
    ('高效學習手冊', '為高效學習提供指導和技巧', NULL, NULL, NULL, 3, '大學生及自學者', 150, 80, '2024-02-20 09:15:00', '2024-03-30 14:15:00', 1, 2),
    ('進階化學實驗', '包含多項化學實驗操作和理論解釋', NULL, NULL, NULL, 9, '高中生及大學生', 280, 60, '2024-03-10 10:20:00', '2024-04-15 13:30:00', 2, NULL),
    ('生物學基礎', '深入淺出地介紹生物學基礎知識', '王小明', '978-3-654321-00-1', '2023-08-15', 4, '高中生及大學初學者', 190, 45, '2024-03-05 09:00:00', '2024-03-25 11:30:00', 3, 3),
    ('數位攝影入門', '從基礎到進階的數位攝影技巧教學', NULL, NULL, NULL, 6, '攝影愛好者', 320, 30, '2024-01-25 16:00:00', '2024-02-19 14:50:00', 2, 1),
    ('圍棋教學初階', '圍棋基礎規則和策略介紹', NULL, NULL, NULL, 7, '圍棋初學者', 110, 100, '2024-03-15 15:00:00', '2024-03-20 12:20:00', 2, NULL),
    ('法語入門教程', '全面系統的法語初學者入門指南', '李明', '978-4-987654-32-9', '2023-12-01', 2, '語言學習者', 225, 50, '2024-02-28 08:00:00', '2024-03-15 13:00:00', 3, 1),
    ('程式設計精解', '深入淺出的程式設計學習書籍', '張華', '978-2-123456-78-0', '2023-09-01', 8, '初學者至進階程式設計師', 255, 75, '2024-01-18 09:30:00', '2024-02-18 16:30:00', 3, NULL),
    ('經濟學人必讀', '涵蓋當前經濟學重要理論與案例分析', '周星', '978-1-876543-21-0', '2023-10-20', 5, '經濟學學生及專業人士', 330, 40, '2024-03-12 11:45:00', '2024-04-10 15:50:00', 3, 2),
    ('當代世界歷史', '詳細介紹從二十世紀至今的世界大事', '黃建', '978-0-123456-89-7', '2023-07-01', 10, '歷史愛好者及學生', 275, 60, '2024-02-01 14:00:00', '2024-03-01 17:00:00', 3, NULL),
    ('心理學與生活', '探討心理學在日常生活中的應用', '吳心', '978-5-678901-23-4', '2023-06-01', 1, '心理學學生及普通讀者', 215, 85, '2024-01-02 12:00:00', '2024-01-31 18:30:00', 3, NULL),
    ('創意繪畫技巧', '提升繪畫技能與創作靈感的實用指南', NULL, NULL, NULL, 11, '藝術學生及愛好者', 145, 95, '2024-02-15 17:15:00', '2024-02-28 19:45:00', 2, 3),
    ('機器學習實戰', '介紹機器學習項目實施的步驟和技術', NULL, NULL, NULL, 4, '數據科學家及工程師', 350, 40, '2024-03-07 10:30:00', '2024-04-05 16:00:00', 2, NULL),
    ('園藝基礎知識', '全面系統的家庭園藝指南', NULL, NULL, NULL, 9, '家庭主婦及園藝愛好者', 190, 100, '2024-03-20 15:00:00', '2024-04-18 11:20:00', 1, 2),
    ('基礎機械工程', '介紹機械工程的基礎理論與應用', '劉剛', '978-6-543210-98-7', '2023-11-10', 7, '工程學生及專業工程師', 320, 55, '2024-02-10 13:00:00', '2024-03-10 14:40:00', 3, 1),
    ('初級會計學', '為初學者提供會計基礎知識與實踐', '陳莉', '978-7-654321-09-4', '2023-04-01', 8, '商業學生及初創企業', 165, 70, '2024-03-01 08:30:00', '2024-03-31 12:15:00', 3, NULL),
    ('進階網頁設計', '教授HTML、CSS及JavaScript進階技術', NULL, NULL, NULL, 2, '網頁設計師及開發者', 280, 45, '2024-02-05 10:00:00', '2024-02-25 15:20:00', 2, 2);

-- 商品圖片表
CREATE TABLE product_image (
    product_image_id INT IDENTITY(1,1), -- 商品圖片編號(自增)
    product_image_url NVARCHAR(255) NOT NULL, -- 商品圖片URL
    product_id INT NOT NULL, --商品編號(外鍵)
    CONSTRAINT PK_product_image PRIMARY KEY (product_image_id), -- 主鍵
    CONSTRAINT FK_product_image_product FOREIGN KEY (product_id) REFERENCES product(product_id) -- 外鍵，參考商品表
);

-- 插入商品圖片
INSERT INTO product_image (product_image_url, product_id)
VALUES 
    ('img/japanese_beginner_book.jpg', 1),
    ('img/advanced_japanese_conversation.jpg', 2),
    ('img/learning_notebook.jpg', 3),
    ('img/basic_physics_teaching.jpg', 4),
    ('img/advanced_programming_tutorial.jpg', 5),
    ('img/english_conversation_practice.jpg', 6),
    ('img/math_problem_solving_skills.jpg', 7),
    ('img/chemistry_elements_analysis.jpg', 8),
    ('img/yoga_beginners_guide.jpg', 9),
    ('img/classical_music_appreciation.jpg', 10),
    ('img/noise_cancelling_headphones.jpg', 11),
    ('img/portable_book_light.jpg', 12),
    ('img/advanced_mathematics_analysis.jpg', 13),
    ('img/introduction_to_modern_physics.jpg', 14),
    ('img/efficient_learning_manual.jpg', 15),
    ('img/advanced_chemical_experiments.jpg', 16),
    ('img/fundamentals_of_biology.jpg', 17),
    ('img/digital_photography_intro.jpg', 18),
    ('img/go_game_tutorial.jpg', 19),
    ('img/french_language_course.jpg', 20),
    ('img/programming_design_essentials.jpg', 21),
    ('img/economist_must_read.jpg', 22),
    ('img/contemporary_world_history.jpg', 23),
    ('img/psychology_in_life.jpg', 24),
    ('img/creative_painting_techniques.jpg', 25),
    ('img/machine_learning_in_action.jpg', 26),
    ('img/gardening_knowledge.jpg', 27),
    ('img/basic_mechanical_engineering.jpg', 28),
    ('img/basic_accounting.jpg', 29),
    ('img/advanced_web_design.jpg', 30);

-- 商品影片表
CREATE TABLE product_video (
    product_video_id INT IDENTITY(1,1), -- 商品影片編號(自增)
    product_video_url NVARCHAR(255) NOT NULL, -- 商品影片URL
    product_id INT NOT NULL, --商品編號(外鍵)
    CONSTRAINT PK_product_video PRIMARY KEY (product_video_id), -- 主鍵
    CONSTRAINT FK_product_video_product FOREIGN KEY (product_id) REFERENCES product(product_id) -- 外鍵，參考商品表
);

-- 插入商品影片
INSERT INTO product_video (product_video_url, product_id)
VALUES 
    ('video/basic_physics_lecture.mp4', 4),
    ('video/advanced_programming_course.mp4', 5),
    ('video/english_conversation_skills.mp4', 6),
    ('video/math_problem_solving_methods.mp4', 7),
    ('video/chemistry_elements_deep_dive.mp4', 8),
    ('video/yoga_for_beginners_series.mp4', 9),
    ('video/classical_music_history_and_analysis.mp4', 10),
    ('video/advanced_chemical_experiments.mp4', 16),
    ('video/go_game_tutorial_beginner.mp4', 19),
    ('video/digital_photography_intro.mp4', 18),
    ('video/machine_learning_in_action.mp4', 26);

-- 優惠券與商品類型關聯表(使特定類型的商品能夠應用特定的優惠券)
CREATE TABLE coupon_type_relations (
    coupon_id INT, -- 優惠方案編號(外鍵)
    product_type_id INT, -- 商品類型編號(外鍵)
    CONSTRAINT PK_coupon_type_relations PRIMARY KEY (coupon_id, product_type_id), -- 複合主鍵
    CONSTRAINT FK_coupon_type_relations_coupon FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id), -- 外鍵，參考優惠券表
    CONSTRAINT FK_coupon_type_relations_product_type FOREIGN KEY (product_type_id) REFERENCES product_type(product_type_id) -- 外鍵，參考商品類型表
);

-- 插入優惠券與商品類型關聯
INSERT INTO coupon_type_relations (coupon_id, product_type_id)
VALUES 
    (1, 3),  -- 新用戶折扣適用於實體教材
    (2, 1),  -- 滿1000減100適用於周邊商品
    (3, 1),  -- 買一送一適用於周邊商品
    (4, 1),  -- 新品上市折扣適用於周邊商品
    (5, 2),  -- 學生專享折扣適用於教材影片
    (6, 3),  -- 暑期學習大放送適用於實體教材
    (7, 1),  -- 教師節感恩回饋適用於周邊商品
    (8, 1),  -- 全額回饋免運費適用於周邊商品
    (9, 1),  -- 限時快閃折扣適用於周邊商品
    (10, 2), -- 秋季特賣適用於教材影片
    (11, 3), -- 年終回饋適用於實體教材
    (12, 1), -- 新年快樂購適用於周邊商品
    (13, 2); -- 新年快樂購適用於教材影片

-- 查詢表資料
SELECT * FROM product_status;
SELECT * FROM product_type;
SELECT * FROM product;
SELECT * FROM product_image;
SELECT * FROM product_video;
SELECT * FROM coupon_type;
SELECT * FROM coupon;
SELECT * FROM coupon_type_relations;


--商城訂單

--商品訂單
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1, 1),
    student_id INT NOT NULL FOREIGN KEY REFERENCES student(student_id),
	coupon_id INT NULL FOREIGN KEY REFERENCES coupon(coupon_id),
    order_date DATETIME2 NOT NULL,
    total_amount INT NOT NULL,
    order_status NVARCHAR(50) DEFAULT N'未付款',
    payment_method NVARCHAR(10) DEFAULT NULL,
    shipment_date DATETIME2 DEFAULT NULL,
    shipment_status NVARCHAR(50) NULL, 
    shipping_address NVARCHAR(255) NOT NULL
);
INSERT INTO orders
    (student_id, coupon_id, order_date, total_amount, order_status, payment_method, shipment_date, shipment_status, shipping_address)
VALUES
    (1, 1, '2024-03-20 08:00:00', 1000, '支付成功', 'LINE PAY', '2024-03-25', '未出貨', '地址1'),
	(2, 2, '2024-01-17 15:28:00', 2500, '支付成功', '綠界', '2024-01-20', '已出貨', '地址2'),
	(3, 3, '2024-04-29 11:54:00', 600, '支付成功', 'LINE PAY', '2024-04-30', '處理運送中', '地址3');

--商品訂單項目
CREATE TABLE orderitem (
    order_item_id INT PRIMARY KEY IDENTITY(1, 1),
    order_id INT NOT NULL FOREIGN KEY REFERENCES orders(order_id),
    product_id INT NOT NULL FOREIGN KEY REFERENCES product(product_id),
	product_image_id INT FOREIGN KEY REFERENCES product_image(product_image_id),
    quantity INT NOT NULL,
    product_price INT NOT NULL,
    sub_total INT NOT NULL
);

--插入商品訂單項目
INSERT INTO orderitem (order_id, product_id, product_image_id, quantity, product_price, sub_total)
VALUES
(1, 1, 1, 5, 500, 2500),  
(2, 2, 2, 1, 1500, 1500), 
(2, 3, 3, 3, 300, 900);  

--學伴

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
truncate table learning_companion

INSERT INTO [learning_companion] ([student_id], [companion_username], [companion_gender], [companion_birth], [companion_first_language], [companion_speaking_language], [companion_learning_interest], [companion_learning_frequency], [companion_photo])
VALUES 
(1003, 'Wendy', 'Female', '1999-01-02 00:00:00.0000000', '日文', '英文', '程式設計', '每週4-7次', 'Companion/CompanionImg/Wendy.jpg'),
(1004, 'Joe', 'Male', '1996-02-03 00:00:00.0000000', '中文', '英文', '程式設計', '每週1-3次', 'Companion/CompanionImg/Joe.jpg'),
(1005, 'Cindy', 'Female', '2002-12-06 00:00:00.0000000', '中文', '日文', '電腦繪圖', '每週1-3次', 'Companion/CompanionImg/Cindy.jpg'),
(1006, 'Chris', 'Male', '2003-05-25 00:00:00.0000000', '日文', '中文', '語言學習', '每週1-3次', 'Companion/CompanionImg/Chris.jpg'),
(1007, 'Lily', 'Female', '1998-10-20 00:00:00.0000000', '英文', '英文', '語言學習', '每週4-7次', 'Companion/CompanionImg/Lily.jpg'),
(1008, 'David', 'Male', '1995-08-18 00:00:00.0000000', '英文', '中文', '電腦繪圖', '每週4-7次', 'Companion/CompanionImg/David.jpg'),
(1009, 'Ryan', 'Male', '1993-03-02 00:00:00.0000000', '西班牙文', '英文', '數位行銷', '每週4-7次', 'Companion/CompanionImg/Ryan.jpg'),
(1010, 'Ella', 'Female', '1996-01-01 00:00:00.0000000', '德文', '法文', '電腦繪圖', '每週1-3次', 'Companion/CompanionImg/Ella.jpg'),
(1011, 'Peter', 'Male', '1992-11-21 00:00:00.0000000', '中文', '西班牙文', '語言學習', '每週4-7次', 'Companion/CompanionImg/Peter.jpg'),
(1012, 'Aimyon', 'Female', '1995-03-06 00:00:00.0000000', '日文', '英文', '音樂創作', '每週4-7次', 'Companion/CompanionImg/Aimyon.jpg'),
(1013, 'Tommy', 'Male', '1990-02-01 00:00:00.0000000', '英文', '日文', '程式設計', '每週4-7次', 'Companion/CompanionImg/Tommy.jpg'),
(1014, 'Wally', 'Male', '2000-09-30 00:00:00.0000000', '中文', '西班牙文', '電腦繪圖', '每週1-3次', 'Companion/CompanionImg/Wally.jpg'),
(1015, 'Yoona', 'Female', '1990-05-30 00:00:00.0000000', '韓文', '中文', '音樂創作', '每週4-7次', 'Companion/CompanionImg/Yoona.jpg'),
(1016, 'Randy', 'Male', '1998-06-25 00:00:00.0000000', '日文', '中文', '語言學習', '每週1-3次', 'Companion/CompanionImg/Randy.jpg'),
(1017, 'Taylor', 'Female', '1989-12-13 00:00:00.0000000', '英文', '德文', '音樂創作', '每週4-7次', 'Companion/CompanionImg/Taylor.jpg'),
(1018, 'Taeyeon', 'Female', '1989-03-09 00:00:00.0000000', '韓文', '英文', '音樂創作', '每週4-7次', 'Companion/CompanionImg/Taeyeon.jpg'),
(1019, 'Betty', 'Female', '1997-10-19 00:00:00.0000000', '日文', '英文', '程式設計', '每週4-7次', 'Companion/CompanionImg/Betty.jpg'),
(1020, 'Paul', 'Male', '1993-12-02 00:00:00.0000000', '英文', '德文', '數位行銷', '每週1-3次', 'Companion/CompanionImg/Paul.jpg'),
(1021, 'John', 'Male', '1999-05-30 00:00:00.0000000', '西班牙文', '英文', '電腦繪圖', '每週1-3次', 'Companion/CompanionImg/John.jpg'),
(1022, 'Winter', 'Female', '2001-01-01 00:00:00.0000000', '韓文', '英文', '音樂創作', '每週4-7次', 'Companion/CompanionImg/Winter.jpg'),
(1023, 'Dora', 'Female', '2000-09-17 00:00:00.0000000', '中文', '英文', '數位行銷', '每週4-7次', 'Companion/CompanionImg/Dora.jpg'),
(1024, 'Frieren', 'Female', '0950-02-14 00:00:00.0000000', '日文', '咒語', '魔法研究', '每週4-7次', 'Companion/CompanionImg/Frieren.jpg');

-- 資料表2 加PK companion_match 已配對學伴
CREATE TABLE companion_match (
    match_id INT IDENTITY PRIMARY KEY not null,
    fk_student_a_id INT,
    fk_student_b_id INT,
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

INSERT INTO forum_category (forum_category_name, forum_category_description)
VALUES
('Java', '深入探討Java程式語言，學習如何開發軟體和應用程式。'),
('英語', '提高英語聽說讀寫能力，掌握國際語言的精粹。'),
('美術', '從素描到數位繪畫，開發你的藝術天賦並展現創意。'),
('音樂理論', '學習音樂理論，探索作曲和演奏的基本技巧。'),
('數學', '解開數學謎題，從基礎算術到高等數學的全面探索。'),
('物理', '揭示物理學的奧秘，理解宇宙的基本法則。'),
('化學', '化學反應背後的科學，探索物質的性質和變化。'),
('生物學', '研究生命科學，從細胞結構到生態系統的動態。'),
('經濟學', '深入了解經濟學原理，分析市場和財政決策。'),
('歷史', '回顧歷史，了解不同文明的演變和重大事件。'),
('心理學', '探索心理學的領域，理解人類行為和心理過程。'),
('哲學', '哲學思辨，從倫理學到存在主義的深入討論。'),
('計算機科學', '從數據結構到人工智能，學習計算機科學的核心。'),
('企業管理', '為未來的管理者提供知識，學習管理策略和業務運作。'),
('市場營銷', '掌握市場營銷的技巧，學習如何吸引和保留客戶。'),
('會計', '學習會計原理，精通財務報表和審計流程。'),
('環境科學', '了解環境問題，探討可持續發展的解決方案。'),
('統計學', '掌握統計方法，分析數據以支持決策制定。'),
('德文', '用德文開拓視野，學習德國與歐洲文化。'),
('法律', '瞭解法律框架，探討法律問題和案例。'),
('健康與體育', '提升健康意識，學習體育運動和營養知識。'),
('藝術歷史', '穿越藝術的時空，從古典到現代藝術的演變。'),
('C++', '深入探討C++程式語言，學習如何開發軟體和應用程式。'),
('戲劇和表演藝術', '表達舞台藝術的魅力，學習表演技巧和戲劇製作。'),
('數字媒體製作', '掌握數字媒體的創作工具，從視頻製作到音頻編輯。');


SELECT*FROM forum_category
ORDER BY forum_category_id;


CREATE TABLE forum_thread (
    thread_id INT PRIMARY KEY IDENTITY(1,1),
    forum_category_id INT NOT NULL,
	thread_student_id INT NULL,
	thread_teacher_id INT NULL,
	thread_admin_id INT NULL,
	thread_title VARCHAR(255) NOT NULL,
    thread_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    thread_content NVARCHAR(4000) NOT NULL,
    thread_upvote_count INT,
    thread_response_count INT,
    thread_status VARCHAR(20) CHECK (thread_status IN ('VISIBLE', 'LOCKED', 'DELETED')) NOT NULL,
	CONSTRAINT FK_thread_category FOREIGN KEY(forum_category_id) REFERENCES forum_category(forum_category_id),
    CONSTRAINT FK_thread_student FOREIGN KEY(thread_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_thread_teacher FOREIGN KEY(thread_teacher_id) REFERENCES teacher(teacher_id),
	CONSTRAINT FK_thread_admin FOREIGN KEY(thread_admin_id) REFERENCES admin(admin_id)
);


-- Threads created by students (1-10)
INSERT INTO forum_thread (forum_category_id, thread_student_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(1, 1, 'Java環境配置問題', '剛開始學習Java，建環境遇到的問題，安裝JDK和配置PATH時一直出錯。有沒有詳細的步驟指導？', 'VISIBLE', 5, 4),
(2, 2, '大家都能辨別不同英語口音嗎', '在學習英語過程中，我發現理解不同口音時很困難，尤其是印度口音。有沒有有效的練習方法來提升這方面的能力？', 'VISIBLE', 7, 4),
(3, 3, '美術學習中的色彩理論問題', '在學習繪畫時，對如何配色感到困惑。有沒有基本的色彩理論和實用的配色指南？', 'VISIBLE', 8, 4),
(4, 1, '音樂理論中的和聲學習困難', '音樂理論學習中，和聲部分特別難以掌握，有沒有學習資源或練習方法可以推薦？', 'VISIBLE', 6, 4),
(5, 2, '數學函數圖形的畫法', '在數學學習中，畫函數圖形時經常遇到困難，尤其是複雜函數的圖形。有沒有好的工具或方法來幫助理解和畫出這些圖形？', 'VISIBLE', 9, 4),
(6, 3, '物理學中的力學問題', '在學習力學時，對於牛頓運動定律的應用實例感到迷惑，如何更好地理解和應用這些定律？', 'VISIBLE', 11, 0),
(7, 1, '化學實驗中的安全問題', '在進行化學實驗時，經常擔心安全問題。有沒有一套完整的實驗室安全指南？', 'VISIBLE', 10, 0),
(8, 2, '生物學DNA複製機制的理解', '在學習DNA複製過程時，對酶的作用和整個複製機制的步驟感到困惑。如何更清晰地理解這一過程？', 'VISIBLE', 13, 0),
(9, 3, '經濟學中的微觀經濟與宏觀經濟', '如何區分微觀經濟學與宏觀經濟學？在學習經濟學理論時，這兩者有什麼聯繫和差異？', 'VISIBLE', 7,0),
(10, 1, '歷史學習中的時間線理解', '在學習歷史時，對於不同事件的時間線和背景常常感到困惑，有沒有好的學習方法來清晰地理解歷史事件的發展過程？', 'VISIBLE', 12, 0);

-- Threads created by teachers (11-20)
INSERT INTO forum_thread (forum_category_id, thread_teacher_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(1, 1, 'Java錯誤處理', '在Java編程中，錯誤處理是確保程序穩定運行的關鍵。本文將分享一些錯誤處理的最佳實踐和常見錯誤避免技巧。', 'VISIBLE', 14, 4),
(2, 2, '英語口語的快速提升技巧', '許多學生在提升英語口語方面遇到困難。這裡將分享一些有效的練習方法和技巧來快速提高你的英語口語能力。', 'VISIBLE', 15, 4),
(3, 3, '數位繪畫工具和技巧介紹', '在美術學習中，數位繪畫是一個重要分支。本帖將介紹一些流行的數位繪畫工具和基本技巧。', 'VISIBLE', 13, 4),
(4, 1, '音樂作曲的基礎知識', '學習音樂理論是作曲的基礎。本帖將介紹一些作曲的基礎知識和創作技巧，幫助你開始你的音樂創作旅程。', 'VISIBLE', 16, 4),
(5, 2, '數學證明技巧和策略', '在高等數學學習中，數學證明是一個挑戰。這裡將分享一些證明技巧和策略來幫助你理解並解決複雜的數學問題。', 'VISIBLE', 18, 4),
(6, 3, '物理實驗的設計與分析', '進行物理實驗是理解理論的一個重要方法。本帖將討論如何設計實驗並分析實驗數據，以提高學習效果。', 'VISIBLE', 17, 0),
(7, 1, '化學平衡的深入探討', '化學反應中的平衡狀態是一個複雜的主題。這裡將深入探討化學平衡的概念和計算方法。', 'VISIBLE', 19,0),
(8, 2, '生物學中的遺傳學基礎', '遺傳學是生物學的一個重要分支。本帖將介紹遺傳學的基礎知識和一些基本的遺傳實驗方法。', 'VISIBLE', 14, 0),
(9, 3, '宏觀經濟學中的政策分析', '宏觀經濟學中的政策分析對理解國家經濟政策的影響至關重要。本帖將分析一些關鍵的經濟政策及其對經濟的影響。', 'VISIBLE', 12, 0),
(10, 1, '歷史研究方法與技巧', '在歷史研究中，使用正確的研究方法和技巧是非常重要的。這裡將分享一些有效的歷史研究方法來幫助你進行學術研究。', 'VISIBLE', 11, 0);

-- Threads created by admins (21-25)
INSERT INTO forum_thread (forum_category_id, thread_admin_id, thread_title, thread_content, thread_status, thread_upvote_count, thread_response_count) 
VALUES 
(1, 1, 'Java學習資源更新', '我們更新了Java學習資源，包括最新的教程和實例。這些資源旨在幫助初學者和進階開發者提升他們的Java技能。', 'VISIBLE', 20, 4),
(2, 1, '英語學習平台優化公告', '為了提升英語學習的效果，我們對學習平台進行了一系列的優化調整。歡迎大家體驗新的學習工具和資源。', 'VISIBLE', 18, 4),
(3, 1, '美術課程新開設通知', '我們將開設新的美術課程，包括現代藝術和傳統繪畫技巧。這些課程適合所有水平的學習者。', 'VISIBLE', 15, 0),
(4, 1, '音樂理論課程更新', '我們更新了音樂理論課程，新增了多種樂器的教學內容。這將幫助學生更全面地理解音樂理論和實踐。', 'VISIBLE', 12, 0),
(5, 1, '數學線上輔導服務', '為了支持學生在數學學習中的需求，我們推出了線上輔導服務。這項服務將提供個別輔導和答疑。', 'VISIBLE', 10, 0);

SELECT* FROM forum_thread;


GO

CREATE VIEW thread_view 
AS 

SELECT ft.thread_id, ft.forum_category_id, c.forum_category_name, ft.thread_student_id, ft.thread_teacher_id, ft.thread_admin_id, s.student_username AS username,
    ft.thread_title, ft.thread_content, ft.thread_created_time,ft.thread_upvote_count, ft.thread_response_count, 
	s.student_photo AS photo,  ft.thread_status 
FROM forum_thread ft JOIN student s ON s.student_id = ft.thread_student_id
					JOIN forum_category c ON ft.forum_category_id = c.forum_category_id
					

UNION ALL

SELECT ft.thread_id, ft.forum_category_id, c.forum_category_name, ft.thread_student_id,  ft.thread_teacher_id,ft.thread_admin_id, t.teacher_username AS username,
    ft.thread_title, ft.thread_content, ft.thread_created_time, ft.thread_upvote_count, ft.thread_response_count, 
	t.teacher_photo AS photo, ft.thread_status  
FROM forum_thread ft JOIN teacher t ON t.teacher_id = ft.thread_teacher_id
					JOIN forum_category c ON ft.forum_category_id = c.forum_category_id

UNION ALL 

SELECT ft.thread_id, ft.forum_category_id, c.forum_category_name, ft.thread_student_id, ft.thread_teacher_id, ft.thread_admin_id, NULL AS username,
    ft.thread_title, ft.thread_content, ft.thread_created_time, ft.thread_upvote_count, ft.thread_response_count, NULL AS photo, ft.thread_status  
FROM forum_thread ft JOIN admin a ON a.admin_id = ft.thread_admin_id
					JOIN forum_category c ON ft.forum_category_id = c.forum_category_id;

GO

SELECT * FROM thread_view
ORDER BY thread_created_time; 
DROP VIEW thread_view;


CREATE TABLE forum_post (
    post_id INT PRIMARY KEY IDENTITY(1,1),
	post_student_id INT NULL,
	post_teacher_id INT NULL,
	post_admin_id INT NULL,
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

-- Thread 1: student-Java環境配置問題
-- Parent post 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 1, NULL, '同問!有誰遇到過類似的問題嗎？', 5, 2, 'VISIBLE');
-- Child posts for parent post 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 1, 1, '我之前也有遇過，重啟安裝就好了，應該是安裝過程有問題。', 2, 0, 'VISIBLE');
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 1, 1, '要確保環境變數設置正確，可以參考這篇官方文件。', 3, 0, 'VISIBLE');
-- Parent post 2
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 1, NULL, '我有寫一個詳細的教學可以參考，網址如下：xxxxxx。希望對你有幫助。', 4, 0, 'VISIBLE');

-- Thread 2: student-大家都能辨別不同英語口音嗎
-- Parent post 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 2, NULL, '我也有同樣的問題，尤其是在電話的時候。', 6, 2, 'VISIBLE');
-- Child posts for parent post 1
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 2, 5, '可以試著聽不同的podcast熟悉各種口音，找自己有興趣的主題會比較有動力。', 5, 0, 'VISIBLE');
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 2, 5, '看電影或影集也很有幫助喔!', 3, 0, 'VISIBLE');
-- Parent post 2
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 2, NULL, '請問有沒有推薦的影集或適合初學者的podcast練習資源呢？', 7, 0, 'VISIBLE');

-- Thread 11: teacher-Java錯誤處理
-- Parent post 1
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 11, NULL, '這是一個常見的問題，我會發布一些錯誤處理的技巧。', 14, 2, 'VISIBLE');
-- Child posts for parent post 1
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 11, 9, '感謝分享，這對我很有幫助！', 2, 0, 'VISIBLE');
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 11, 9, '能否提供更多關於異常處理的例子？', 3, 0, 'VISIBLE');
-- Parent post 2
INSERT INTO forum_post (post_teacher_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (2, 11, NULL, '我將在下一篇文章中進一步深入討論。', 15, 0, 'VISIBLE');

-- Thread 21: admin-Java學習資源更新
-- Parent post 1
INSERT INTO forum_post (post_admin_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (1, 21, NULL, '歡迎大家查看更新後的資源，希望大家能喜歡。', 20, 2, 'VISIBLE');
-- Child posts for parent post 1
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



CREATE VIEW post_view 
AS 

SELECT p.post_id, p.post_student_id, p.post_teacher_id, p.post_admin_id, s.student_username AS username, ft.thread_id, p.parent_post_id,  
	p.post_content, p.post_upvote_count,p.post_response_count, s.student_photo AS photo,  p.post_created_time, p.post_status 
FROM forum_post p JOIN student s ON s.student_id = p.post_student_id
				 JOIN forum_thread ft ON ft.thread_id = p.thread_id

UNION ALL

SELECT p.post_id, p.post_student_id, p.post_teacher_id, p.post_admin_id, t.teacher_username AS username, ft.thread_id, p.parent_post_id, 
	p.post_content,p.post_upvote_count,p.post_response_count, t.teacher_photo AS photo,  p.post_created_time, p.post_status 
FROM forum_post p JOIN teacher t ON t.teacher_id = p.post_teacher_id
				  JOIN forum_thread ft ON ft.thread_id = p.thread_id

UNION ALL 
SELECT p.post_id, p.post_student_id, p.post_teacher_id, p.post_admin_id, NULL AS username, ft.thread_id, p.parent_post_id, 
	p.post_content,p.post_upvote_count,p.post_response_count, NULL AS photo,  p.post_created_time, p.post_status 
FROM forum_post p JOIN admin a ON a.admin_id = p.post_teacher_id
				  JOIN forum_thread ft ON ft.thread_id = p.thread_id;

GO

SELECT * FROM post_view
ORDER BY post_created_time;
DROP View post_view;


CREATE TABLE forum_image (
    forum_image_id INT IDENTITY(1,1) PRIMARY KEY,
    thread_id INT NULL,
    post_id INT NULL,
    forum_image_path NVARCHAR(MAX),
    forum_image_upload_date DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    CONSTRAINT FK_image_thread_id FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id),
    CONSTRAINT FK_image_post_id FOREIGN KEY (post_id) REFERENCES forum_post(post_id)
);

SELECT * FROM forum_image;
