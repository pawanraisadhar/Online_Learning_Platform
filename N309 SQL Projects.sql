Create database Online_Learning_Platform ;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    signup_date DATE
);

INSERT INTO students (student_id, name, email, country, signup_date) VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'India', '2025-01-05'),
(2, 'Amit Kumar', 'amit@gmail.com', 'India', '2025-01-18'),
(3, 'Neha Singh', 'neha@gmail.com', 'India', '2025-02-02'),
(4, 'Pooja Verma', 'pooja@gmail.com', 'India', '2025-02-14'),
(5, 'Rohit Mehta', 'rohit@gmail.com', 'India', '2025-03-01');

select * from students;

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    bio TEXT,
    expertise VARCHAR(100)
);

INSERT INTO instructors (instructor_id, name, bio, expertise) VALUES
(1, 'Ramesh Kumar', 'Senior software developer and trainer', 'Java'),
(2, 'Anita Sharma', 'Data analyst with industry experience', 'Data Science'),
(3, 'Sanjay Verma', 'Web development expert', 'Web Development'),
(4, 'Priya Singh', 'Cloud computing professional', 'AWS'),
(5, 'Mohit Gupta', 'Database specialist', 'SQL');

select * from instructors;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_title VARCHAR(150),
    instructor_id INT,
    category VARCHAR(100),
    price DECIMAL(8,2),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

INSERT INTO courses (course_id, course_title, instructor_id, category, price) VALUES
(101, 'Introduction to Java', 1, 'Programming', 4999.00),
(102, 'Data Science Basics', 2, 'Data Science', 6999.00),
(103, 'Web Development Bootcamp', 3, 'Web Development', 5999.00),
(104, 'AWS Cloud Fundamentals', 4, 'Cloud Computing', 7499.00),
(105, 'Advanced SQL', 5, 'Database', 4499.00);

select * from courses;

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    completion_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, completion_date) VALUES
(1, 1, 101, '2025-01-05', '2025-07-05'),
(2, 2, 102, '2025-01-18', '2025-07-18'),
(3, 3, 103, '2025-02-02', '2025-08-02'),
(4, 4, 104, '2025-02-14', '2025-08-14'),
(5, 5, 105, '2025-03-01', '2025-09-01');

select * from enrollments;

CREATE TABLE modules (
    module_id INT PRIMARY KEY,
    course_id INT,
    module_title VARCHAR(150),
    sequence_number INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO modules (module_id, course_id, module_title, sequence_number) VALUES
(1, 101, 'Java Basics', 1),
(2, 101, 'OOP Concepts', 2),
(3, 101, 'Java Advanced Topics', 3),
(4, 102, 'Data Science Introduction', 1),
(5, 102, 'Python for Data Science', 2),
(6, 102, 'Data Analysis & Visualization', 3),
(7, 103, 'HTML & CSS', 1),
(8, 103, 'JavaScript Basics', 2),
(9, 103, 'Full Stack Project', 3),
(10, 104, 'AWS Fundamentals', 1),
(11, 104, 'Cloud Deployment', 2),
(12, 104, 'Security & Monitoring', 3),
(13, 105, 'SQL Queries', 1),
(14, 105, 'Database Design', 2),
(15, 105, 'Advanced SQL Techniques', 3);

select * from modules;

CREATE TABLE quizzes (
    quiz_id INT PRIMARY KEY,
    module_id INT,
    quiz_title VARCHAR(150),
    max_score INT,
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

INSERT INTO quizzes (quiz_id, module_id, quiz_title, max_score) VALUES
(1, 1, 'Java Basics Quiz', 100),
(2, 2, 'OOP Concepts Quiz', 100),
(3, 3, 'Java Advanced Quiz', 100),
(4, 4, 'Data Science Intro Quiz', 100),
(5, 5, 'Python for DS Quiz', 100),
(6, 6, 'Data Analysis Quiz', 100),
(7, 7, 'HTML & CSS Quiz', 100),
(8, 8, 'JavaScript Basics Quiz', 100),
(9, 9, 'Full Stack Project Quiz', 100),
(10, 10, 'AWS Fundamentals Quiz', 100),
(11, 11, 'Cloud Deployment Quiz', 100),
(12, 12, 'Security & Monitoring Quiz', 100),
(13, 13, 'SQL Queries Quiz', 100),
(14, 14, 'Database Design Quiz', 100),
(15, 15, 'Advanced SQL Techniques Quiz', 100);
 
 select * from quizzes;
 
 -- 1.	List all courses a specific student is enrolled in.
 
 SELECT student_id, course_title
FROM courses
JOIN enrollments
ON courses.course_id = enrollments.course_id
WHERE student_id = 2;

-- 2.	Calculate the course completion rate (percentage of enrollments with a completion_date).

SELECT 
    (COUNT(completion_date) * 100 / COUNT(*)) AS completion_rate_percentage
FROM enrollments;

SELECT enrollment_id, completion_date FROM enrollments;

-- 3.	Find the instructor with the most courses.

SELECT instructors.instructor_id ,instructors.name, COUNT(course_id) AS total_courses
FROM instructors
JOIN courses
ON instructors.instructor_id = courses.instructor_id
GROUP BY instructor_id, name
ORDER BY total_courses DESC;

-- 4.	Identify students who have enrolled in more than 5 courses.

SELECT students.student_id, students.name, COUNT(course_id) AS total_courses
FROM students
JOIN enrollments
ON students.student_id = enrollments.student_id
GROUP BY student_id, name
HAVING COUNT(course_id) > 5;

-- 5.	Calculate the total revenue generated per course category.

SELECT category, SUM(courses.price) AS total_revenue
FROM courses
GROUP BY courses.category;

-- 6.	List all modules for a specific course in sequence order.

SELECT course_id,module_id, module_title, sequence_number
FROM modules
WHERE course_id = 101
ORDER BY sequence_number;

-- 7.	Find courses that have no enrolled students.

SELECT courses.course_id, courses.course_title
FROM courses
LEFT JOIN enrollments
ON courses.course_id = enrollments.course_id
WHERE enrollments.course_id IS NULL;

-- 8.	Calculate the average number of enrollments per course.

SELECT COUNT(*) / COUNT(course_id) AS avg_enrollments_per_course
FROM enrollments;

-- 9.	Identify the most popular course category.

SELECT category, COUNT(enrollment_id) AS total_enrollments
FROM courses
JOIN enrollments
ON courses.course_id = enrollments.course_id
GROUP BY category
ORDER BY total_enrollments DESC ;

-- 10.	Find students who have not completed any courses they enrolled in.

SELECT students.student_id, students.name
FROM students
INNER JOIN enrollments
ON students.student_id = enrollments.student_id
GROUP BY students.student_id, students.name
HAVING COUNT(completion_date) = 0;

SELECT enrollment_id,enrollment_date, completion_date FROM enrollments;

