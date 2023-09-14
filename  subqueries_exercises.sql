-- 	1. Find all the current employees with the same hire date as employee 101010 using a subquery.
USE employees;


SELECT hire_date
FROM employees
	where emp_no = '101010';
    
SELECT *
FROM employees as e
	JOIN dept_emp as de
    ON e.emp_no = de.emp_no
WHERE to_date > NOW()
	and hire_date =
    (
    SELECT hire_date
	FROM employees
	where emp_no = '101010'
    )
;
-- instructor's version
select
	concat(first_name, ' ', last_name) as full_name
    , hire_date
    , to_date
from employees as e
	join dept_emp as de
		on e.emp_no = de.emp_no
where to_date > now()
	and hire_date = 
		( -- inner query
        select hire_date
		from employees
		where emp_no = '101010'
        )
;
    
-- ----------------------------------------------------------------------------------------------------------
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
GROUP BY title
;

-- Instructor's version
select *
from employees
	join titles
		using (emp_no)
where first_name = 'Aamod'
	and to_date > now()
; -- getting all the CURRENT employees named aamod


select * -- distinct title -- use distinct to get only unique titles
from titles
where emp_no IN -- have to use an IN since im pulling back a column of values
		(
        select emp_no
		from employees
			join titles
				using (emp_no)
		where first_name = 'Aamod'
			and to_date > now()
		)
;



-- ----------------------------------------------------------------------------------------------------------
-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code. -- 59900

select e.emp_no
from employees as e 
	join dept_emp as de
		on e.emp_no = de.emp_no
where to_date > now()
; 

select count(*)
from employees
where emp_no NOT IN -- removing everyone who is a currently employee
	(
	select e.emp_no
	from employees as e 
		join dept_emp as de
			on e.emp_no = de.emp_no
	where to_date > now()
    )
;

-- ----------------------------------------------------------------------------------------------------------
-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.
-- ANSWER. isamu legleitner, karsten sigstam, leon dassarma, hilary kambil
SELECT dept_name as 'Department Name' ,
		CONCAT(first_name, ' ',last_name) as 'Department Manager'
FROM departments as a
	JOIN
    (
	SELECT emp_no, dept_no
	FROM dept_manager
	WHERE to_date > curdate()
	) as b
	ON a.dept_no = b.dept_no
	JOIN
    (
	SELECT emp_no, first_name,last_name
	FROM employees
	WHERE gender = 'F'				   -- this line had to be added to only include Female DM
	) as c
	ON b.emp_no  = c.emp_no
ORDER by 'department manager'
;

-- ----------------------------------------------------------------------------------------------------------
-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT  -- COUNT(*) 
		emp_no, CONCAT(first_name, ' ', last_name) as 'Employee', Salary, (SELECT ROUND(avg(salary)) FROM salaries) as 'Historical AVG Salary'
FROM salaries
	JOIN employees as e
		USING (emp_no)
WHERE salary > 
	(
    SELECT avg(salary)
    FROM salaries
    )
AND to_date > NOW()
;

-- Instructor's version
select 
	-- count(*)
	concat(first_name, ' ', last_name), salary, to_date
from employees as e
	join salaries as s
		on s.emp_no = e.emp_no
where s.to_date > now()
 	and salary > 
		(
        select round(avg(salary),2) as avg_sal
		from salaries
        )
;

-- ----------------------------------------------------------------------------------------------------------
-- 6. How many current salaries are within 1 standard deviation of the current highest salary? -- 
-- (Hint: you can use a built in function to calculate the standard deviation.) 

	-- 	Hint You will likely use multiple subqueries in a variety of ways
	-- 	Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

SELECT MAX(salary) - ROUND(STDDEV(salary))
FROM salaries
WHERE to_date > NOW(); -- $140910 is the low end of the salaries to look for the count of salaries above it.alter 

SELECT count(salary) as 'Within 1% of max salary'
FROM salaries
WHERE 
	salary >= 
    (
    SELECT MAX(salary) - ROUND(STDDEV(salary))
FROM salaries
WHERE to_date > NOW()
    )
    AND to_date > NOW()
;
-- 83

-- What percentage of all (past & current) salaries is this? -- %0.0029
SELECT (SELECT count(salary) as 'Within 1% of max salary'
FROM salaries
WHERE 
	salary >= 
    (
    SELECT MAX(salary) - ROUND(STDDEV(salary))
FROM salaries
WHERE to_date > NOW()
    )
    AND to_date > NOW()
    )
    / 
    (SELECT COUNT(salary)
    FROM salaries)
-- WHERE to_date > NOW())
    * 100
    as 'Percent within 1 SD of max pay'
    ;

-- ----------------------------------------------------------------------------------------------------------
-- BONUS QUESTIONS
-- Find all the department names that currently have female managers.
SELECT dept_name as 'Department Name' ,
		CONCAT(first_name, ' ',last_name) as 'Department Manager'
FROM departments as a
	JOIN
    (
	SELECT emp_no, dept_no
	FROM dept_manager
	WHERE to_date > curdate()
	) as b
	ON a.dept_no = b.dept_no
	JOIN
    (
	SELECT emp_no, first_name,last_name
	FROM employees
	WHERE gender = 'F'										-- this line had to be added to only include Female DM
	) as c
	ON b.emp_no  = c.emp_no
ORDER by dept_name
;

-- ----------------------------------------------------------------------------------------------------------
-- Find the first and last name of the employee with the highest salary.
SELECT *
FROM salaries
WHERE to_date > NOW()
ORDER BY salary DESC
LIMIT 1; -- highest salary 

SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no = 253406; -- person with the highest salary using the emp_no

SELECT CONCAT(first_name, ' ', last_name) as 'Name', salary
FROM employees
	JOIN salaries
		USING (emp_no)
WHERE salary = 
	(
    SELECT salary
	FROM salaries
	WHERE to_date > NOW()
	ORDER BY salary DESC
	LIMIT 1
    )
;

-- ----------------------------------------------------------------------------------------------------------
-- Find the department name that the employee with the highest salary works in.

SELECT emp_no
FROM employees
	JOIN salaries
		USING (emp_no)
WHERE salary = 
	(
    SELECT salary
	FROM salaries
	WHERE to_date > NOW()
	ORDER BY salary DESC
	LIMIT 1
    )
;

SELECT dept_no, dept_name as 'Department Name'
FROM dept_emp
JOIN departments as d
	using(dept_no)
where emp_no = 
	(
    SELECT emp_no
	FROM employees
		JOIN salaries
			USING (emp_no)
	WHERE salary = 
	(SELECT salary
	FROM salaries
	WHERE to_date > NOW()
	ORDER BY salary DESC
	LIMIT 1)
    )
    ;

-- ----------------------------------------------------------------------------------------------------------
-- Who is the highest paid employee within each department.

 SELECT first_name,
	last_name,
	max_salary,
    dept_name
from 
	(
	select dept_name, max(salary) as max_salary
	from salaries
		join dept_emp
			using (emp_no)
		join departments
			using (dept_no)
	group by dept_name
    ) as ms
    join salaries as s
		on s.salary = ms.max_salary
	join employees
		using (emp_no)
	ORDER BY max_salary;
