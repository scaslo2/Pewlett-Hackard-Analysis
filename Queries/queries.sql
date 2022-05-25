CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date, to_date)
);

select * from titles;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT emp_no, first_name, last_name
-- INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT dept.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments as dept
INNER JOIN dept_manager
on dept.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
-- INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
	ON ri.emp_no = de.emp_no
WHERE de.to_date = ('1999-01-01');

select * from current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '1999-01-01');
	 
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
		
		
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
-- INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_employees AS de
on (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
on (de.dept_no = d.dept_no);

-- Retirement_info table for Sales team
SELECT 
	ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
FROM retirement_info AS ri
INNER JOIN dept_employees as de
ON ri.emp_no = de.emp_no
INNER JOIN departments as d
on d.dept_no = de.dept_no
WHERE d.dept_name like 'Sales';

-- Retirement_info table for Sales & Development team
SELECT 
	ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
FROM retirement_info AS ri
INNER JOIN dept_employees AS de
ON ri.emp_no = de.emp_no
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY d.dept_name;