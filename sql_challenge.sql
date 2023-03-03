-- Departments-----
--------------------------
Drop Table depts;

Create Table depts (
dept_no VARCHAR NOT NULL Primary Key,
dept_name character varying(45) NOT NULL	
);

--------------------------
Select * from depts;


-- Employees-----
--------------------------
Drop Table employees;

Create Table employees (
emp_no INT NOT NULL Primary Key,
emp_title_id VARCHAR NOT NULL,
birth_date Date NOT NULL,
first_name character varying(45) NOT NULL,
last_name character varying(45) NOT NULL,
sex character varying(45) NOT NULL,
hire_date Date NOT NULL
);

Select * from employees;
--------------------------


-- dept_emp-----
--------------------------
Drop Table dept_emp;

Create Table dept_emp (
emp_no INT NOT NULL,
dept_no VARCHAR NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES depts(dept_no)
);

Select * from dept_emp;
--------------------------

-- dept_manager-----
--------------------------
Drop Table dept_manager;

Create Table dept_manager (
dept_no VARCHAR NOT NULL,
emp_no INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES depts(dept_no)
);

Select * from dept_manager;
---------------------------

-- salaries-----
--------------------------
Drop Table salaries;

Create Table salaries (
emp_no INT NOT NULL,
salary INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

Select * from salaries;
---------------------------


-- titles-----
--------------------------
Drop Table titles;

Create Table titles (
title_id VARCHAR NOT NULL Primary Key,
title character varying(45) NOT NULL
);

Select * from titles;
---------------------------


--1. List the employee number, last name, first name, sex, and salary of each employee ---

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.---
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.---
SELECT dept_manager.dept_no, depts.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN depts ON
dept_manager.dept_no = depts.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.---
SELECT depts.dept_no, employees.emp_no, employees.last_name, employees.first_name, depts.dept_name
FROM employees
INNER JOIN dept_manager ON
dept_manager.emp_no = employees.emp_no
INNER JOIN depts ON
dept_manager.dept_no = depts.dept_no;


--- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.---
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


--- 6. List each employee in the Sales department, including their employee number, last name, and first name.---
SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name 
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
WHERE dept_no = 'd007';


---7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.---
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
WHERE dept_no = 'd007' OR dept_no ='d005';


---8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).---
SELECT last_name, COUNT(last_name) FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;


