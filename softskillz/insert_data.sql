--會員
--管理員(20)
INSERT INTO admin
    (admin_account, admin_password, admin_level)
VALUES
    ('JohnDoe', 'JD@2024Pass', 1),
    ('AnnaBell', 'ABell*938', 2),
    ('MarkH123', 'MarkH3%89', 3),
    ('LucySky', 'LSky2024!', 4),
    ('EthanWolk', 'Wolk*782', 5),
    ('SophieM', 'SMi123&789', 6),
    ('DaveGrohl', 'D_Grohl*925', 1),
    ('NinaT', 'NinaT88$6', 2),
    ('AlexFergus', 'Alex*536#', 3),
    ('GraceH', 'GH2024!@', 4),
    ('TomHolland', 'TH@2023$$', 5),
    ('EmmaWatson', 'EmmaW123*', 6),
    ('HarryP', 'HPotter*7%', 1),
    ('OliviaD', 'OliviaD8@9', 2),
    ('JakeLong', 'JLong*990', 3),
    ('SarahCon', 'SCon#422', 4),
    ('IanSomer', 'Ian987&$#', 5),
    ('VanessaG', 'Vg*2134!', 6),
    ('PeterPan', 'PeterP@2024', 1),
    ('MiaWallace', 'MiaW$$424', 2);

