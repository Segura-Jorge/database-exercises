-- 1. Create a new file named group_by_exercises.sql
-- Done
USE employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
-- 7 


-- 3. Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;


-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT DISTINCT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY first_name, last_name;


-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- Chleq, Lindqvist, Qiwen


-- 6. Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
SELECT DISTINCT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;


-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of 
-- employees with those names for each gender.
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender; 


-- 8. Using your query that generates a username for all employees, generate a count of employees with each unique username.
SELECT DISTINCT lower(CONCAT(SUBSTRING(first_name, 1, 1), 			-- First character of first name in lowercase
        SUBSTRING(last_name, 1, 4), '_',					-- First 4 characters of last name
        DATE_FORMAT(birth_date, '%m%y') 				-- Month and last two digits of birth year
    )) AS username_NEW,
COUNT(*)
FROM employees
GROUP BY username_NEW;


-- 9. From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there?
SELECT DISTINCT lower(CONCAT(SUBSTRING(first_name, 1, 1), 			-- First character of first name in lowercase
        SUBSTRING(last_name, 1, 4), '_',					-- First 4 characters of last name
        DATE_FORMAT(birth_date, '%m%y') 				-- Month and last two digits of birth year
    )) AS username_NEW,
COUNT(*)
-- WHERE COUNT(*) > 1
FROM employees
GROUP BY username_NEW 
ORDER BY COUNT(*) DESC;

-- 6 is the highest number
-- Bonus: How many duplicate usernames are there?
-- SELECT DISTINCT lower(CONCAT(SUBSTRING(first_name, 1, 1), 			-- First character of first name in lowercase
--         SUBSTRING(last_name, 1, 4), '_',					-- First 4 characters of last name
--         DATE_FORMAT(birth_date, '%m%y') 				-- Month and last two digits of birth year
--     )) AS username_NEW,
-- COUNT(*)
-- WHERE COUNT(*) > 1
-- FROM employees
-- GROUP BY username_NEW 
-- HAVING count(*) > 1 as BONUS;


-- Bonus: More practice with aggregate functions:


-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, 
-- you'll probably be grouping by that exact column.
-- select * from salaries;
-- select avg(salary), emp_no
-- From salaries
-- group by emp_no;


-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
-- select * from dept_emp;
-- select dept_no, count(distinct emp_no) as num_current_employees
-- from dept_emp
-- where to_date_ >= now()
-- group by dept_no;


-- Determine how many different salaries each employee has had. This includes both historic and current.
-- select emp_no, count(salary)
-- from salaries
-- group by emp_no
-- order by emp_no;


-- Find the maximum salary for each employee.
-- select emp_no, max(salary)
-- from salaries
-- group by emp_no;


-- Find the minimum salary for each employee.
-- select emp_no, min(salary)
-- from salaries
-- group by emp_no;


-- Find the standard deviation of salaries for each employee.
-- select emp_no, round(std(salary),2), round(stddev(salary),1), count(*)
-- from salaries
-- group by emp_no;


-- Find the max salary for each employee where that max salary is greater than $150,000.
-- select emp_no, max(salary) as max_sal
-- from salaries
-- group by emp_no
-- having max_sal> 150000;


-- Find the average salary for each employee where that average salary is between $80k and $90k.
-- select emp_no, max(salary) as max_sal
-- from salaries
-- group by emp_no
-- having max_sal between 80000 and 90000;
