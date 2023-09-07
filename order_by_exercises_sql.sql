


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
-- A. Irena Acton, Viya Zweizig

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
-- A. 16
-- A. Khun Bernini
-- A. Douadi Pettis