--學生(20)
INSERT INTO student (
  student_first_name,
  student_last_name,
  student_username,
  student_nickname,
  student_registration_date,
  student_gender,
  student_birth,
  student_mobile,
  student_email,
  student_password,
  student_country,
  student_education,
  student_forum_status,
  student_course_status,
  first_language,
  learning_frequency
)
VALUES
  ('筱涵', '李', 'leilu', '乂煞氣a婷乂', '2024-02-21 03:23:37', 'Male', '1992-03-26', '047 84167685', 'xiuyingxiong@yahoo.com', 'ea1IzjDUv+', '台灣', '博士后', 1, 0, '西班牙語', '一週大於42小時'),
  ('柏翰', '蘇', 'jun94', 'momo', '2022-07-24 17:41:04', 'Female', '1987-01-27', '0991-361281', 'litao@xiong.com', 'B%6GpGYE&H', '約旦', '碩士', 1, 1, '英語', '一週約28到42小時'),
  ('惠婷', '王', 'yanduan', NULL, '2023-01-15 06:17:29', 'Female', '1961-06-03', '0901316761', 'ganglong@gmail.com', 'O$67AggKe!', '加拿大', '博士后', 0, 0, '英語', '一週大於42小時'),
  ('志豪', '林', 'leixia', NULL, '2024-04-27 19:24:09', 'Male', '1984-11-27', '0910224528', 'juan39@gmail.com', '(lR$nYpfF3', '奧地利', '高中', 1, 0, '葡萄牙語', '一週約14到28小時'),
  ('心怡', '陳', 'wen94', '宅宅', '2020-09-14 08:33:37', 'Female', '1998-05-17', '0938-375129', 'fang71@duan.tw', 'M%5gtXps0r', '摩洛哥', '小學', 1, 0, '阿拉伯語', '一週約14到28小時'),
  ('慧君', '林', 'chunliu', '白癡才取綽號', '2021-02-01 23:31:02', 'Female', '1985-07-01', '0955-173981', 'chunpei@li.tw', 'gZw8&$3m^E', '台灣', '高中', 0, 1, '德語', '一週約14到28小時'),
  ('淑芬', '張', 'miao48', '餓了吃麥當勞', '2023-03-10 14:22:17', 'Female', '1973-04-02', '0955-274616', 'wen92@gmail.com', 'G*4zSxvc2%', '巴西', '國中', 1, 1, '中文', '一週小於14小時'),
  ('韻如', '劉', 'duanliu', NULL, '2021-12-12 05:00:19', 'Female', '1996-01-21', '0971-184543', 'mingchen@zeng.org', '%L3tV^Xh9a', '白俄羅斯', '大學', 0, 1, '法語', '一週約28到42小時'),
  ('志強', '葉', 'min96', '渴了要喝奶茶', '2020-07-07 09:23:45', 'Male', '1990-10-23', '0950-379180', 'jun64@yahoo.com', 'c3!ZG*k2Yd', '巴拉圭', '碩士', 0, 0, '西班牙語', '一週約28到42小時'),
  ('建宏', '楊', 'pei66', '鼎泰豐難波萬', '2021-05-18 10:38:01', 'Male', '1970-08-05', '0905-481921', 'xiuying36@xie.org', '2K8#lS9@nW', '印尼', '小學', 1, 1, '英語', '一週約14到28小時'),
  ('宜庭', '鄭', 'long55', '乂煞氣a宣萱乂', '2022-11-22 07:44:45', 'Male', '1987-12-17', '0933-261212', 'longjun@chen.tw', 'H4B*v1Cg2L', '緬甸', '高中', 1, 0, '中文', '一週約14到28小時'),
  ('志偉', '黃', 'zhimin', NULL, '2022-02-28 21:11:16', 'Male', '1991-11-09', '0923-748320', 'yuanwen@xiong.tw', 'dW6R!X9p*q', '南非', '博士后', 0, 0, '阿拉伯語', '一週約14到28小時'),
  ('宜君', '王', 'jing65', NULL, '2023-10-01 14:35:53', 'Female', '1999-08-20', '0992-471266', 'xiaoju@xie.tw', 'S*3rBh%m!c', '台灣', '碩士', 1, 1, '英語', '一週約28到42小時'),
  ('靜怡', '李', 'lifang', '乂煞氣a婷乂', '2020-03-14 17:27:24', 'Female', '1964-02-14', '0935-721483', 'jing87@chuang.tw', 'K#5L^gX1y%', '台灣', '大學', 1, 0, '中文', '一週約14到28小時'),
  ('秀英', '蔡', 'xiu88', NULL, '2023-04-22 10:47:18', 'Female', '1969-12-25', '0930-616211', 'xiuying49@gmail.com', 'e$5iS*3oR!', '巴拿馬', '博士后', 1, 0, '法語', '一週小於14小時'),
  ('建中', '王', 'wangjian', '㊣煞氣a強仔㊣', '2022-01-15 11:58:06', 'Male', '1992-07-13', '0930-345621', 'jian94@zeng.tw', '6@Y!vLz3%p', '台灣', '大學', 1, 1, '英語', '一週約28到42小時'),
  ('雅惠', '黃', 'huangya', NULL, '2020-11-25 20:47:34', 'Female', '1980-03-31', '0945-892211', 'ya94@tan.tw', 'Q#3wLp*oD!', '尼泊爾', '小學', 1, 0, '德語', '一週小於14小時'),
  ('淑芬', '李', 'shufenli', NULL, '2021-08-14 16:19:04', 'Female', '1972-05-13', '0934-361281', 'shufen98@wang.tw', 'p8&G#2lVr!', '奈及利亞', '大學', 0, 1, '西班牙語', '一週約28到42小時'),
  ('建華', '劉', 'jianhua', '↖★乂傻气a咪乂★↘', '2023-06-02 18:49:30', 'Male', '1983-10-08', '0978-635214', 'jianhua@xiong.tw', 'u5^6cLp1*%', '摩洛哥', '高中', 0, 0, '葡萄牙語', '一週大於42小時'),
  ('瑞珍', '林', 'rui88', NULL, '2023-11-08 22:08:05', 'Female', '1976-04-29', '0975-725426', 'ruizhen@zhuang.tw', 'tG5%xR!mN4', '斯里蘭卡', '博士', 1, 1, '英語', '一週小於14小時');

  --老師(20)
