-- Tạo database cho hệ thống quản lý thi trắc nghiệm
-- Database Design for Exam Management System - SQL Server

-- Tạo database
CREATE DATABASE ExamManagementSystem;
GO

USE ExamManagementSystem;
GO

-- 1. Bảng người dùng (Users Table)
CREATE TABLE tblUsers (
    username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Instructor', 'Student'))
);

-- 2. Bảng danh mục kỳ thi (Exam Categories Table)
CREATE TABLE tblExamCategories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description NTEXT
);

-- 3. Bảng kỳ thi (Exams Table)
CREATE TABLE tblExams (
    exam_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_title VARCHAR(100) NOT NULL,
    Subject VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    total_marks INT NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES tblExamCategories(category_id)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

-- 4. Bảng câu hỏi (Questions Table)
CREATE TABLE tblQuestions (
    question_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_id INT NOT NULL,
    question_text NTEXT NOT NULL,
    option_a VARCHAR(100) NOT NULL,
    option_b VARCHAR(100) NOT NULL,
    option_c VARCHAR(100) NOT NULL,
    option_d VARCHAR(100) NOT NULL,
    correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('A', 'B', 'C', 'D')),
    FOREIGN KEY (exam_id) REFERENCES tblExams(exam_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Thêm dữ liệu mẫu
-- Insert sample data

-- Thêm danh mục kỳ thi
INSERT INTO tblExamCategories (category_name, description) VALUES
('Quiz', N'Kiểm tra ngắn hàng tuần'),
('Midterm', N'Kỳ thi giữa kỳ'),
('Final', N'Kỳ thi cuối kỳ'),
('Assignment', N'Bài tập đánh giá');

-- Thêm người dùng
INSERT INTO tblUsers (username, Name, password, Role) VALUES
('instructor1', N'Nguyễn Văn A', 'inst1', 'Instructor'),
('instructor2', N'Trần Thị B', 'inst2', 'Instructor'),
('student1', N'Lê Văn C', 'stu1', 'Student'),
('student2', N'Phạm Thị D', 'stu2', 'Student'),
('student3', N'Hoàng Văn E', 'stu3', 'Student');

delete from tblUsers;

-- Thêm kỳ thi
INSERT INTO tblExams (exam_title, Subject, category_id, total_marks, Duration) VALUES
(N'Kiểm tra Toán học tuần 1', N'Toán học', 1, 20, 30),
(N'Thi giữa kỳ Vật lý', N'Vật lý', 2, 50, 90),
(N'Thi cuối kỳ Hóa học', N'Hóa học', 3, 100, 120),
(N'Quiz Tiếng Anh', N'Tiếng Anh', 1, 25, 45);

-- Thêm câu hỏi mẫu
INSERT INTO tblQuestions (exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
-- Câu hỏi cho kỳ thi Toán học
(1, N'Kết quả của phép tính 2 + 3 × 4 là gì?', '20', '14', '11', '24', 'B'),
(1, N'Căn bậc hai của 16 là bao nhiêu?', '2', '4', '6', '8', 'B'),
(1, N'Diện tích hình vuông có cạnh 5cm là?', '20 cm²', '25 cm²', '30 cm²', '10 cm²', 'B'),

-- Câu hỏi cho kỳ thi Vật lý
(2, N'Đơn vị đo lực trong hệ SI là gì?', 'Newton', 'Joule', 'Watt', 'Pascal', 'A'),
(2, N'Vận tốc ánh sáng trong chân không là?', '3×10⁶ m/s', '3×10⁸ m/s', '3×10¹⁰ m/s', '3×10⁴ m/s', 'B'),

-- Câu hỏi cho kỳ thi Hóa học
(3, N'Ký hiệu hóa học của nước là gì?', 'H₂O', 'CO₂', 'NaCl', 'O₂', 'A'),
(3, N'Số proton trong nguyên tử carbon là?', '4', '6', '8', '12', 'B'),

-- Câu hỏi cho Quiz Tiếng Anh
(4, 'What is the past tense of "go"?', 'goed', 'went', 'gone', 'going', 'B'),
(4, 'Which word is a noun?', 'quickly', 'beautiful', 'happiness', 'running', 'C');