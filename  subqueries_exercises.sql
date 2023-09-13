-- 	1. Find all the current employees with the same hire date as employee 101010 using a subquery.
USE employees;


SELECT hire_date
FROM employees
	where emp_no = '101010';
    
SELECT *
FROM dept_emp
WHERE to_date > NOW()
	and 
    (
    SELECT hire_date
	FROM employees
	where emp_no = '101010'
    );

-- 	2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title FROM titles
WHERE emp_no IN (
		SELECT emp_no FROM employees
		WHERE first_name = 'Aamod');

-- Results in 6 unique titles
SELECT title, count(*) FROM titles 	-- SELECT DISTINCT title
WHERE emp_no IN (
		SELECT emp_no FROM employees
		WHERE first_name = 'Aamod')
GROUP BY title;


-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.
SELECT distinct emp_no from dept_emp
where to_date not like '9%';

select count(*)
FROM 
	(
    SELECT distinct emp_no from dept_emp
where to_date not like '9%'
    ) as count_Former_employees;
    
-- 85108

-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.

SELECT dept_name as 'Department Name' ,
		CONCAT(first_name, ' ',last_name) as 'Department Manager'
FROM departments as a
JOIN(
SELECT emp_no, dept_no
FROM dept_manager
WHERE to_date > curdate()
) as b
ON a.dept_no = b.dept_no
JOIN(
SELECT emp_no, first_name,last_name
FROM employees
WHERE gender = 'F'										-- this line had to be added to only include Female DM
) as c
ON b.emp_no  = c.emp_no
ORDER by 'department manager'
;


-- isamu legleitner, karsten sigstam, leon dassarma, hilary kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT emp_no, CONCAT(first_name, ' ', last_name) as 'Employee', Salary, (SELECT ROUND(avg(salary)) FROM salaries) as 'Historical AVG Salary'
FROM salaries
	JOIN employees as e
		USING (emp_no)
WHERE salary > 
	(
    SELECT avg(salary)
    FROM salaries
    )
    AND to_date > NOW();

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? -- 78
-- (Hint: you can use a built in function to calculate the standard deviation.) 
-- What percentage of all salaries is this? -- % 0.0325
	-- 	Hint You will likely use multiple subqueries in a variety of ways
	-- 	Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

SELECT MAX(salary)
FROM salaries; -- $158220



SELECT ROUND(STDDEV(salary))
FROM salaries; -- 16905

SELECT (SELECT MAX(salary)
FROM salaries) - (SELECT ROUND(STDDEV(salary))
FROM salaries); -- $141315 is the low end of the salaries to look for the count of salaries above it.alter

SELECT count(*)
FROM salaries
WHERE salary >= ( SELECT (SELECT MAX(salary)
FROM salaries) - (SELECT ROUND(STDDEV(salary))
FROM salaries))
AND to_date > NOW(); -- 78

SELECT count(salary) as 'Within 1% of max salary'
FROM salaries
WHERE 
	salary >= 
    (
    SELECT (SELECT MAX(salary)
	FROM salaries) - (SELECT ROUND(STDDEV(salary))
	FROM salaries)
	)
    AND to_date > NOW(); -- 78

SELECT (SELECT count(salary) as 'Within 1% of max salary'
FROM salaries
WHERE 
	salary >= 
    (
    SELECT (SELECT MAX(salary)
	FROM salaries) - (SELECT ROUND(STDDEV(salary))
	FROM salaries)
	)
    AND to_date > NOW()) 
    / 
    (SELECT COUNT(salary)
    FROM salaries
    WHERE to_date > NOW())
    *
    100
    as 'Percent within 1 SD of max pay'
    ;


-- BONUS QUESTIONS
-- Find all the department names that currently have female managers.

-- Find the first and last name of the employee with the highest salary.

-- Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each department.