INSERT INTO teacher (
  teacher_first_name,
  teacher_last_name,
  teacher_username,
  teacher_registration_date,
  teacher_gender,
  teacher_birth,
  teacher_mobile,
  teacher_email,
  teacher_password,
  teacher_country,
  subject,
  experience,
  status,
  teacher_education,
  certification,
  teach_time,
  strength,
  teacher_forum_status,
  teacher_course_status
)
VALUES
  ('彥廷', '楚', 'fang59', '2022-10-18 00:16:38', 'unspecified', '1970-08-19', '00-8587591', 'nduan@duan.net', 'R(40w6FcTi', '聖露西亞', 'evolve frictionless portals', 'Less than 5 years', 'part_time', 'Bachelor''s', '謝謝我的重要產品.', 'Evening', '教學經驗豐富，深受學生喜愛，課程內容生動有趣，效果顯著。', 0, 1),
  ('中山', '黃', 'yaoyang', '2021-09-23 06:36:48', 'unspecified', '1963-03-02', '(04) 44509041', 'juanluo@gmail.com', '(Ex6yCjd_)', '波蘭', 'strategize turn-key web services', 'More than 10 years', 'part_time', 'Master''s', '首頁工作完成注意男人搜索.', 'Evening', '專業知識深厚，因材施教，激發學生潛能，成果斐然。', 1, 0),
  ('佩君', '陳', 'fanlei', '2023-04-26 05:52:01', 'female', '1969-08-05', '01-19428289', 'xiawei@qiao.org', 'Ng59TjoN_8', '塞席爾', 'transform bleeding-edge platforms', 'Less than 5 years', 'part_time', 'Master''s', '結果包括很多為什上海.', 'Morning', '專業知識深厚，因材施教，激發學生潛能，成果斐然。', 1, 0),
  ('雅涵', '杜', 'liwei', '2020-03-20 13:48:29', 'female', '1967-07-11', '0905-593503', 'meifang@liu.tw', 'K6+9G@TpV3', '法國', 'reintermediate integrated systems', 'More than 10 years', 'full_time', 'PhD', '專家研究一下可能.', 'Full Day', '耐心細致指導，學生理解力顯著增強，反饋積極，教學質量高。', 1, 1),
  ('欣怡', '張', 'shenjuan', '2023-10-13 19:49:50', 'female', '1988-04-21', '(06) 47153823', 'chao62@yahoo.com', 'O2f$A4UfsF', '巴貝多', 'aggregate bleeding-edge architectures', '5 to 10 years', 'part_time', 'Bachelor''s', '當前是否無法決定還有.', 'Morning', '教學風格靈活多變，有效激勵學生，成績顯著提升，深受好評。', 1, 0),
  ('淑華', '劉', 'guiyingyin', '2023-01-11 22:35:02', 'unspecified', '1989-02-27', '(00) 93469903', 'gfang@gmail.com', 'X7+5^Ms1+8', '葉門', 'aggregate efficient communities', '5 to 10 years', 'part_time', 'Bachelor''s', '准備技術主題應用你們一定.', 'Morning', '嚴謹治學，公正無私，善於啟發思考，培養學生獨立能力。', 1, 1),
  ('冠霖', '朱', 'lei43', '2020-01-02 01:33:53', 'unspecified', '1957-05-24', '0935-138698', 'gwei@yahoo.com', '#LAhKe&5r2', '千里達及托貝哥', 'unleash robust niches', 'More than 10 years', 'full_time', 'PhD', '現在管理但是沒有無法過程制作.', 'Morning', '善於調動學生學習熱情，寓教於樂，學生學習動力強。', 0, 0),
  ('雅涵', '莫', 'tao02', '2020-09-26 16:38:03', 'male', '1986-11-25', '0900081653', 'xiulanxia@yahoo.com', '#QbyW)Rn0)', '義大利', 'architect bleeding-edge models', 'More than 10 years', 'part_time', 'Master''s', '不同信息歷史發展有關一樣.', 'Morning', '善於調動學生學習熱情，寓教於樂，學生學習動力強。', 0, 1),
  ('家瑜', '敖', 'juan14', '2023-01-11 13:56:23', 'female', '1982-02-08', '08-5762110', 'hluo@lin.com', '@3Tlmxdn$O', '安哥拉', 'target sticky experiences', 'More than 10 years', 'full_time', 'Bachelor''s', '東西科技帖子業務可以.', 'Evening', '善於調動學生學習熱情，寓教於樂，學生學習動力強。', 0, 0),
  ('冠廷', '宋', 'yong14', '2021-12-26 13:31:54', 'male', '1971-09-12', '09-8720504', 'yong43@hu.com', '9)F*4A$@mx', '斯洛伐克', 'engineer impactful action-items', 'Less than 5 years', 'full_time', 'PhD', '行業實現上海.', 'Morning', '圖片其他一般情況聯系分析音樂.', 0, 1),
  ('俊宏', '李', 'fangshi', '2024-02-18 19:39:48', 'unspecified', '1956-04-17', '0917-934461', 'yuwen@pei.org', 'S4n!z3MkV5', '澳大利亞', 'implement scalable solutions', 'More than 10 years', 'full_time', 'PhD', '使用管理時間需要.', 'Afternoon', '技術支持留言發現情況增加運行.', 0, 0),
  ('淑貞', '周', 'yongtao', '2022-09-22 05:38:12', 'unspecified', '1955-05-28', '(03) 76650604', 'tao81@hotmail.com', 'gkw59DDfK+', '愛沙尼亞', 'integrate plug-and-play paradigms', 'More than 10 years', 'part_time', 'Master''s', '決定部分任何發現其他也是.', 'Full Day', '可以這是應該台灣一些工具自己管理技術.', 0, 1),
  ('惠如', '楊', 'ktan', '2021-08-02 21:41:53', 'male', '1960-12-21', '0912-047470', 'xia58@yi.tw', 'jAM!7vGqaH', '俄羅斯', 'maximize bleeding-edge communities', '5 to 10 years', 'full_time', 'PhD', '汽車介紹最大的話價格等級學習.', 'Evening', '更多發現喜歡也是那些功能聯系.', 0, 0),
  ('沖', '齊', 'ohao', '2020-01-19 21:08:01', 'female', '1963-01-30', '01-79904686', 'smao@zhu.net', '(1zaVE0bD9', '巴林', 'target dot-com infrastructures', '5 to 10 years', 'full_time', 'PhD', '一直國家下載歡迎.', 'Morning', '國際大家到了圖片兩個可以介紹搜索各種.', 1, 0),
  ('淑貞', '李', 'wsun', '2022-12-07 05:43:52', 'male', '1958-11-19', '003 55356810', 'leihe@yang.org', '2OYvNrgq^O', '白俄羅斯', 'incentivize global channels', '5 to 10 years', 'part_time', 'Master''s', '類別同時開發他的作者.', 'Full Day', '人員最新計劃規定問題歷史其實軟體經濟.', 1, 1),
  ('龍', '胡', 'emao', '2020-06-24 05:59:35', 'male', '1986-02-17', '039 10260339', 'xiuyingkong@yahoo.com', '_91KUoJXXY', '幾內亞', 'revolutionize open-source users', '5 to 10 years', 'full_time', 'Bachelor''s', '無法能夠孩子學生市場女人隻要.', 'Evening', '制作系列的話信息情況為什注冊.', 1, 1),
  ('嘉玲', '張', 'wugang', '2020-04-02 17:53:52', 'female', '1956-10-12', '04-22828776', 'shiping@hotmail.com', 'B5I!8cIn$D', '俄羅斯', 'orchestrate vertical web services', '5 to 10 years', 'part_time', 'Master''s', '簡介這是開始這個次數程序.', 'Full Day', '網站因此有關次數工程等級所以報告工程參加的話會員覺得.', 1, 1),
  ('威廷', '羅', 'yang85', '2020-06-11 00:37:18', 'male', '1982-06-02', '05-6912743', 'ming79@yahoo.com', 'OyZ1ggxf^1', '約旦', 'reinvent innovative mindshare', 'Less than 5 years', 'full_time', 'Master''s', '實現有關也是解決幫助.', 'Morning', '類型最新學校自己網絡經驗以后類別同時得到服務全國之后.', 0, 1),
  ('依婷', '晏', 'fangzhou', '2022-01-16 16:32:42', 'unspecified', '1997-06-04', '0949045030', 'xiulanjia@cui.com', '美國', '斯里蘭卡', 'unleash integrated models', 'More than 10 years', 'part_time', 'Master''s', '計劃因為客戶生產如此.', 'Evening', '法律分析是一那個游戲這裡因此名稱.', 1, 1),
  ('雅涵', '牟', 'ghu', '2021-06-05 07:19:21', 'female', '1977-06-13', '(01) 70456546', 'chao94@hotmail.com', '^)J4+xHx((', '開曼群島', 'harness visionary metrics', 'More than 10 years', 'full_time', 'PhD', '介紹記者品牌包括目前建設.', 'Full Day', '安全系統威望提供工具積分經營合作那個.', 1, 0);


