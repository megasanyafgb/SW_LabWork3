-- Person-Teacher-Student Relational Database Schema
-- Laboratory Work #3

-- Drop tables if they exist (for clean installation)
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS person;

-- Create Person table (base for inheritance)
CREATE TABLE person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age > 0 AND age <= 150),
    person_type VARCHAR(50) NOT NULL COMMENT 'Type: Teacher or Student'
);

-- Create Teacher table
CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL UNIQUE,
    course VARCHAR(100) NOT NULL COMMENT 'Subject taught',
    work_experience INT NOT NULL DEFAULT 0 COMMENT 'Years of experience',
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    INDEX idx_teacher_course (course)
);

-- Create Student table
CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL UNIQUE,
    teacher_id INT NOT NULL,
    course VARCHAR(100) NOT NULL COMMENT 'Course name',
    student_group VARCHAR(50) NOT NULL COMMENT 'Group number',
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id) ON DELETE RESTRICT,
    INDEX idx_student_teacher (teacher_id),
    INDEX idx_student_group (student_group)
);

-- Insert sample data
INSERT INTO person (name, age, person_type) VALUES 
('John Doe', 40, 'Teacher'),
('Alice', 20, 'Student'),
('Bob', 21, 'Student');

INSERT INTO teacher (person_id, course, work_experience) VALUES 
(1, 'Mathematics', 15);

INSERT INTO student (person_id, teacher_id, course, student_group) VALUES 
(2, 1, 'Mathematics', 'Group A'),
(3, 1, 'Mathematics', 'Group A');
