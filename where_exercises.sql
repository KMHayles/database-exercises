USE employees;

# Part One
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT last_name FROM employees
WHERE last_name LIKE 'e%';

SELECT last_name FROM employees
WHERE last_name LIKE '%q%';

# Part Two
SELECT emp_no, first_name, last_name, gender
FROM employees
WHERE gender = 'M'
    AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');

SELECT last_name
FROM employees
WHERE last_name LIKE 'e%' OR last_name like '%e';


SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e';

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%'








