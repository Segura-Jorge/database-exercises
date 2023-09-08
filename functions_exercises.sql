


-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
/*
- use employees;
-- -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
-- SELECT emp_no 
-- FROM employees
-- WHERE first_name IN ('Irena', 'Vidya', 'Maya'); 
-- -- A.= 10200, 10397, 10610
-- -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
-- SELECT emp_no
-- FROM employees
-- WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- -- A.= 10200, 10397, 10610
-- -- yes it matches previous answers
-- -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.
-- SELECT emp_no
-- FROM employees
-- WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
-- AND gender = 'M';
-- -- A. = 10200, 10397, 10821
-- -- Find all unique last names that start with 'E'.
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name LIKE 'E%';
-- -- Find all unique last names that start or end with 'E'.
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
-- -- Find all unique last names that end with E, but does not start with E?
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name LIKE '%e'
-- AND last_name NOT LIKE 'e%';
-- -- Find all unique last names that start and end with 'E'.
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name LIKE 'E%' 
-- AND last_name LIKE '%e';
-- -- can actually type it as "Like 'e%e'"
-- -- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
-- SELECT emp_no
-- FROM employees
-- WHERE hire_date >= '1990-01-01' AND hire_date < '2000-01-01';
-- -- A.= 10008, 10011, 10012
-- -- can also wrtie it as " hire_date between '
-- -- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
-- SELECT emp_no, hire_date
-- FROM employees
-- WHERE birth_date like '%12-25';
-- -- A.= 10078, 10115, 10261
-- -- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
-- SELECT emp_no, hire_date, birth_date
-- FROM employees
-- WHERE hire_date >= '1990-01-01' AND hire_date < '2000-01-01'
-- AND birth_date like '%12-25';
-- -- A.= 10261, 10438, 10681
-- -- Find all unique last names that have a 'q' in their last name.
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name like '%q%';
-- -- Find all unique last names that have a 'q' in their last name but not 'qu'.
-- SELECT distinct last_name
-- FROM employees
-- WHERE last_name like '%q%' and last_name NOT LIKE '%qu%';
*/

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: 
-- What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER by first_name; 
-- A. Irena Reutenauer, Vidya Simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: 
-- What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER by first_name, last_name; 
-- A. Irena Acton, Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer
-- What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER by last_name, first_name; 
-- A. Irena Acton, Maya Zyda

-- 5. Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with 
-- the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT *
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no;
-- A. 899
-- A. first emplyee = 10021, Ramzi Erde
-- A. last employee = 499648, Tadahiro Erde

-- 6. Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;
-- A. 899
-- A. newest is named Teiji Eldridge
-- A. oldest is named Sergi Erde

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first
SELECT *
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date like '%12-25'
    ORDER BY birth_date ASC, hire_date DESC;
-- A. 362
-- A. Khun Bernini
-- A. Douadi Pettis

-- NOTES FROM DURING CLASS 							09-08-23'
/*--
-- use albums_db;
-- --
-- SELECT MAX(sales) AS MAX
-- 	FROM albums;
-- --
-- Select 
-- 	CONCAT('"', `name`, '"', ' - ' , artist) 
--     AS Album_Artist
-- 	FROM albums;
-- --
-- SELECT
-- 	substr(artist, 2, 5)
--     FROM albums;
-- -- 
--     SELECT
-- 		upper(`name`)
-- 		FROM albums;
-- --
-- SELECT
-- 	replace(lower(artist), "a", "***")
--     FROM albums;
-- --
-- SELECT now();

-- SELECT curdate();
-- --
-- SELECT CONCAT(
--     'TIME of birth ',
--     UNIX_TIMESTAMP() - UNIX_TIMESTAMP('1989-04-03'),
--     ' seconds');
--     
-- -- 
-- SELECT
-- 	cast(sales as signed) as 
--     Rounded_Sales
--     From albums;
*/

-- 1. Copy the order by exercise and save it as functions_exercises.sql.
-- Up above

-- 2. Write a query to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
USE employees;

SELECT concat(first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 3. Convert the names produced in your last query to all uppercase.
SELECT upper(concat(first_name, " ", last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 4. Use a function to determine how many results were returned from your previous query.
SELECT COUNT(upper(concat(first_name, " ", last_name))) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';
-- 899

-- 5. Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),
SELECT (CURDATE() - hire_date) as Days_worked, e.*
FROM employees as e
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date like '%12-25';
    
-- 6. Find the smallest and largest current salary from the salaries table.
SELECT MAX(salary) as Highest_Slary, MIN(salary) as Lowest_Salary
From salaries;
-- Highest = 158220, Lowest = 38623

-- 7. Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born, 
-- and the last two digits of the year that they were born. 
-- Below is an example of what the first 10 rows will look like:
/*
-- +------------+------------+-----------+------------+
-- | username   | first_name | last_name | birth_date |
-- +------------+------------+-----------+------------+
-- | gface_0953 | Georgi     | Facello   | 1953-09-02 |
-- | bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
-- | pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
-- | ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
-- | kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
-- | apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
-- | tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
-- | skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
-- | speac_0452 | Sumant     | Peac      | 1952-04-19 |
-- | dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
-- +------------+------------+-----------+------------+
-- 10 rows in set (0.05 sec)
*/
SELECT 
    CONCAT(
        LOWER(SUBSTRING(first_name, 1, 1)), 			-- First character of first name in lowercase
        SUBSTRING(last_name, 1, 4), 					-- First 4 characters of last name
        '_',
        DATE_FORMAT(birth_date, '%m%y') 				-- Month and last two digits of birth year
    ) AS username,
    first_name,
    last_name,
    birth_date
FROM 
    employees;
