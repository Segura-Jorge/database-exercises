-- 1. Use the employees database.
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
SELECT *
	FROM employees as e
    JOIN dept_manager as d
    ON e.emp_no = d.emp_no 
    JOIN departments as n
    on n.dept_no = d.dept_no;
    
-- select distinct
-- dept_name,
-- dept_no
-- from departments;

-- select distinct
-- dept_no,
-- emp_no
-- from dept_manager
-- where to_date > current_date();

-- select distinct
-- emp_no,
-- first_name,
-- last_name
-- from employees;

-- select
-- dept_name,
-- concat(c.first_name,' ',c.last_name) as manager_name
-- from departments a
-- join (
-- select distinct
-- dept_no,
-- emp_no
-- from dept_manager
-- where to_date > current_date()
-- ) b
-- on a.dept_no = b.dept_no
-- join (
-- select distinct
-- emp_no,
-- first_name,
-- last_name
-- from employees
-- ) c 
-- on b.emp_no = c.emp_no;



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


-- 3. Find the name of all departments currently managed by women.
SELECT *
	FROM employees as e
    JOIN dept_manager as d
    ON e.emp_no = d.emp_no 
     JOIN departments as n
     on n.dept_no = d.dept_no
    WHERE gender = 'F';

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil


-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT *
FROM employees as e
	JOIN dept_emp as d
    ON e.emp_no = d.emp_no
    WHERE dept_no = 'd009';


-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241


-- 5.  Find the current salary of all current managers.


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


-- 6. Find the number of current employees in each department.


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


-- 7. Which department has the highest average salary? Hint: Use current not historic information.

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


-- 8. Who is the highest paid employee in the Marketing department?


-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+


-- 9. Which current department manager has the highest salary?


-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+


-- 10. Determine the average salary for each department. Use all salary information and round your results.


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


-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.


-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman