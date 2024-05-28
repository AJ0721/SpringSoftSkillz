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

SELECT * FROM teacher;
DROP TABLE teacher;
SELECT * FROM student;

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

ALTER TABLE student_reservation
ADD zoom_meeting_url VARCHAR(255);

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

-- 資料表2 companion_match 已配對學伴
CREATE TABLE companion_match (
    match_id INT IDENTITY PRIMARY KEY not null,
    fk_student_a_id INT,
    fk_student_b_id INT,
	match_request VARCHAR(10) CHECK (match_request IN ('Yes', 'No')) not null,
    FOREIGN KEY (fk_student_a_id) REFERENCES learning_companion(companion_id),
    FOREIGN KEY (fk_student_b_id) REFERENCES learning_companion(companion_id),
);


SELECT * FROM learning_companion;
DROP TABLE companion_match

UPDATE [learning_companion]
SET [companion_photo] = CASE 
    WHEN student_id = 1 THEN 'companion/CompanionImg/Aimyon.jpg'
 ELSE [companion_photo]
END
WHERE student_id =1;

  UPDATE [learning_companion]
SET companion_learning_interest = CASE 
    WHEN student_id = 1 THEN '音樂創作'
    WHEN student_id = 2 THEN '語言學習'
    WHEN student_id = 3 THEN '程式設計'
    WHEN student_id = 4 THEN '程式設計'
    WHEN student_id = 5 THEN '語言學習'
    WHEN student_id = 6 THEN '音樂創作'
    WHEN student_id = 7 THEN '數位學習'
    WHEN student_id = 8 THEN '音樂創作'
    WHEN student_id = 9 THEN '電腦繪圖'
    WHEN student_id = 10 THEN '語言學習'
    WHEN student_id = 11 THEN '數位學習'
    WHEN student_id = 12 THEN '電腦繪圖'
    WHEN student_id = 13 THEN '程式設計'
    WHEN student_id = 14 THEN '電腦繪圖'
    WHEN student_id = 15 THEN '程式設計'
    WHEN student_id = 16 THEN '語言學習'
    WHEN student_id = 17 THEN '數位學習'
    WHEN student_id = 18 THEN '音樂創作'
    WHEN student_id = 19 THEN '電腦繪圖'
    WHEN student_id = 20 THEN '語言學習'
    ELSE companion_learning_interest
END
WHERE student_id BETWEEN 1 AND 20;

  UPDATE student
SET student_gender = CASE 
    WHEN student_id = 1 THEN 'Female'
    WHEN student_id = 2 THEN 'Female'
    WHEN student_id = 3 THEN 'Male'
    WHEN student_id = 4 THEN 'Female'
    WHEN student_id = 5 THEN 'Male'
    WHEN student_id = 6 THEN 'Female'
    WHEN student_id = 7 THEN 'Female'
    WHEN student_id = 8 THEN 'Female'
    WHEN student_id = 9 THEN 'Male'
    WHEN student_id = 10 THEN 'Male'
    WHEN student_id = 11 THEN 'Male'
    WHEN student_id = 12 THEN 'Female'
    WHEN student_id = 13 THEN 'Female'
    WHEN student_id = 14 THEN 'Male'
    WHEN student_id = 15 THEN 'Male'
    WHEN student_id = 16 THEN 'Male'
    WHEN student_id = 17 THEN 'Male'
    WHEN student_id = 18 THEN 'Female'
    WHEN student_id = 19 THEN 'Male'
    WHEN student_id = 20 THEN 'Male'
    ELSE student_gender
