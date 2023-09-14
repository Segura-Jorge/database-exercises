-- 1. -- ----------------------------------------------------------------------------------------------------------
-- Write a query that returns all employees, their department number, 
-- their start date, 
-- their end date, 
-- and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT database();
USE employees;
SHOW tables;

SELECT 
    *, IF(to_date < NOW(), FALSE, TRUE) AS is_current_employee
FROM
    dept_emp;

SELECT *,
	IF(to_date > NOW(),TRUE, FALSE ) as is_current_employee
FROM dept_emp;

SELECT *,
	IF(NOW() < to_date, TRUE, FALSE) as is_current_employee
FROM dept_emp;

-- 2. -- ----------------------------------------------------------------------------------------------------------
-- Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 
-- 'I-Q', 
-- or 'R-Z' depending on the first letter of their last name.

SELECT *
FROM employees;

SELECT last_name, first_name,
	CASE
		WHEN last_name < 'i%' then 'A-H'
        WHEN LEFT(last_name,1) <= 'q' then 'I-Q'
		ELSE 'R-Z'
	END as 'alpha_group'
FROM employees;
-- ORDER BY last_name;


SELECT CONCAT(last_name, " ", first_name) as Last_First_Names,
	      CASE
			WHEN last_name REGEXP '^[a-h]' THEN "A-F"
			WHEN last_name REGEXP '^[i-q]' THEN "I-Q"	         
			ELSE "R-Z"
	     END AS alpha_group
	 FROM employees;



-- 3. -- ----------------------------------------------------------------------------------------------------------
-- How many employees (current or previous) were born in each decade?
SELECT 
    birth_date
FROM
    employees
ORDER BY birth_date;-- DESC; lowers is 1952, and highest is 1965.

SELECT 
    COUNT(*)
FROM
    employees
WHERE
    birth_date LIKE '195%';
-- The 1950s had 182886 employees birthed

SELECT 
    COUNT(*)
FROM
    employees
WHERE
    birth_date LIKE '196%';
-- The 1960s had 117138 emplyees birthed

SELECT COUNT(*),
	CASE 
		WHEN birth_date LIKE "195%" THEN "1950s"
		WHEN birth_date LIKE "196%" THEN "1960s"
		ELSE "other"
	END AS birth_decade
FROM employees
GROUP BY birth_decade;

-- 4. -- ----------------------------------------------------------------------------------------------------------
-- What is the current average salary for each of the following department groups:
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(s.salary) AS AVG_salary,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            ELSE dept_name
            END AS dept_group
FROM dept_emp AS de 
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
GROUP BY dept_group;
-- I FORGOT TO ONLY CALCU;ATE CURRENT SALARIES FOR EACH DEPARTMENT
-- FIND THE RIGHT ANSWER HERE

-- BONUS -- ----------------------------------------------------------------------------------------------------------
-- Remove duplicate employees from exercise 1

SELECT DISTINCT emp_no,
	CASE
    WHEN to_date > NOW() then '1'
    END as is_current_employee
FROM dept_emp;
    

SELECT DISTINCT emp_no,
	IF(to_date > NOW(),TRUE, FALSE ) as is_current_employee
FROM dept_emp

;



