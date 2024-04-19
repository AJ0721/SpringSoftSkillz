DROP TABLE forum_images;
DROP TABLE forum_post;
DROP TABLE forum_thread;
DROP TABLE forum_category;
DROP TABLE student;
DROP TABLE teacher;
DROP TABLE admin;

SELECT* FROM forum_images;
SELECT* FROM forum_post;
SELECT* FROM forum_thread;
SELECT* FROM forum_category;
SELECT* FROM student;
SELECT* FROM teacher;
SELECT* FROM admin;



CREATE TABLE admin (
   admin_id INT IDENTITY(1,1) PRIMARY KEY,
   admin_account NVARCHAR(30) UNIQUE NOT NULL,
   admin_password NVARCHAR(30) NOT NULL,
   admin_level INT NULL
);

INSERT INTO admin(admin_account, admin_password)
VALUES
	('admin1', 'admin');


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


INSERT INTO student (student_first_name, student_last_name, student_username, student_nickname, student_gender, student_birth, 
	student_mobile, student_email, student_password, student_country, student_education, first_language, learning_frequency) 
VALUES 
	('Alice', 'Johnson', 's1', 'Ally', 'Female', '2001-02-03', 
		'+15005550006', 'alice.johnson@example.com', '111', 'USA', 'Undergraduate', 'English', 'Occasionally'),
	('Brian', 'Walker', 's2', 'Bri', 'Male', '2002-03-04', 
		'+15005550007', 'brian.walker@example.com', '222', 'Canada', 'Graduate', 'French', 'Regularly'),
	('Caitlyn', 'Smith', 's3', 'Catie', 'Unspecified', '2003-04-05', 
		'+15005550008', 'caitlyn.smith@example.com', '333', 'UK', 'Postgraduate', 'English', 'Daily');

SELECT*FROM student;


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


INSERT INTO teacher (teacher_first_name, teacher_last_name, teacher_username, teacher_gender, teacher_birth, teacher_mobile, 
	teacher_email, teacher_password, teacher_country, subject, experience, status, teacher_education, certification, teach_time, strength) 
VALUES 
	('James', 'Miller', 't1', 'male', '1980-05-10', '+15005551001', 'james.miller@example.com', '111', 'USA', 'Mathematics', 
		'10 Years', 'full_time', 'PhD', 'Math Teaching Certification', 'Mornings', 'Problem Solving and Critical Thinking'),
	('Samantha', 'Davis', 't2', 'female', '1985-08-25', '+15005552002', 'samantha.davis@example.com', '222', 'Canada', 'Physics', 
		'8 Years', 'part_time', 'Masters', 'Physics Teaching Certification', 'Afternoons', 'Experimental Physics and Lab Work'),
	('Alex', 'Taylor', 't3', 'unspecified', '1978-11-02', '+15005553003', 'alex.taylor@example.com', '333', 'UK', 'Chemistry', 
		'12 Years', 'full_time', 'PhD', 'Chemistry Teaching Certification', 'Evenings', 'Organic Chemistry and Research');

SELECT*FROM teacher;




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
    forum_category_id INT NOT NULL,
	thread_student_id INT NULL,
	thread_teacher_id INT NULL,
	thread_title VARCHAR(255) NOT NULL,
    thread_created_time DATETIME2 DEFAULT SYSDATETIME() NOT NULL,
    thread_content NVARCHAR(4000) NOT NULL,
    thread_upvote_count INT,
    thread_response_count INT,
    thread_status VARCHAR(20) CHECK (thread_status IN ('VISIBLE', 'LOCKED', 'DELETED')) NOT NULL,
	CONSTRAINT FK_thread_category FOREIGN KEY(forum_category_id) REFERENCES forum_category(forum_category_id),
    CONSTRAINT FK_thread_creator1 FOREIGN KEY(thread_student_id) REFERENCES student(student_id),
    CONSTRAINT FK_thread_creator2 FOREIGN KEY(thread_teacher_id) REFERENCES teacher(teacher_id)
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


GO

CREATE VIEW thread_view 
AS 

SELECT ft.thread_id, ft.forum_category_id, c.forum_category_name, ft.thread_student_id, s.student_username AS username,
    ft.thread_title, ft.thread_content, ft.thread_created_time,ft.thread_upvote_count, ft.thread_response_count, 
	s.student_photo AS photo,  ft.thread_status 
FROM forum_thread ft JOIN student s ON s.student_id = ft.thread_student_id
					JOIN forum_category c ON ft.forum_category_id = c.forum_category_id

UNION ALL

SELECT ft.thread_id, ft.forum_category_id, c.forum_category_name, ft.thread_teacher_id, t.teacher_username AS username,
    ft.thread_title, ft.thread_content, ft.thread_created_time, ft.thread_upvote_count, ft.thread_response_count, 
	t.teacher_photo AS photo, ft.thread_status  
FROM forum_thread ft JOIN teacher t ON t.teacher_id = ft.thread_teacher_id
					JOIN forum_category c ON ft.forum_category_id = c.forum_category_id;

GO

SELECT * FROM thread_view
ORDER BY thread_created_time; 
DROP VIEW thread_view;


--use usertype tinyint to tell student(1) from teacher(2) in java servlet
--CREATE VIEW (UNION ALL 2 table), SELECT the view, and ORDER BY created_time. 
--Views do not allow ORDER BY 'within' the command,  
--but SELECT the view allows you to use ORDER BY

CREATE TABLE forum_post (
    post_id INT PRIMARY KEY IDENTITY(1,1),
	post_student_id INT NULL,
	post_teacher_id INT NULL,
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
GO;


CREATE VIEW post_view 
AS 

SELECT p.post_id, p.post_student_id, s.student_username AS username, ft.thread_id, p.parent_post_id,  
	p.post_content, p.post_upvote_count,p.post_response_count, s.student_photo AS photo,  p.post_created_time, p.post_status 
FROM forum_post p JOIN student s ON s.student_id = p.post_student_id
				 JOIN forum_thread ft ON ft.thread_id = p.thread_id

UNION ALL

SELECT p.post_id, p.post_teacher_id, t.teacher_username AS username, ft.thread_id, p.parent_post_id, 
	p.post_content,p.post_upvote_count,p.post_response_count, t.teacher_photo AS photo,  p.post_created_time, p.post_status 
FROM forum_post p JOIN teacher t ON t.teacher_id = p.post_teacher_id
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

SELECT * FROM forum_category;

