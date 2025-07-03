drop database ExamManagementSystem;
use master
-- Create database
CREATE DATABASE ExamManagementSystem;
GO

USE ExamManagementSystem;
GO

-- 1. Users Table
CREATE TABLE tblUsers (
    username VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Instructor', 'Student'))
);

-- 2. Exam Categories Table
CREATE TABLE tblExamCategories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- 3. Exams Table
CREATE TABLE tblExams (
    exam_id INT PRIMARY KEY,
    exam_title VARCHAR(100) NOT NULL,
    Subject VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    total_marks INT NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES tblExamCategories(category_id)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

-- 4. Questions Table
CREATE TABLE tblQuestions (
    question_id INT PRIMARY KEY,
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

-- Insert sample data

-- Insert exam categories
INSERT INTO tblExamCategories (category_id, category_name, description) VALUES
(1, 'Quiz', 'Weekly short quizzes'),
(2, 'Midterm', 'Midterm examinations'),
(3, 'Final', 'Final examinations'),
(4, 'Assignment', 'Evaluation assignments');

-- Insert users
INSERT INTO tblUsers (username, Name, password, Role) VALUES
('instructor1', 'Nguyen Van A', 'inst1', 'Instructor'),
('instructor2', 'Tran Thi B', 'inst2', 'Instructor'),
('student1', 'Le Van C', 'stu1', 'Student'),
('student2', 'Pham Thi D', 'stu2', 'Student'),
('student3', 'Hoang Van E', 'stu3', 'Student');

-- Insert exams
INSERT INTO tblExams (exam_id, exam_title, Subject, category_id, total_marks, Duration) VALUES
(1, 'Math Quiz Week 1', 'Mathematics', 1, 20, 30),
(2, 'Midterm Physics Exam', 'Physics', 2, 50, 90),
(3, 'Final Chemistry Exam', 'Chemistry', 3, 100, 120),
(4, 'English Quiz', 'English', 1, 25, 45);

-- Insert sample questions
INSERT INTO tblQuestions (question_id, exam_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
-- Questions for Math Exam
(1, 1, 'What is the result of 2 + 3 × 4?', '20', '14', '11', '24', 'B'),
(2, 1, 'What is the square root of 16?', '2', '4', '6', '8', 'B'),
(3, 1, 'What is the area of a square with 5cm sides?', '20 cm²', '25 cm²', '30 cm²', '10 cm²', 'B'),

-- Questions for Physics Exam
(4, 2, 'What is the SI unit of force?', 'Newton', 'Joule', 'Watt', 'Pascal', 'A'),
(5, 2, 'What is the speed of light in a vacuum?', '3×10⁶ m/s', '3×10⁸ m/s', '3×10¹⁰ m/s', '3×10⁴ m/s', 'B'),

-- Questions for Chemistry Exam
(6, 3, 'What is the chemical symbol for water?', 'H₂O', 'CO₂', 'NaCl', 'O₂', 'A'),
(7, 3, 'How many protons does a carbon atom have?', '4', '6', '8', '12', 'B'),

-- Questions for English Quiz
(8, 4, 'What is the past tense of "go"?', 'goed', 'went', 'gone', 'going', 'B'),
(9, 4, 'Which word is a noun?', 'quickly', 'beautiful', 'happiness', 'running', 'C');

