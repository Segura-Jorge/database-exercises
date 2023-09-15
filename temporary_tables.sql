USE tobias_2307;

-- 1. --------------------------------------------------------------------------------------------------------------------------------------------------
-- Using the example from the lesson, create a temporary table called employees_with_departments that contains: 
-- first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
-- it means that the query was attempting to write a new table to a database that you can only read.
create temporary table if not exists employees_with_departments 
	(
	id int primary key
	,first_name varchar(50)
    ,last_name varchar(50)
    ,dept_name varchar(50)
	);

insert into employees_with_departments (id,first_name,last_name,dept_name) VALUES
    (1, 'Michael', 'Johnson', 'Development'),
    (2, 'Florence', 'Joyner', 'Finance'),
    (3, 'Usain', 'Bolt', 'Marketing'),
    (4, 'Sonja', 'Richards-Ross', 'Production');

SELECT * 
FROM employees_with_departments;
-- 2. --------------------------------------------------------------------------------------------------------------------------------------------------
-- Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

alter table employees_with_departments add full_name varchar(100);

-- Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments SET full_name = concat(first_name, ' ', last_name)
WHERE id >= '1';
-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?
-- When the table was created, instead of creating two distinct colunms for their individual names, 
-- a single column could have been created.

-- Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE sakila_payment AS
	SELECT *
	FROM sakila.payment;

SELECT *
FROM sakila_payment;
-- 3. --------------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
ALTER TABLE sakila_payment MODIFY amount FLOAT;

UPDATE sakila_payment
SET amount = amount * 100;

ALTER TABLE sakila_payment MODIFY amount INT;

SELECT *
FROM sakila_payment;CREATE TABLE avg_dept_salaries
SELECT employees.d.dept_name AS "dept_name", 
	AVG(employees.s.salary) AS "average_salary"
FROM employees.employees AS e
JOIN employees.dept_emp AS de ON employees.e.emp_no = employees.de.emp_no
JOIN employees.departments AS d ON employees.d.dept_no = employees.de.dept_no
JOIN employees.salaries AS s ON employees.s.emp_no = employees.e.emp_no
WHERE employees.de.to_date > CURDATE()
AND employees.s.to_date > CURDATE()
GROUP BY employees.d.dept_name;

CREATE TABLE overall_average AS
SELECT AVG(employees.s.salary) AS overall_average
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

CREATE TABLE overall_std AS
SELECT STD(employees.s.salary) AS overall_std
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

SELECT dept_name, average_salary,
	((average_salary - (SELECT * FROM overall_average)) / (SELECT * FROM overall_std))
FROM avg_dept_salaries;
-- Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
-- For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
CREATE TABLE avg_dept_salaries_2
SELECT employees.d.dept_name AS "dept_name", 
	AVG(employees.s.salary) AS "average_salary"
FROM employees.employees AS e
JOIN employees.dept_emp AS de ON employees.e.emp_no = employees.de.emp_no
JOIN employees.departments AS d ON employees.d.dept_no = employees.de.dept_no
JOIN employees.salaries AS s ON employees.s.emp_no = employees.e.emp_no
WHERE employees.de.to_date > CURDATE()
AND employees.s.to_date > CURDATE()
GROUP BY employees.d.dept_name;

SELECT *
FROM avg_dept_salaries_2;

CREATE TABLE overall_average AS
SELECT AVG(employees.s.salary) AS overall_average
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

SELECT *
FROM overall_average;

CREATE TABLE overall_std AS
SELECT STD(employees.s.salary) AS overall_std
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

SELECT * 
FROM overall_std;

SELECT dept_name, average_salary,
	((average_salary - (SELECT * FROM overall_average)) / (SELECT * FROM overall_std)) as 'Z-score'
FROM avg_dept_salaries;




