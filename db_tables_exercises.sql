-- Exercises

-- Open MySQL Workbench and login to the database server

-- Save your work in a file named db_tables_exercises.sql

-- List all the databases
show databases;
-- Write the SQL code necessary to use the albums_db database
use albums_db;
-- Show the currently selected database
select database();
-- List all tables in the database
show tables;
-- Write the SQL code to switch to the employees database
show databases;
use employees;
-- Show the currently selected database
select database();
-- List all tables in the database
show tables;
-- Explore the employees table. What different data types are present in this table?
describe employees;
	-- int, date, varchar(14), varchar(16), enum, date
    
-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
	-- dept_emp, dept_manager, empoyees, title, salary
    
-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
	-- departments, dept_emp, dept_manager, employees, title
    
-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
	-- dept_emp, employees
    
-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
	-- they are in the same mother database of employees.
    -- they share dept_emp as joiner table
-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
show create table dept_manager;
-- 'CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1'alter
