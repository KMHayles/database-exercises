USE employees;

show tables;


# ======================== WHERE CLAUSES

# LIKE keyword - for finding results that contain a substring
# Select the last name from all employees with a last name ending in z

SELECT last_name FROM employees
WHERE last_name LIKE 'a%z';

select first_name, last_name from employees
where first_name like 'a%' AND last_name LIKE '%z';



# DISTINCT - for filtering out duplicate results
# Select distinct first names from employees where first name contains a z

SELECT first_name FROM employees
WHERE first_name LIKE '%z%';

SELECT DISTINCT first_name FROM employees
WHERE first_name LIKE '%z%';

SELECT DISTINCT first_name, last_name FROM employees
WHERE first_name LIKE '%z%';


# BETWEEN - for filtering results within a given range
# Select all employee data where employee number is between 10001 and 10010

describe employees;

SELECT * FROM employees
WHERE emp_no BETWEEN 10001 AND 10010
   OR emp_no BETWEEN 10201 AND 10210;

# IN - for matching with any result within a given set
# Select all employee data for employees with a first name of Georgi or Parto
SELECT *
FROM employees
WHERE first_name LIKE 'Georgi'
   OR first_name LIKE 'Parto';

# REFACTOR...
SELECT *
FROM employees
WHERE first_name IN ('Georgi', 'Parto');




# Select employee number, first name, last name for employees with a last name of Herber, Dredge, Lipner, or Baek
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');

describe employees;

# Chaining WHERE clauses - for defining multiple filtering criteria
# Select all data from female employees where employee number is less than 10200
SELECT * FROM employees
WHERE gender = 'F'
  AND emp_no < 10200;



# Parentheses matter - order of precedence changes the logic of what to include
# Select all employee data from male or female employees with an id less than 10200
SELECT *
FROM employees
WHERE emp_no < 10200
  AND (gender = 'F' OR gender = 'M');

# () can effect the output;

SELECT *
FROM employees
WHERE emp_no < 10200
  AND gender = 'F' OR gender = 'M';


# Select all employee data from female employees with an id less than 10200 or are male employees
SELECT *
FROM employees
WHERE emp_no < 10200
    AND gender = 'F'
   OR gender = 'M';










# ======================== ORDER BY

# Select employee first and last names from highest to lowest employee number
SELECT emp_no, first_name, last_name
FROM employees
ORDER BY emp_no DESC;

# Select employee data from all employees in ascending order by last name
SELECT *
FROM employees
ORDER BY last_name;


# Select employee data from all employees in descending order by last name
SELECT *
FROM employees
ORDER BY last_name DESC;


# Select all female then male employee data for all employees
# with a first name of Leni with last names in descending alphabetical order

SELECT *
FROM employees
WHERE first_name = 'Leni'
ORDER by gender DESC;

DESCRIBE employees;

SELECT *
FROM employees
WHERE first_name = 'Leni'
ORDER by gender DESC, last_name;






# ======================== LIMIT / OFFSET

SELECT * FROM employees
                  LIMIT 16 OFFSET 0;

# pageNo * limit - limit = offset
# 4 * 10 - 10 = 30











USE employees;

# http://www.mysqltutorial.org/mysql-functions.aspx

-- ========== STRING FUNCTIONS (string manipulation) --

-- CONCAT() - used to concatenate strings together

SELECT 'Something';

SELECT CONCAT('Hello', ' ' , 'World');

-- Use CONCAT() to output the following for all employees...
-- "Georgi Facello was born 1953-09-02" (and include column for emp_no)
SELECT
    CONCAT(
            first_name,
            ' ',
            last_name,
            ' was born ',
            birth_date
        ), emp_no
FROM employees;


-- LENGTH() - used to find the length of a string
SELECT LENGTH('supercalifragilisticexpialidocious');

-- Output first_name, and length of first name as two columns
SELECT first_name, LENGTH(first_name) FROM employees;

