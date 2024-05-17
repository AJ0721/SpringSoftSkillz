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