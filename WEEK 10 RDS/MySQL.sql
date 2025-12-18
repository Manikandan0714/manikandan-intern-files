-- Create a new database named "school"
CREATE DATABASE school;

-- Select the "school" database to work with
USE school;

-- Create a table named "students"
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

-- Insert first student record into the table
INSERT INTO students (name, age, email)
VALUES ('John Doe', 20, 'john@example.com');

-- Insert second student record into the table
INSERT INTO students (name, age, email)
VALUES ('Jane Smith', 22, 'jane@example.com');

-- Display all records from the students table
SELECT * FROM students;

-- Update John's age from 20 to 21
UPDATE students
SET age = 21
WHERE name = 'John Doe';

-- Delete the student record with id = 1
DELETE FROM students
WHERE id = 1;

-- Delete the database named "school" permanently
DROP DATABASE school;