END
WHERE student_id BETWEEN 1 AND 20;

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
    thread_upvote_count INT DEFAULT 0,
    thread_response_count INT DEFAULT 0,
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
(10, 1, '歷史學習中的時間線理解', '在學習歷史時，對於不同事件的時間線和背景常常感到困惑，有沒有好的學習方法來清晰地理解歷史事件的發展過程？', 'VISIBLE', 12, 0),
(1, 1, 'Java多線程問題', '學習Java多線程編程時，遇到資源競爭和死鎖的問題。請問有什麼避免這些問題的最佳實踐？多線程編程是Java中一個非常重要的概念，它允許我們同時運行多個線程來提高程序的執行效率。然而，多線程編程也帶來了一些挑戰，如資源競爭和死鎖問題。資源競爭是指多個線程同時訪問共享資源時可能引發的問題，而死鎖則是指多個線程因為互相等待資源而無法繼續執行。我們可以通過使用同步機制和設計模式來避免這些問題。例如，可以使用synchronized關鍵字來確保同一時間只有一個線程訪問共享資源，或者使用ReentrantLock來實現更靈活的鎖控制。此外，還可以採用避免死鎖的策略，如避免嵌套鎖定、設定鎖超時等。通過這些方法，可以有效地避免多線程編程中的常見問題，從而提高程序的穩定性和效率。', 'VISIBLE', 6, 0),
(2, 1, '英語發音準確性問題', '在學習英語時，我的發音總是無法達到母語者的水平。有哪些方法可以提高我的發音準確性？發音準確性是學習英語的重要部分之一，正確的發音可以幫助我們更好地與他人交流並提高聽力理解能力。要提高英語發音準確性，我們可以從以下幾個方面入手。首先，通過模仿和跟讀來練習發音，選擇一些發音清晰的音頻材料，反覆聆聽並模仿其中的發音。此外，可以利用語音學習軟體來檢測和矯正發音，如利用錄音功能對比自己的發音和母語者的發音，找出差異並進行改進。其次，多練習國際音標（IPA），掌握每個音標的發音規則和方法，這樣在遇到新的單詞時也能夠正確地發音。最後，多進行口語交流，找機會與母語者或英語流利者進行對話，通過實際的交流來提高發音準確性和流利度。通過這些方法，逐步提高自己的英語發音水平。', 'VISIBLE', 8, 0),
(1, 1, 'Java集合框架學習', '學習Java集合框架時，對於各種集合類型的區別和使用場景感到困惑。有沒有詳細的學習資源或指南？Java集合框架提供了一套非常強大的數據結構和算法，用於存儲和操作數據。常見的集合類型包括List、Set和Map，它們各有不同的特性和使用場景。例如，List是一個有序的集合，可以包含重複的元素，適合用於需要順序訪問的場景；Set是一個無序的集合，不允許重複的元素，適合用於需要唯一性約束的場景；Map是一個鍵值對集合，每個鍵對應一個值，適合用於需要快速查找的場景。為了更好地學習和理解這些集合類型，可以參考一些優秀的學習資源，如《Effective Java》和《Java編程思想》這兩本經典書籍。此外，官方文檔和一些線上教程也是很好的學習材料。通過不斷的實踐和應用，逐步掌握Java集合框架的精髓。', 'VISIBLE', 9, 0),
(2, 1, '提高英語聽力能力', '在英語學習中，聽力部分總是我的弱項。有什麼推薦的聽力練習資源或者方法可以提升這方面的能力？英語聽力是許多學習者的挑戰，但通過系統的練習和合適的資源，可以有效地提高聽力水平。首先，選擇一些適合自己水平的聽力材料，如英語新聞、播客、電影和電視劇，逐步提高聽力難度。在聽的過程中，可以先大致了解內容，再進行精聽，重點關注發音、語調和連讀現象。其次，可以使用一些專門的聽力練習應用，如TED、BBC Learning English和ESL Pod，這些應用提供了豐富的聽力資源和練習工具。此外，可以參加英語角或語言交換活動，通過與母語者的實際交流來提高聽力理解和反應能力。最後，保持每天的聽力練習，逐步提高聽力水平和自信心。通過這些方法，逐步提升自己的英語聽力能力。', 'VISIBLE', 7, 0),
(1, 1, 'Java異常處理機制', '在學習Java異常處理機制時，對於如何正確地捕捉和處理異常感到困惑。請問有什麼學習建議？Java異常處理機制是保障程序穩定性和可靠性的重要部分。正確地處理異常可以避免程序崩潰，並提供有用的錯誤信息以便於調試。在Java中，我們通常使用try-catch語句來捕捉和處理異常。在try塊中放置可能拋出異常的代碼，然後在catch塊中處理這些異常。此外，可以使用finally塊來執行一些無論是否發生異常都需要執行的清理操作。學習異常處理機制時，可以參考《Effective Java》和《Java編程思想》這兩本書中的相關章節，這些書提供了大量的實踐建議和最佳實踐。例如，在捕捉異常時，應該盡量捕捉具體的異常類型，而不是捕捉所有異常，這樣可以提高代碼的可讀性和可維護性。此外，應該避免使用空的catch塊，這樣會掩蓋程序中的錯誤，導致更難調試。通過不斷地實踐和應用，逐步掌握Java異常處理機制的精髓。', 'VISIBLE', 8, 0),
(2, 1, '英語寫作技巧', '學習英語寫作時，總是無法達到流暢和地道的效果。有哪些方法可以提升我的英語寫作水平？英語寫作是綜合語言能力的體現，要提高寫作水平，需要從詞彙、語法和表達技巧等多方面入手。首先，擴展詞彙量是提升寫作水平的基礎，可以通過閱讀和記錄筆記來積累詞彙，並學習其用法和搭配。其次，掌握語法規則，特別是常見的句型和時態用法，避免語法錯誤。可以使用一些語法檢查工具，如Grammarly，來幫助檢查和糾正語法錯誤。此外，多讀優秀的英文範文，學習其中的表達方式和寫作技巧，例如論點的陳述、論據的支持和結構的安排。最後，多練習寫作，寫完後請母語者或英語老師批改，並根據反饋進行修改。通過這些方法，逐步提升自己的英語寫作水平，達到流暢和地道的效果。', 'VISIBLE', 10, 0),
(1, 1, 'Java Stream API的使用', '在使用Java Stream API時，對於其操作和效率提升感到困惑。有沒有實用的範例和最佳實踐？Java Stream API是一個強大的工具，用於處理集合數據的操作和轉換。它提供了簡潔和高效的編程方式，可以大大提高代碼的可讀性和執行效率。學習使用Stream API，可以從基本操作開始，如filter、map和reduce，這些操作允許我們對集合中的元素進行篩選、轉換和聚合。例如，可以使用filter來篩選出滿足條件的元素，使用map來對元素進行轉換，使用reduce來對元素進行聚合。此外，還可以使用一些高階操作，如flatMap、sorted和collect，來實現更複雜的數據處理需求。在學習過程中，可以參考官方文檔和一些優秀的教程，如《Java 8 in Action》和《Modern Java in Action》，這些書提供了大量的實例和最佳實踐，幫助我們更好地掌握Stream API的使用。通過不斷地實踐和應用，逐步提高自己對Java Stream API的理解和使用能力。', 'VISIBLE', 6, 3),
(2, 1, '提升英語口語能力', '在英語口語練習中，經常感到緊張和表達不流利。有哪些有效的方法可以幫助我提高口語表達能力？英語口語能力是語言交流中非常重要的一部分，要提高口語能力，可以從以下幾個方面入手。首先，創造一個英語交流的環境，與母語者或英語流利者進行對話，通過實際的交流來提高口語表達能力。其次，模仿和跟讀是提高口語的一個有效方法，選擇一些發音清晰的音頻材料，反覆聆聽並模仿其中的發音和語調。可以使用一些語音學習應用，如HelloTalk和Tandem，這些應用提供了與母語者交流的機會。此外，多參加英語角或語言交換活動，與其他英語學習者進行交流，分享學習經驗和方法。最後，保持每天的口語練習，逐步提高口語流利度和自信心。通過這些方法，逐步提升自己的英語口語能力。', 'VISIBLE', 9, 0),
(1, 1, 'Java內存管理問題', '在學習Java內存管理時，對於垃圾回收機制和內存洩漏的預防感到困惑。請問有什麼深入學習的資源？Java內存管理是一個非常重要的話題，它直接影響程序的性能和穩定性。垃圾回收機制是Java內存管理的一個核心部分，它自動釋放不再使用的內存，避免內存洩漏和程序崩潰。然而，要有效地利用垃圾回收機制，我們需要了解其工作原理和最佳實踐。例如，了解不同的垃圾回收器，如Serial、Parallel和G1垃圾回收器，它們在不同的場景下有不同的優勢和適用範圍。此外，應該避免在代碼中創建過多的臨時對象，因為這會增加垃圾回收的負擔。可以參考一些優秀的學習資源，如《Java Performance》和《Java Memory Management》，這些書提供了深入的理論和實踐指導。通過這些資源的學習，逐步提高自己對Java內存管理的理解和應用能力。', 'VISIBLE', 7, 0),
(2, 1, '英語語法學習困難', '在學習英語語法時，經常遇到一些複雜的語法規則無法掌握。有哪些系統的學習方法可以推薦？英語語法是學習英語的重要組成部分，掌握語法規則對於提高語言運用能力非常重要。要系統地學習英語語法，可以從以下幾個方面入手。首先，選擇一本好的語法書，如《English Grammar in Use》或《Advanced Grammar in Use》，這些書提供了詳細的語法解釋和練習題，幫助我們理解和應用語法規則。其次，通過做練習題來鞏固語法知識，可以利用一些在線語法練習網站，如Grammarly和Khan Academy，這些網站提供了豐富的語法練習資源。此外，多讀英文文章和書籍，通過閱讀來自然地學習語法規則和用法。在閱讀過程中，可以做筆記和標記，記錄下不熟悉的語法現象，然後查詢和學習。最後，多寫作並請母語者或老師批改，通過實際的寫作練習來提高語法運用能力。通過這些方法，逐步掌握英語語法規則，提升語言運用能力。', 'VISIBLE', 8, 0),
(1, 1, 'Java網絡編程入門', '在學習Java網絡編程時，對於Socket和ServerSocket的用法不太明白。有沒有簡單易懂的教學資源？Java網絡編程是一個重要的技能，特別是在開發網絡應用和分佈式系統時。在學習Java網絡編程時，我們需要了解Socket和ServerSocket這兩個核心類。Socket類用於建立客戶端與服務器之間的連接，而ServerSocket類則用於監聽和接受客戶端的連接請求。要學習這些概念，可以參考一些優秀的學習資源，如《Java Network Programming》和《Java Networking and Security》。這些書提供了詳細的理論知識和實踐指南，幫助我們理解和應用網絡編程技術。此外，可以參考一些在線教程和示例代碼，通過實際的編程練習來掌握Socket和ServerSocket的用法。例如，可以嘗試編寫一個簡單的聊天應用或文件傳輸應用，這些實際項目可以幫助我們更好地理解網絡編程的基本概念和技術。通過這些方法，逐步掌握Java網絡編程的技能。', 'VISIBLE', 5, 0),
(2, 1, '準確理解英語時態', '在學習英語時態時，經常混淆不同時態的用法。有什麼有效的方法或練習來幫助我掌握英語時態？英語時態是英語語法中的一個重要部分，正確地理解和使用時態可以大大提高我們的語言表達能力。要掌握英語時態，可以從以下幾個方面入手。首先，系統地學習各個時態的用法和規則，可以參考一些優秀的語法書，如《English Grammar in Use》和《Advanced Grammar in Use》，這些書提供了詳細的時態解釋和練習題，幫助我們理解和應用時態規則。其次，通過做練習題來鞏固時態知識，可以利用一些在線語法練習網站，如Grammarly和Khan Academy，這些網站提供了豐富的時態練習資源。此外，多讀英文文章和書籍，通過閱讀來自然地學習時態的用法。在閱讀過程中，可以做筆記和標記，記錄下不熟悉的時態現象，然後查詢和學習。最後，多寫作並請母語者或老師批改，通過實際的寫作練習來提高時態運用能力。通過這些方法，逐步掌握英語時態，提升語言運用能力。', 'VISIBLE', 7, 0),
(1, 1, 'Java數據庫連接', '在使用Java進行數據庫連接時，經常遇到連接超時或數據讀取錯誤。請問有什麼解決方法？Java數據庫連接是一個非常重要的技術，特別是在開發數據驅動的應用時。在使用Java進行數據庫連接時，我們通常使用JDBC（Java Database Connectivity）來實現與數據庫的交互。要解決連接超時或數據讀取錯誤的問題，可以從以下幾個方面入手。首先，檢查數據庫連接配置，包括數據庫URL、用戶名和密碼是否正確，確保數據庫服務器處於運行狀態。其次，優化數據庫查詢，避免長時間的查詢操作導致連接超時，可以使用索引來提高查詢效率。此外，設置合適的連接超時和讀取超時參數，確保在連接或讀取操作超時時能夠及時報錯和處理。最後，使用連接池技術來管理數據庫連接，避免頻繁創建和銷毀連接帶來的性能開銷。可以使用一些成熟的連接池框架，如Apache DBCP和HikariCP，這些框架提供了高效的連接池管理功能。通過這些方法，可以有效地解決Java數據庫連接中的常見問題，提升應用的穩定性和性能。', 'VISIBLE', 6, 0),
(2, 1, '提升英語閱讀理解能力', '在英語閱讀中，經常無法理解文章的核心內容。有什麼方法可以提升我的閱讀理解能力？英語閱讀理解能力是學習英語的重要組成部分，要提升閱讀理解能力，可以從以下幾個方面入手。首先，選擇適合自己水平的閱讀材料，從簡單的文章開始，逐步提升難度。可以選擇一些經典的英文小說、新聞報導和學術文章，通過廣泛閱讀來提高理解能力。其次，學會做閱讀筆記，記錄下不熟悉的詞彙、句型和語法現象，然後查詢和學習。在閱讀過程中，可以做摘要和提問，幫助自己更好地理解文章的結構和內容。此外，多參加閱讀討論活動，與其他學習者分享閱讀體驗和心得，通過交流來深化理解。最後，保持每天的閱讀練習，逐步提升閱讀速度和理解能力。通過這些方法，逐步提高自己的英語閱讀理解能力，能夠更好地理解和應用英語文章。', 'VISIBLE', 8, 0),
(1, 1, 'Java設計模式學習', '學習Java設計模式時，對於不同模式的應用場景不太了解。有沒有系統的學習資源和例子？Java設計模式是提高代碼質量和可維護性的有效工具。常見的設計模式包括創建型模式、結構型模式和行為型模式，它們各有不同的應用場景和優勢。例如，創建型模式關注對象的創建過程，適合用於需要靈活創建對象的場景，如單例模式和工廠模式；結構型模式關注對象之間的組合和結構，適合用於需要靈活組合對象的場景，如裝飾模式和代理模式；行為型模式關注對象之間的交互和職責分配，適合用於需要靈活協作對象的場景，如觀察者模式和策略模式。要系統地學習設計模式，可以參考一些經典的書籍，如《Design Patterns: Elements of Reusable Object-Oriented Software》和《Head First Design Patterns》。這些書提供了詳細的理論解釋和實踐例子，幫助我們理解和應用設計模式。此外，可以參考一些線上教程和示例代碼，通過實際的編程練習來掌握設計模式的使用。通過這些方法，逐步提高自己對Java設計模式的理解和應用能力。', 'VISIBLE', 9, 0),
(2, 1, '英語詞彙量擴展', '在學習英語時，詞彙量總是無法快速擴展。有哪些有效的方法可以增加我的詞彙量？詞彙量是學習英語的重要基礎，擴展詞彙量可以大大提高我們的語言運用能力。要增加詞彙量，可以從以下幾個方面入手。首先，多讀英文文章和書籍，通過廣泛閱讀來接觸和學習新的詞彙。在閱讀過程中，可以做筆記和標記，記錄下不熟悉的詞彙，然後查詢和學習。其次，使用一些詞彙學習應用，如Anki和Memrise，這些應用提供了豐富的詞彙學習資源和記憶方法，幫助我們更好地記住和掌握詞彙。此外，多參加英語角或語言交換活動，通過實際的交流來運用和鞏固新學到的詞彙。最後，保持每天的詞彙學習，逐步積累和擴展詞彙量。通過這些方法，逐步提高自己的英語詞彙量，能夠更好地理解和應用英語語言。', 'VISIBLE', 7, 0),
(1, 1, 'Java GUI編程入門', '在學習Java GUI編程時，對於Swing和JavaFX的使用不太明白。有沒有簡單的入門教學？Java GUI編程是開發桌面應用的重要技能，Swing和JavaFX是兩個常用的GUI框架。Swing是一個較早期的GUI框架，提供了豐富的組件和佈局管理器，而JavaFX是一個較新的GUI框架，提供了更強大的功能和更靈活的佈局管理。要學習這些框架，可以參考一些優秀的學習資源，如《Java Swing Tutorial》和《JavaFX 8: Introduction by Example》。這些書提供了詳細的理論知識和實踐指南，幫助我們理解和應用GUI編程技術。此外，可以參考一些在線教程和示例代碼，通過實際的編程練習來掌握Swing和JavaFX的用法。例如，可以嘗試編寫一個簡單的計算器應用或圖形編輯器，這些實際項目可以幫助我們更好地理解GUI編程的基本概念和技術。通過這些方法，逐步掌握Java GUI編程的技能。', 'VISIBLE', 8, 0),
(2, 1, '提高英語聽說讀寫能力', '在全面提升英語聽說讀寫能力時，應該如何制定學習計劃？有沒有推薦的學習資源？全面提升英語聽說讀寫能力需要系統的學習計劃和豐富的學習資源。首先，制定一個合理的學習計劃，確定每天的學習時間和學習目標，可以根據自己的水平和需求來安排聽說讀寫的練習比例。其次，選擇一些優秀的學習資源，如《English Grammar in Use》、《Advanced Grammar in Use》和《Cambridge English Skills》。這些書提供了豐富的語法知識和練習題，幫助我們提高語言運用能力。此外，多參加英語角或語言交換活動，通過實際的交流來提高聽說能力。多讀英文文章和書籍，通過廣泛閱讀來提高閱讀理解能力。多寫作並請母語者或老師批改，通過實際的寫作練習來提高寫作能力。保持每天的練習，逐步提高自己的英語聽說讀寫能力，達到全面提升的目標。', 'VISIBLE', 10, 0);

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
	CONSTRAINT FK_post_parent_post FOREIGN KEY (parent_post_id) REFERENCES forum_post(post_id) ON DELETE CASCADE,
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