--課程(40)
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
    (1, '油畫基礎', '學習油畫的基本技巧', '藝術', 1500),
    (2, '法語入門', '從零開始學習法語', '語言', 1200),
    (3, 'Python程式設計', 'Python程式設計基礎課程', '程式設計', 2500),
    (4, '影片剪輯入門', '學習如何使用影片剪輯軟體', '影片剪輯', 1800),
    (5, '基礎物理', '物理學基礎課程', '科學', 2200),
    (6, '商業管理', '了解基本的商業管理概念', '商業', 3000),
    (7, '素描技法', '素描的基本技巧和應用', '藝術', 1400),
    (8, '西班牙語初級', '西班牙語的基礎入門課程', '語言', 1300),
    (9, 'Java程式設計', 'Java程式設計入門', '程式設計', 2600),
    (10, '高級影片剪輯', '進階影片剪輯技巧', '影片剪輯', 2000),
    (11, '化學實驗', '動手進行化學實驗', '科學', 2400),
    (12, '創業入門', '學習如何開始創業', '商業', 3200),
    (13, '水彩畫技巧', '學習水彩畫的基本技巧', '藝術', 1600),
    (14, '德語基礎', '德語的基礎入門課程', '語言', 1100),
    (15, 'C++程式設計', 'C++程式設計基礎', '程式設計', 2700),
    (16, '動畫製作', '學習動畫製作的基本技巧', '影片剪輯', 2100),
    (17, '天文學入門', '了解天文學的基本知識', '科學', 2300),
    (18, '市場行銷', '學習市場行銷的基本策略', '商業', 3100),
    (19, '攝影藝術', '學習攝影的基本技巧', '藝術', 1700),
    (20, '日語初級', '日語的基礎入門課程', '語言', 1400),
    (1, '網頁設計', '學習如何設計網頁', '程式設計', 2800),
    (2, '影片特效', '學習影片特效製作', '影片剪輯', 2200),
    (3, '生物學基礎', '生物學的基本知識', '科學', 2500),
    (4, '財務管理', '學習如何管理財務', '商業', 3300),
    (5, '現代藝術', '了解現代藝術的發展', '藝術', 1800),
    (6, '韓語初級', '韓語的基礎入門課程', '語言', 1500),
    (7, '資料結構', '學習資料結構的基本概念', '程式設計', 2900),
    (8, '剪輯軟體應用', '學習如何使用各種剪輯軟體', '影片剪輯', 2300),
    (9, '物理實驗', '動手進行物理實驗', '科學', 2600),
    (10, '國際貿易', '了解國際貿易的基本知識', '商業', 3400),
    (11, '雕塑技法', '學習雕塑的基本技巧', '藝術', 1900),
    (12, '義大利語初級', '義大利語的基礎入門課程', '語言', 1600),
    (13, '算法設計', '學習算法設計的基本原理', '程式設計', 3000),
    (14, '3D動畫製作', '學習3D動畫的基本製作技巧', '影片剪輯', 2400),
    (15, '化學理論', '深入了解化學理論知識', '科學', 2700),
    (16, '人力資源管理', '學習如何進行人力資源管理', '商業', 3500),
    (17, '版畫藝術', '學習版畫的基本技法', '藝術', 2000),
    (18, '俄語入門', '俄語的基礎入門課程', '語言', 1700),
    (19, '軟體工程', '學習軟體工程的基本概念', '程式設計', 3100),
    (20, '影片剪輯特效', '進一步學習影片剪輯中的特效技術', '影片剪輯', 2500);

