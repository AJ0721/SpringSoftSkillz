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

INSERT INTO teacher VALUES('汶安','熊','teacherBear','20200101','male','19950402','091234567','teacherBear@mail.com','123456','彎彎','teacher01.jpg','全',4,'full_time','國中','無','50','少一個腎',0,0)
INSERT INTO teacher VALUES('Taro','莊','cutietaro','19991201','male','19750802','090000000','cutietaro@mail.com','000000','桃園','teacher02.jpg','全',20,'full_time','大學','有','100','愛念',0,0)
INSERT INTO teacher VALUES('Jingle','莊','dr.huluhulu','20001101','male','19850302','091111111','dr.huluhulu@mail.com','111111','桃園','teacher03.jpg','全',10,'full_time','大學','有','80','啥都不會',0,0)

SELECT * FROM teacher;
DROP TABLE teacher;

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

INSERT INTO course
    (teacher_id, course_name, course_info, course_category, course_price)
VALUES
    (1, '高中英文', '高中英文超前部署', '英文', 1000),
    (2, '基礎化學', '打好化學基礎', '化學', 2000),
    (3, '進階Java', '從入門到放棄','Java', 3000);

SELECT * FROM course;
DROP TABLE course;

SELECT course_category, COUNT(*) AS category_count
FROM course
GROUP BY course_category;

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
    (1, '2024-06-01', '000000000011111000000000'),
    (2, '2024-06-02', '000000011000011000000000'),
    (3, '2024-06-03', '000000000000001111000000');

SELECT * FROM teacher_schedule;
DROP TABLE teacher_schedule;

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

SELECT * FROM student_reservation;
DROP TABLE student_reservation;

SELECT 
    YEAR(reservation_date) AS year, 
    MONTH(reservation_date) AS month, 
    SUM(total_hours) AS total_hours
FROM 
    student_reservation
WHERE 
    student_id = 1  -- 這裡的問號應替換為實際的學生 ID
GROUP BY 
    YEAR(reservation_date), 
    MONTH(reservation_date)
ORDER BY 
    YEAR(reservation_date), 
    MONTH(reservation_date);


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

INSERT INTO student_schedule
    (student_id, student_course_date, student_time_slots_all)
VALUES
    (1, '2024-05-01', '0-0-0-0-0-0-0-0-0-0-0-0-2-2-4-4-0-0-0-0-0-0-0-0'),
    (2, '2024-05-02', '0-0-0-0-0-0-0-0-0-0-0-0-3-3-0-0-0-0-0-0-0-0-0-0');

SELECT * FROM student_schedule;
DROP TABLE student_schedule;
UPDATE teacher
SET teacher_photo = 'teacher04.jpg';

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

select * from corder
INSERT INTO corder VALUES('1','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('2','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('3','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('4','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('5','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')
INSERT INTO corder VALUES('6','1','1234','2020-01-01','2020-01-01 00:30:00','LinePay','已付款')

ALTER TABLE corder
ADD discount_id varchar(255),
    discount_percent DECIMAL(5,2) ,
    after_price int ;

ALTER TABLE corderitem
ADD discount_percent DECIMAL(5,2) ,
 after_price INT,
 subtotal INT

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

select * from corderitem
--課程訂單折扣
DROP TABLE IF EXISTS coursediscount
CREATE TABLE coursediscount(
discount_id varchar(255) PRIMARY KEY NOT NULL,
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
DROP TABLE admin;


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
DROP TABLE IF EXISTS product;

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

SELECT * FROM product;


--商城訂單
--商品訂單
-- 刪除現有的 orders 和 orderitem 表
DROP TABLE IF EXISTS orderitem;
DROP TABLE IF EXISTS orders;

-- 創建 orders 表
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1, 1),
    order_date DATETIME2 NOT NULL,
    total_amount INT NOT NULL,
    order_status NVARCHAR(50) DEFAULT N'未付款',
    payment_method NVARCHAR(10) DEFAULT NULL,
    shipment_date DATETIME2 DEFAULT NULL,
    shipment_status NVARCHAR(50) NULL, 
    shipping_address NVARCHAR(255) NOT NULL
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

-- 查詢 orders 表
SELECT * FROM orders;

-- 查詢 orderitem 表
SELECT * FROM orderitem;


--學伴

--資料表1 learning_companion
DROP TABLE companion_match
DROP TABLE learning_companion
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
INSERT INTO [learning_companion] ([student_id], [companion_first_language], [companion_speaking_language], [companion_learning_interest], [companion_learning_frequency], [companion_about_me], [companion_photo])
VALUES 
(1, '日文', '英文', '程式設計', '每週4-7次','我想學程式','companion/CompanionImg/Wendy.jpg'),
(2, '中文', '英文', '程式設計', '每週1-3次', '寫程式能夠訓練我的邏輯思考能力','companion/CompanionImg/Chris.jpg'),
(3, '中文', '日文', '電腦繪圖', '每週1-3次', '我希望能畫出人氣漫畫','companion/CompanionImg/Yoona.jpg');

CREATE TABLE companion_match (
    match_id INT IDENTITY PRIMARY KEY not null,
    fk_student_a_id INT,
    fk_student_b_id INT,
	match_request VARCHAR(10) CHECK (match_request IN ('Yes', 'No')) not null,
    FOREIGN KEY (fk_student_a_id) REFERENCES learning_companion(companion_id),
    FOREIGN KEY (fk_student_b_id) REFERENCES learning_companion(companion_id),
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

DROP TABLE companion_match

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
DROP TABLE forum_category;


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
    thread_status VARCHAR(20) CHECK (thread_status IN ('VISIBLE', 'EDITED', 'LOCKED', 'DELETED')) NOT NULL,
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
DROP TABLE forum_thread;

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
	thread_id INT NOT NULL,
    parent_post_id INT NULL,
    post_content NVARCHAR(1200) NOT NULL,
    post_upvote_count INT,
	post_response_count INT, 
    post_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    post_status VARCHAR(10) CHECK (post_status IN ('VISIBLE', 'EDITED', 'LOCKED', 'DELETED')) NOT NULL,
    CONSTRAINT FK_thread_id FOREIGN KEY(thread_id) REFERENCES forum_thread(thread_id) ON DELETE CASCADE,
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
VALUES (2, 21, 13, '哇!推用心，管理員也太佛心了!', 14, 0, 'VISIBLE');

-- Parent post 2
INSERT INTO forum_post (post_student_id, thread_id, parent_post_id, post_content, post_upvote_count, post_response_count, post_status) 
VALUES (3, 21, 14, '真的，我的老師也有推薦我看這些，我覺得很實用!', 17, 0, 'VISIBLE');





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