-- COMBINING FUNCTIONS
# SELECT UPPER(CONCAT("Hello", TRIM(" world   ")));


-- ========== DATE FUNCTIONS (return units of time) --

-- NOW()
SELECT NOW();

-- CURDATE()
SELECT CURDATE();

-- CURTIME()
SELECT CURTIME();

-- UNIX_TIMESTAMP()

SELECT UNIX_TIMESTAMP();

SELECT CONCAT(
               'Teaching people to code for ',
               FROM_UNIXTIME(UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
                             ' seconds'
                   );

-- ========== AGGREGATE FUNCTIONS (info about results) --

-- /////// COUNT()

-- count all table records
SELECT COUNT(*) FROM employees;


-- count total filtered results
SELECT COUNT(*)
FROM employees
WHERE birth_date = '1953-09-02';

-- count each unique instance of a value
SELECT COUNT(DISTINCT birth_date)
FROM employees;


-- count each set of identical results
SELECT birth_date, COUNT(birth_date)
FROM employees
GROUP BY birth_date;


-- MAX() / MIN()
SELECT MAX(birth_date) FROM employees;
SELECT MIN(birth_date) FROM employees;

-- SUM()
SELECT salary, from_date
FROM salaries
WHERE emp_no = 10001
ORDER BY from_date ASC;

SELECT SUM(salary)
FROM salaries
WHERE emp_no = 10001;



-- AVG()

SELECT AVG(salary)
FROM salaries;



-- ========== MATH FUNCTIONS (perform calculations) --

-- ROUND()
SELECT ROUND(AVG(salary))
FROM salaries;

-- COS()

SELECT COS(2);

-- RAND()
SELECT RAND();








================================= GROUP BY

id | name | age | eye_color

1 | 'Fred' | 30 | 'brown'
2 | 'Cindy' | 30 | 'green'
3 | 'Ted' | 40 | 'brown'
4 | 'Fred' | 23 | 'brown'
5 | 'Cathy' | 31 | 'hazel'
6 | 'Cathy' | 20 | 'blue'
7 | 'Fred' | 30 | 'blue'





# Group by name
id | name | age | eye_color


-- Ted Group
3 | 'Ted' | 40 | 'brown'


-- Cathy Group
5 | 'Cathy' | 31 | 'hazel'
6 | 'Cathy' | 20 | 'blue'


-- Cindy Group
2 | 'Cindy' | 30 | 'green'


-- Fred Group
1 | 'Fred' | 30 | 'brown'
4 | 'Fred' | 23 | 'brown'
7 | 'Fred' | 30 | 'blue'



SELECT name, AVG(age) FROM people
GROUP BY name;




# Group by age

id | name | age | eye_color

-- 20 Group
6 | 'Cathy' | 20 | 'blue'

-- 23 Group
4 | 'Fred' | 23 | 'brown'

-- 30 Group
7 | 'Fred' | 30 | 'blue'
2 | 'Cindy' | 30 | 'green'
1 | 'Fred' | 30 | 'brown'

-- 31 Group
5 | 'Cathy' | 31 | 'hazel'

-- 40 Group
3 | 'Ted' | 40 | 'brown'


# Group by eye_color

id | name | age | eye_color

1 | 'Fred' | 30 | 'brown'
2 | 'Cindy' | 30 | 'green'
3 | 'Ted' | 40 | 'brown'
4 | 'Fred' | 23 | 'brown'
5 | 'Cathy' | 31 | 'hazel'
6 | 'Cathy' | 20 | 'blue'
7 | 'Fred' | 30 | 'blue'


# Group by name, age

# id | name | age | eye_color


-- Fred 30 Group
1 | 'Fred' | 30 | 'brown'
7 | 'Fred' | 30 | 'blue'

-- Cindy 30 Group
2 | 'Cindy' | 30 | 'green'

-- Etc...
3 | 'Ted' | 40 | 'brown'

4 | 'Fred' | 23 | 'brown'

5 | 'Cathy' | 31 | 'hazel'

6 | 'Cathy' | 20 | 'blue'





# ================================= GROUP BY BONUSES

# what are the names of the 10 most recently hired females in the company? the first 10? (no group by needed)
# what are the top three most common job titles?
# what is the most common 'from date' for job titles? for staff only?
# what is the highest employee number for an engineer?
# what is the most common birthday?
# what is the most common female birthday? male?
# what is the most common hire date for female and male employees?
# what is the longest last name of someone born on March 8, 1952?
# what is the lowest employee number for the first senior engineers in the company?





# GROUP BY LECTURE

# The "group by" clause is used to aggregate a table into various groups of shared characteristics.
#
# Grouping data is often accompanied with the use of aggregate functions to derive additional information
# about the various groupings.
#
# Most common aggregate functions are:
#
#     MIN()
#     MAX()
#     SUM()
#     AVG()
#     COUNT()
#
# One or multiple columns may be grouped together.
#
# No table columns may exist in a select clause that are not contained in the group by clause.
#
#     The group by clause is after an optional where clause and before an optional order by clause.
#
#     The order of a result set may be by an aggregate column but an aggregate column cannot be referenced in a where clause.
#
# A having clause is a way to use aggregate results as if in a where clause.

use employees;

# Grouping by a single column

SELECT gender FROM employees;

SELECT DISTINCT gender from employees;

SELECT gender FROM employees
GROUP BY gender;


SELECT gender, COUNT(*) from employees
group by gender;

SELECT gender, COUNT(*) from employees
group by gender;

SELECT gender, birth_date, COUNT(*) FROM employees
GROUP BY gender, birth_date ORDER BY birth_date;

# M  1952-02-01  6
# F  1952-02-01  ?
# M  1952-02-02  48
# F  1952-02-02  ?




# Grouping by multiple columns

SELECT first_name, last_name FROM employees
GROUP BY first_name, last_name;

SELECT DISTINCT first_name, last_name FROM employees;

# COUNT function

# Find total number of employees
# SELECT COUNT(*) FROM employees;

# Find the most common name
SELECT first_name, last_name, count(*) FROM employees
GROUP BY first_name, last_name;

SELECT first_name, last_name, count(*) FROM employees
GROUP BY first_name, last_name
ORDER BY count(*) DESC;

# Find the most common female and male name
SELECT first_name, last_name, gender, count(*) FROM employees
GROUP BY first_name, last_name, gender
ORDER BY count(*) desc;



# =========== AGGREGATE FUNCTIONS

# COUNT


# Aggregating with group by

# Find total number of female and male employees
SELECT gender, COUNT(*) FROM employees
GROUP BY gender;

# MIN and MAX
# Select the first and last hire date for each first name
SELECT first_name, MIN(hire_date) as 'First Hired', MAX(hire_date) as 'Last Hired' FROM employees
GROUP BY first_name;

DESCRIBE salaries;

# Find the minimum, maximum, average, and total number of salaries
SELECT COUNT(salary), MIN(salary), MAX(salary), AVG(salary), SUM(salary) FROM salaries;

# Find the min, max, avg, total, and count of each employee's salaries
SELECT emp_no, COUNT(salary), MIN(salary), MAX(salary), AVG(salary), SUM(salary) FROM salaries
GROUP BY emp_no
ORDER BY MAX(salary) DESC;


# show only the first and last name combinations with more than three employees each
select first_name, last_name, count(*) from employees group by first_name, last_name having count(*) > 3 order by count(*) desc;










# Find the most common name
# Find the most common female and male name
# Find total number of female and male employees
# Find the highest employee number of each unique first name
# Select the first and last hire date for each first name
# Find the minimum, maximum, average, and total number of salaries
# Find the min, max, avg, total, and count of each employee's salaries