-- 教師開課課程行事曆資料表(一天一筆資料=一個日期對應一個開課時段)(60)
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
    (1, '2024-06-01', '000000000011111111000000'),
    (1, '2024-06-02', '000000000011111111000000'),
    (1, '2024-06-03', '000000000011111111000000'),
    (2, '2024-06-01', '000000011000011110000000'),
    (2, '2024-06-02', '000000011000011110000000'),
    (2, '2024-06-03', '000000011000011110000000'),
    (3, '2024-06-01', '000000000000001111000000'),
    (3, '2024-06-02', '000000000000001111000000'),
    (3, '2024-06-03', '000000000000001111000000'),
    (4, '2024-06-01', '000000000000000000001111'),
    (4, '2024-06-02', '000000000000000000001111'),
    (4, '2024-06-03', '000000000000000000001111'),
    (5, '2024-06-01', '111110000000000000000000'),
    (5, '2024-06-02', '111110000000000000000000'),
    (5, '2024-06-03', '111110000000000000000000'),
    (6, '2024-06-01', '000000111001100000000000'),
    (6, '2024-06-02', '000000111001100000000000'),
    (6, '2024-06-03', '000000111001100000000000'),
    (7, '2024-06-01', '000000111000000011100000'),
    (7, '2024-06-02', '000000111000000011100000'),
    (7, '2024-06-03', '000000111000000011100000'),
    (8, '2024-06-01', '111000000000000000000111'),
    (8, '2024-06-02', '111000000000000000000111'),
    (8, '2024-06-03', '111000000000000000000111'),
    (9, '2024-06-01', '111111111111000000000000'),
    (9, '2024-06-02', '111111111111000000000000'),
    (9, '2024-06-03', '111111111111000000000000'),
    (10, '2024-06-01', '000111111100000000000111'),
    (10, '2024-06-02', '000111111100000000000111'),
    (10, '2024-06-03', '000111111100000000000111'),
    (11, '2024-06-01', '000000000011111111000000'),
    (11, '2024-06-02', '000000000011111111000000'),
    (11, '2024-06-03', '000000000011111111000000'),
    (12, '2024-06-01', '000000011000011110000000'),
    (12, '2024-06-02', '000000011000011110000000'),
    (12, '2024-06-03', '000000011000011110000000'),
    (13, '2024-06-01', '000000000000001111000000'),
    (13, '2024-06-02', '000000000000001111000000'),
    (13, '2024-06-03', '000000000000001111000000'),
    (14, '2024-06-01', '000000000000000000001111'),
    (14, '2024-06-02', '000000000000000000001111'),
    (14, '2024-06-03', '000000000000000000001111'),
    (15, '2024-06-01', '111110000000000000000000'),
    (15, '2024-06-02', '111110000000000000000000'),
    (15, '2024-06-03', '111110000000000000000000'),
    (16, '2024-06-01', '000000111001100000000000'),
    (16, '2024-06-02', '000000111001100000000000'),
    (16, '2024-06-03', '000000111001100000000000'),
    (17, '2024-06-01', '000000111000000011100000'),
    (17, '2024-06-02', '000000111000000011100000'),
    (17, '2024-06-03', '000000111000000011100000'),
    (18, '2024-06-01', '111000000000000000000111'),
    (18, '2024-06-02', '111000000000000000000111'),
    (18, '2024-06-03', '111000000000000000000111'),
    (19, '2024-06-01', '111111111111000000000000'),
    (19, '2024-06-02', '111111111111000000000000'),
    (19, '2024-06-03', '111111111111000000000000'),
    (20, '2024-06-01', '000111111100000000000111'),
    (20, '2024-06-02', '000111111100000000000111'),
    (20, '2024-06-03', '000111111100000000000111');


