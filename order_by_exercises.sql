-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
-- Done

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name
-- In your comments, answer: What was the first and last name in the first row of the results?
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- 1st = Irena Reutenauer
-- Last = Vidya Simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name; 
-- 1st = Irena Acton
-- Last = Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name; 
-- 1st = Irena Acton
-- Last = Maya Zyda


-- 5. Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. Enter a comment with the number of employees returned, 
-- the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no;
-- 899 rows
-- 1st = 10021 Ramzi Erde
-- Last = 499648 Tadahiro Erde


-- 6. Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;
-- 899 employees returened
-- Newest = Teiji Eldridge
-- Oldest = Sergi Erde


-- 7. Find all employees hired in the 90s and born on Christmas
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
-- and the name of the youngest employee who was hired first.
SELECT emp_no, first_name, last_name, birth_date,  hire_date
FROM employees
WHERE hire_date >= '1990-01-01' AND hire_date < '2000-01-01'
AND birth_date like '%12-25'
ORDER BY birth_date, hire_date DESC;
-- 362 employees retured
-- Oldest employee hired last = Khun Bernini
-- Youngest employee hired fist = Douadi Pettis