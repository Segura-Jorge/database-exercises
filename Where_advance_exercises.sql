use employees;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
SELECT emp_no 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya'); 
-- A.= 10200, 10397, 10610
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
SELECT emp_no
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- A.= 10200, 10397, 10610
-- yes it matches previous answers
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.
SELECT emp_no
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
AND gender = 'M';
-- A. = 10200, 10397, 10821
-- Find all unique last names that start with 'E'.
SELECT distinct last_name
FROM employees
WHERE last_name LIKE 'E%';
-- Find all unique last names that start or end with 'E'.
SELECT distinct last_name
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
-- Find all unique last names that end with E, but does not start with E?
SELECT distinct last_name
FROM employees
WHERE last_name LIKE '%e'
AND last_name NOT LIKE 'e%';
-- Find all unique last names that start and end with 'E'.
SELECT distinct last_name
FROM employees
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%e';
-- can actually type it as "Like 'e%e'"
-- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
SELECT emp_no
FROM employees
WHERE hire_date >= '1990-01-01' AND hire_date < '2000-01-01';
-- A.= 10008, 10011, 10012
-- can also wrtie it as " hire_date between '
-- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT emp_no, hire_date
FROM employees
WHERE birth_date like '%12-25';
-- A.= 10078, 10115, 10261
-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
SELECT emp_no, hire_date, birth_date
FROM employees
WHERE hire_date >= '1990-01-01' AND hire_date < '2000-01-01'
AND birth_date like '%12-25';
-- A.= 10261, 10438, 10681
-- Find all unique last names that have a 'q' in their last name.
SELECT distinct last_name
FROM employees
WHERE last_name like '%q%';
-- Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT distinct last_name
FROM employees
WHERE last_name like '%q%' and last_name NOT LIKE '%qu%';