--商城
--商品(20)
INSERT INTO product
    (product_name, category, image_url, price, stock, description, created_date, last_modified_date)
VALUES
    ('來學日本語初級1', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20180/2018030969844/2018030969844b.jpg', 277, 15, '來學日本語初級簡介', '2023-01-05 10:45:00', '2023-02-18 15:30:00'),
    ('基礎聽力全面掌握', '教材影片', 'https://cdn1.kingstone.com.tw/book/images/product/20180/2018053000395/2018053000395m.jpg', 253, 25, '基礎英語學習影片，適合初學者', '2023-02-05 14:20:00', '2023-02-06 09:45:00'),
    ('圖解流行‧搖滾音樂理論', '教材影片', 'https://cdn1.kingstone.com.tw/book/images/product/20191/2019110047520/2019110047520m.jpg', 450, 35, '音樂理論入門講解', '2023-03-12 16:00:00', '2023-03-13 08:30:00'),
    ('賽先生科學工廠－科學馬克杯系列／優雅化學元素表', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30600/3060000028701/3060000028701b.jpg', 490, 45, '超Geek超天才!用化學元素表自我介紹，這麼天才的事超geek的你一定懂', '2023-01-20 11:00:00', '2023-01-25 14:30:00'),
    ('賽先生科學工廠－科學馬克杯系列／我是天才', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30600/3060000028688/3060000028688b.jpg', 490, 12, '愛好化學的geek們怎麼能不心動!邊喝茶邊查詢元素表真是有夠愜意阿！', '2023-02-10 13:45:00', '2023-02-14 10:15:00'),
    ('世界最神奇的24堂課', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20149/2014940850302/2014940850302b.jpg', 238, 20, '一本在美國被禁70年的致富經典', '2023-03-05 10:30:00', '2023-03-06 12:45:00'),
    ('三麗鷗 多功能抽屜筆筒', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30600/3060000045863/3060000045863b.jpg', 500, 18, '可收納各式文具、小物', '2023-01-25 16:20:00', '2023-01-26 09:10:00'),
    ('最強暢聊法：笑神助攻！越聊越開心的說話術', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20119/2011920768503/2011920768503b.jpg', 238, 22, '專業笑匠的神之授課：溝通力╳搞笑力＝暢聊力', '2023-02-15 12:40:00', '2023-02-16 11:30:00'),
    ('MITTE 隨身 迷你收納包', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30600/3060000045772/3060000045772b.jpg', 323, 30, '適合收納零錢、折疊耳機等小物', '2023-03-01 14:50:00', '2023-03-02 13:20:00'),
    ('生活是碗湯，我手裡只有叉子', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20186/2018630633022/2018630633022b.jpg', 277, 16, '新銳圖文畫家兼心理諮商師「一天到晚氣fufu」療癒來襲', '2023-01-15 10:50:00', '2023-01-25 14:40:00'),
    ('雨天代我為妳哭', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20186/2018630633022/2018630633022b.jpg', 277, 14, '十八個故事，不同的感情狀況，有來不及的，有得不到的，有掙扎徬徨的，有愛著亦被愛的……', '2023-01-30 11:00:00', '2023-01-31 14:30:00'),
    ('小提琴家', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20186/2018630642567/2018630642567b.jpg', 324, 19, '泰絲・格里森完美融合歷史及心理驚悚生涯力作', '2023-02-10 16:30:00', '2023-02-12 15:20:00'),
    ('賽先生科學工廠－自轉地球儀－銀黑', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30800/3080000007143/3080000007143b.jpg', 890, 24, '超熱門辦公室擺飾！放在桌上看著它優雅的旋轉，心情都變好囉，穩定的站立自轉，不會滾走歐！', '2023-02-15 14:20:00', '2023-02-16 10:10:00'),
    ('【STAEDTLER 施德樓】頂極藍桿鉛筆-3H', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/20812/2081211268951/2081211268951b.jpg', 189, 50, '青青 貓行李系列 CDM-393 2025 32K跨年精裝雙線圈手帳(191X140X17mm)', '2023-01-05 10:45:00', '2023-02-18 15:30:00'),
    ('CSS 大全 第五版', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20147/2014713672520/2014713672520b.jpg', 1258, 12, '適合初學者、複習者和對最新發展有興趣的開發者。', '2023-01-10 10:45:00', '2023-02-18 15:30:00'),
    ('【STAEDTLER PREMIUM】RESINA鋼珠筆黑_M尖', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/30800/3080000022385/3080000022385b.jpg', 2680, 21, '以頂級樹脂(RESINA)包覆金屬筆身，簡約的設計、俐落的線條完全展現施德樓德國工藝精神，為PREMIUM系列的入門經典筆款。', '2023-03-01 14:50:00', '2023-03-02 13:20:00'),
    ('乾脆一次搞清楚：最完整詳細網路協定全書(第二版)', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20131/2013120702127/2013120702127b.jpg', 616, 26, '透過上手使用雲端運算、容器、微服務來進一步加深對於網路通訊協定的了解。', '2023-02-05 14:20:00', '2023-02-06 09:45:00'),
    ('Python範例學習書|輕鬆、有趣學習Python程式設計', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20186/2018630633022/2018630633022b.jpg', 308, 40, '快速入門Python程式設計，概念清楚講解，範例具實用性及趣味性。', '2023-02-15 16:00:00', '2023-02-16 10:10:00'),
    ('百樂×MARK S魔擦印章 三角-藍', '周邊商品', 'https://cdn1.kingstone.com.tw/cvlife/images/product/20822/2082281105023/2082281105023b.jpg', 48, 35, '完美裝飾您的筆記本', '2023-01-20 10:45:00', '2023-02-18 15:30:00'),
    ('圖解刑法 (9版)', '實體教材', 'https://cdn1.kingstone.com.tw/book/images/product/20158/2015850050493/2015850050493b.jpg', 300, 15, '新銳圖文畫家兼心理諮商師「一天到晚氣fufu」療癒來襲', '2023-03-01 10:45:00', '2023-03-02 15:30:00');
