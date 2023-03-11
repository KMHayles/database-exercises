USE employees;

show tables;

describe dept_manager;

select * FROM employees;

select * FROM dept_manager;

select * FROM departments;

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (
                110022,
                110039,
                110085,
                110114,
                110183,
                110228,
                110303,
                110344,
                110386,
                110420,
                110511,
                110567,
                110725,
                110765,
                110800,
                110854,
                111035,
                111133,
                111400,
                111534,
                111692,
                111784,
                111877,
                111939
                )
ORDER BY first_name;

SELECT d.dept_name Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM employees as e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
ORDER BY d.dept_name;


SELECT d.dept_name Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM employees as e
         JOIN dept_manager as dm ON dm.emp_no = e.emp_no
         JOIN departments as d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND gender = 'F'
ORDER BY d.dept_name;


SELECT CONCAT(t.title) AS 'Title', COUNT(*) AS 'TOTAL' from titles AS t
JOIN dept_emp de ON t.emp_no = de.emp_no
WHERE de.dept_no = 'd009' AND t.to_date = '9999-01-01' AND de.to_date = '9999-01-01'
GROUP BY t.title;


# my version
SELECT t.title, d.dept_name Total
FROM employees as e
JOIN titles as t ON t.title = e.emp_no
JOIN  departments d ON d.dept_name = t.title
WHERE d.dept_name = 'd009'

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'dept_manager', s.emp_no
from employees AS e
JOIN dept_manager AS dm on e.emp_no = dm.emp_no
JOIN departments AS d on dm.dept_no = d.dept_no
JOIN salaries AS s on e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY d.dept_name;



