-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM roles;

SELECT *
FROM users;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

SELECT users.`name` as user_name, roles.`name` as role_name
FROM users
JOIN roles ON users.role_id = roles.id;
-- 

SELECT users.`name` AS user_name, roles.`name` AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
-- 

SELECT users.`name` AS user_name, roles.`name` AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
-- 

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT roles.`name` AS role_name, COUNT(users.id) AS user_count
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles.`name`;
--

-- 1. Use the employees database.
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
	

-- ---------------------------------------------------------------
SELECT dept_name as 'Department Name',
		dept_no
FROM departments;

SELECT emp_no, dept_no
FROM dept_manager
WHERE to_date > curdate();

SELECT emp_no, first_name, last_name, CONCAT(first_name, ' ', last_name) as 'Department Manager'
FROM employees;
-- ---------------------------------------------------------------
SELECT d.dept_name as 'Department Name', CONCAT(e.first_name, ' ', e.last_name)
FROM departments as d
INNER JOIN dept_manager as dm
ON dm.dept_no = d.dept_no
INNER JOIN employees as e
ON e.emp_no=dm.emp_no
WHERE dm.to_date > CURDATE()
ORDER BY d.dept_name;


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
) as c
ON b.emp_no  = c.emp_no
ORDER by dept_name
;

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- ----------------------------------------------------------------------------------------------------------

-- 3. Find the name of all departments currently managed by women.
-- First Try :(
			-- SELECT *
			-- 	FROM employees as e
			--     JOIN dept_manager as d
			--     ON e.emp_no = d.emp_no 
			--      JOIN departments as n
			--      on n.dept_no = d.dept_no
			--     WHERE gender = 'F';
SELECT d.dept_name as 'Department Name', CONCAT(e.first_name, ' ', e.last_name) as 'Department Manager'
FROM departments as d
INNER JOIN dept_manager as dm
ON dm.dept_no = d.dept_no
INNER JOIN employees as e
ON e.emp_no=dm.emp_no
WHERE dm.to_date > CURDATE()
AND e.gender = 'F'
ORDER BY d.dept_name;


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
ORDER by dept_name
;


-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil
-- ----------------------------------------------------------------------------------------------------------

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT *
FROM titles;

SELECT emp_no, dept_no, to_date
FROM dept_emp
WHERE dept_no = 'd009'; -- d009 is Customer Service department


SELECT emp_no, title, to_date
FROM titles
WHERE to_date > curdate();

SELECT dept_no
FROM departments;

SELECT t.title as 'Title', COUNT(t.title) as 'Count'
FROM titles as t
INNER JOIN employees as e
ON e.emp_no = t.emp_no
INNER JOIN dept_emp as de
ON de.emp_no = e.emp_no
WHERE de.to_date > CURDATE()
AND t.to_date > CURDATE()
AND de.dept_no = 'd009'
GROUP BY t.title
ORDER BY title
;



SELECT title as 'Title', Count(c.title) as 'Count'
FROM departments as a
JOIN(
SELECT emp_no, dept_no, to_date
FROM dept_emp
WHERE dept_no = 'd009'
) as b
ON a.dept_no = b.dept_no
JOIN(
SELECT emp_no, title, to_date
FROM titles
WHERE to_date > curdate()
) as c
ON b.emp_no = c.emp_no
group by title
order by title;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241
-- ----------------------------------------------------------------------------------------------------------

-- 5.  Find the current salary of all current managers.
SELECT emp_no, salary
FROM salaries
WHERE to_date > CURDATE();


SELECT d.dept_name as 'Department Name', CONCAT(p.first_name, ' ', p.last_name) as 'Name', s.salary as 'Salary'
FROM departments as d
INNER JOIN dept_manager as dm
ON dm.dept_no =d.dept_no
INNER JOIN employees as e
ON e.emp_no = dm.emp_no
INNER JOIN salaries as s
ON s.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
AND s.to_date > CURDATE()
ORDER BY d.dept_name


;


SELECT dept_name as 'Department Name' ,
		CONCAT(first_name, ' ',last_name) as 'Department Manager', salary
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
) as c
ON b.emp_no  = c.emp_no
JOIN(
SELECT emp_no, salary
FROM salaries
WHERE to_date > CURDATE()
) as d
ON c.emp_no = d.emp_no
ORDER by dept_name;

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- ----------------------------------------------------------------------------------------------------------
-- 6. Find the number of current employees in each department.
SELECT dept_no, dept_name
FROM departments;

