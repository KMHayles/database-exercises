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

SELECT CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager, d.dept_name Department_Name
FROM employees as e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';


