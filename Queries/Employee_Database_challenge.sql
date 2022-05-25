-- Use Dictinct with Orderby to remove duplicate rows
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	title,
	from_date,
	to_date
INTO retirement_titles
FROM employees AS emp
JOIN titles 
ON emp.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-01-01'
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


--  Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(emp_no),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;


-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT  DISTINCT ON (emp.emp_no) emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	de.from_date,
	de.to_date,
	title
INTO mentorship_eligibilty
FROM employees AS emp
JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN titles
ON emp.emp_no = titles.emp_no
WHERE titles.to_date = '9999-01-01'
AND emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no ASC;