SELECT emp_no, to_date
FROM dept_emp
WHERE to_date > CURDATE();

SELECT d.dept_no, d.dept_name, COUNT(*) as num_employees
FROM dept_emp as de
LEFT JOIN departments as d
ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY d.dept_no
;



SELECT a.dept_no, a.dept_name, COUNT(b.emp_no) as num
FROM departments as a
JOIN(
SELECT dept_no, emp_no, to_date
FROM dept_emp
WHERE to_date > CURDATE()
) as b
ON a.dept_no = b.dept_no
group by dept_name
order by dept_no;


-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- ----------------------------------------------------------------------------------------------------------
-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT d.dept_name, AVG(s.salary) as average_salary
FROM salaries as s
LEFT JOIN employees as e
	ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
	ON de.emp_no = e.emp_no
INNER JOIN departments as d
	ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
	AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY avg(s.salary);


select
a.dept_name,
avg(c.salary) as average_salary  
from (
	select distinct dept_name, dept_no from departments) a
join (
	select distinct dept_no, emp_no from dept_emp where to_date > curdate()) b
	on a.dept_no = b.dept_no
join (
	select distinct emp_no, salary from salaries where to_date > curdate()) c
	on b.emp_no = c.emp_no
group by 1 -- 1 refers to the first column in the select statement, 2 to the 2nd, etc
order by 2 desc
limit 1;

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- ----------------------------------------------------------------------------------------------------------
-- 8. Who is the highest paid employee in the Marketing department?

SELECT e.first_name, e.last_name
FROM salaries as s
LEFT JOIN employees as e
	ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
	ON de.emp_no = e.emp_no
INNER JOIN departments as d
	ON d.dept_no = de.dept_no
WHERE d.dept_name = 'marketing'
	AND de.to_date > NOW()
    AND s.to_date > NOW()
    ORDER BY s.salary DESC
    LIMIT 1;



SELECT emp_no, first_name, last_name
FROM employees;

SELECT dept_no, emp_no, to_date
FROM dept_emp;

SELECT emp_no, to_date
FROM salaries
WHERE to_date > CURDATE();

SELECT first_name, last_name
FROM employees as a
JOIN(
SELECT dept_no, emp_no, to_date
FROM dept_emp
where dept_no = 'd001'
) as b
ON a.emp_no = b.emp_no
JOIN(
SELECT emp_no, to_date, salary
FROM salaries
WHERE to_date > CURDATE()
) as c
ON b.emp_no = c.emp_no
order by salary DESC
limit 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- ----------------------------------------------------------------------------------------------------------
-- 9. Which current department manager has the highest salary?

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees as e
INNER JOIN dept_manager as dm
	ON dm.emp_no = e.emp_no
LEFT JOIN salaries as s
	ON s.emp_no = e.emp_no
INNER JOIN departments as d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW()
	AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1
;



-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- ----------------------------------------------------------------------------------------------------------
-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT d.dept_name, ROUND(AVG(s.salary)) as average_salary
FROM salaries as s
LEFT JOIN dept_emp as de
	ON de.emp_no = s.emp_no
INNER JOIN departments as d
	ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY ROUND(avg(s.salary)) DESC
;


-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- ----------------------------------------------------------------------------------------------------------
-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', 
	g.dept_name AS 'Department Name',
	CONCAT(man_e.first_name, ' ', man_e.last_name) AS 'Manager Name'
FROM employees AS e
	JOIN dept_emp AS f 
    ON f.emp_no = e.emp_no
	JOIN departments AS g 
    ON g.dept_no = f.dept_no
	JOIN dept_manager AS h 
    ON h.dept_no = f.dept_no
	JOIN employees AS man_e 
    ON man_e.emp_no = h.emp_no
WHERE f.to_date = '9999-01-01' 
	AND h.to_date = '9999-01-01'
ORDER BY g.dept_name, e.emp_no;

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman