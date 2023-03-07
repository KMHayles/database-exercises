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




USE codeup_test_db;

# Lecture: Joins
-- A join is a type of SQL query that combines two or more tables.
-- Use foreign keys to ensure that the data integrity is maintained.

#Inner Join: Only returns connected row on both tables;

#Left Join: Returns all connected rows on the left side, and all connected rows on the right, nulls will be
# inserted if the data is missing (nulls on right)

#Right Join Return all connected and unconnected rows on the right sides
# nulls on left


# Create Tables for the todos and the owners

DROP TABLE IF EXISTS owners;
CREATE TABLE IF NOT EXISTS owners
(
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(30) NOT NULL,
    address    VARCHAR(255),
    created_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS todos;
CREATE TABLE IF NOT EXISTS todos
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    owner_id    INT UNSIGNED,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES owners (id)
);


# Insert data into the todos and owners tables
INSERT INTO owners (name, address)
VALUES ('John Doe', '123 Main St.');
INSERT INTO owners (name, address)
VALUES ('Jane Doe', '456 Main St.');
INSERT INTO owners (name, address)
VALUES ('Joe Doe', '789 Main St.');

SELECT *
FROM owners;

INSERT INTO todos (title, description, owner_id)
VALUES ('Learn SQL', 'Learn how to write SQL queries', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn PHP', 'Learn how to write PHP code', 2);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn MySQL', 'Learn how to write MySQL queries', 3);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn Coding', 'Learn codee at Codeup', 4);

# Create more fake todos and add them to ID 1
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Cook', 'Learn how to  make food', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Code', 'Learn how to write code', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Dance', 'Learn how to dance', 1);


SELECT *
FROM todos;

# TODO: BASIC JOIN QUERY

SELECT *
FROM owners AS o
         JOIN todos t ON (o.id = t.owner_id);



#TODO: Basic Joins with aliases
# same as
SELECT t.*, o.*
FROM owners o
         INNER JOIN todos t ON (o.id = t.owner_id);


-- Output string that says the name of the owner and the name of the todos

SELECT owners.name, todos.title
FROM owners
         JOIN todos ON owners.id = todos.owner_id;



SELECT owners.address, COUNT(todos.title)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.address;


-- list the average age of the the todos in our datasets
SELECT owners.name, AVG(todos.created_at)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.name;



-- List te number of pets at eac addresses


-- List the address with the fewest todos


-- List the address with the most todos
SELECT owners.address, COUNT(todos.id)
FROM owners
         JOIN todos ON todos.owner_id = owners.id
GROUP BY owners.address
ORDER BY COUNT(todos.id) ASC;



-- Find the average age of the todos for each address
-- list the average age of the the ttodos in our datasets
SELECT owners.name, AVG(todos.created_at)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.name;


# Practice Joins:

USE codeup_test_db;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

CREATE TABLE roles
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE users
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) NOT NULL,
    role_id INT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name)
VALUES ('admin');
INSERT INTO roles (name)
VALUES ('author');
INSERT INTO roles (name)
VALUES ('reviewer');
INSERT INTO roles (name)
VALUES ('commenter');

INSERT INTO users (name, email, role_id)
VALUES ('bob', 'bob@example.com', 1),
       ('joe', 'joe@example.com', 2),
       ('sally', 'sally@example.com', 3),
       ('adam', 'adam@example.com', 3),
       ('jane', 'jane@example.com', NULL),
       ('mike', 'mike@example.com', NULL);

SELECT *
FROM roles;
SELECT *
FROM users;

# TODO: output user name and role for all records with a non-null user name and role name

SELECT users.name, roles.name
FROM users
         INNER JOIN roles ON roles.id = users.role_id;


# TODO: output user name and their role name for all matches and all users regardless of null roles (LEFT)

SELECT users.name, roles.name
FROM users
         LEFT JOIN roles ON roles.id = users.role_id;

# TODO: output user name and role for all non-null matches and all roles with null users (RIGHT)
SELECT users.name, roles.name
FROM users
         RIGHT JOIN roles ON roles.id = users.role_id;

USE employees;
SELECT *
FROM employees;
SELECT *
FROM titles;


# TODO: output all current employee names and their current titles
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       t.title,
       t.to_date                              AS end_date
FROM employees e
         JOIN titles t ON t.emp_no = e.emp_no
WHERE t.to_date LIKE '9999%';

# or

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       t.title,
       t.to_date                              AS end_date
FROM employees e
         JOIN titles t ON t.emp_no = e.emp_no
WHERE t.to_date > NOW();

# using aliases


# TODO: output name and current department for employee number 10001

# name field -> employees (E) table
# dept_name -> departments (D) table
# dept_emp (DE) -> Match the emp_no on employees table and the
#               dept_no on the dept_name table


SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name, COUNT(d.dept_name)
FROM employees e
         JOIN dept_emp de ON de.emp_no = e.emp_no
         JOIN departments d ON d.dept_no = de.dept_no
GROUP BY e.emp_no;
WHERE e.emp_no = 10010;



SELECT e.emp_no,
       CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       d.dept_name
FROM employees e
         JOIN dept_emp de ON de.emp_no = e.emp_no
         JOIN departments d ON d.dept_no = de.dept_no
WHERE e.emp_no = 10010
  AND de.to_date > NOW();


USE zenith_test_db;

# Lecture: Joins
-- A join is a type of SQL query that combines two or more tables.
-- Use foreign keys to ensure that the data integrity is maintained.

#Inner Join: Only returns connected row on both tables;

#Left Join: Returns all connected rows on the left side, and all connected rows on the right, nulls will be
# inserted if the data is missing (nulls on right)

#Right Join Return all connected and unconnected rows on the right sides
# nulls on left


# Create Tables for the todos and the owners

DROP TABLE IF EXISTS owners;
CREATE TABLE IF NOT EXISTS owners
(
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(30) NOT NULL,
    address    VARCHAR(255),
    created_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS todos;
CREATE TABLE IF NOT EXISTS todos
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    owner_id    INT UNSIGNED,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES owners (id)
);




# Insert data into the todos and owners tables
INSERT INTO owners (name, address)
VALUES ('John Doe', '123 Main St.');
INSERT INTO owners (name, address)
VALUES ('Jane Doe', '456 Main St.');
INSERT INTO owners (name, address)
VALUES ('Joe Doe', '789 Main St.');

SELECT *
FROM owners;

SELECT * FROM todos;

INSERT INTO todos (title, description, owner_id)
VALUES ('Learn SQL', 'Learn how to write SQL queries', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn PHP', 'Learn how to write PHP code', 2);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn MySQL', 'Learn how to write MySQL queries', 3);

# ERRORS out without an additional owner
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn Coding', 'Learn codee at Codeup', 4);

# Create more fake todos and add them to ID 1
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Cook', 'Learn how to  make food', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Code', 'Learn how to write code', 1);
INSERT INTO todos (title, description, owner_id)
VALUES ('Learn to Dance', 'Learn how to dance', 1);


SELECT *
FROM todos;

# TODO: BASIC JOIN QUERY

SELECT todos.title, owners.name, todos.description FROM todos
                                                            JOIN owners ON todos.owner_id = owners.id;

SELECT todos.title, owners.name, todos.description FROM owners
                                                            JOIN todos ON todos.owner_id = owners.id;



USE employees;

SELECT titles.title, employees.first_name FROM titles
                                                   JOIN employees ON titles.emp_no = employees.emp_no;




# Display each employees name, title, salary

#  FROM salaries JOIN employees JOIN titles

SELECT employees.first_name, titles.title, salaries.salary FROM salaries
                                                                    JOIN employees ON salaries.emp_no = employees.emp_no
                                                                    JOIN titles ON employees.emp_no = titles.emp_no;

SELECT e.first_name, t.title, s.salary FROM titles t
                                                JOIN employees e ON t.emp_no = e.emp_no
                                                JOIN salaries s ON e.emp_no = s.emp_no;


SELECT * FROM titles;
SELECT * FROM employees;



SELECT titles.title, salaries.salary FROM titles
                                              JOIN salaries ON titles.emp_no = salaries.emp_no;

SELECT t.title, s.salary FROM titles AS t
                                  JOIN salaries AS s ON t.emp_no = s.emp_no;














SELECT *
FROM owners AS o
         JOIN todos t ON (o.id = t.owner_id);



#TODO: Basic Joins with aliases
# same as
SELECT t.*, o.*
FROM owners o
         INNER JOIN todos t ON (o.id = t.owner_id);


-- Output string that says the name of the owner and the name of the todos

SELECT owners.name, todos.title
FROM owners
         JOIN todos ON owners.id = todos.owner_id;



SELECT owners.address, COUNT(todos.title)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.address;


-- list the average age of the the todos in our datasets
SELECT owners.name, AVG(todos.created_at)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.name;



-- List te number of pets at eac addresses


-- List the address with the fewest todos


-- List the address with the most todos
SELECT owners.address, COUNT(todos.id)
FROM owners
         JOIN todos ON todos.owner_id = owners.id
GROUP BY owners.address
ORDER BY COUNT(todos.id) ASC;



-- Find the average age of the todos for each address
-- list the average age of the the todos in our datasets
SELECT owners.name, AVG(todos.created_at)
FROM owners
         JOIN todos ON owners.id = todos.owner_id
GROUP BY owners.name;


# Practice Joins:

USE zenith_test_db;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

CREATE TABLE roles
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE users
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) NOT NULL,
    role_id INT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name)
VALUES ('admin');
INSERT INTO roles (name)
VALUES ('author');
INSERT INTO roles (name)
VALUES ('reviewer');
INSERT INTO roles (name)
VALUES ('commenter');

INSERT INTO users (name, email, role_id)
VALUES ('bob', 'bob@example.com', 1),
       ('joe', 'joe@example.com', 2),
       ('sally', 'sally@example.com', 3),
       ('adam', 'adam@example.com', 3),
       ('jane', 'jane@example.com', NULL),
       ('mike', 'mike@example.com', NULL);

SELECT *
FROM roles;

SELECT *
FROM users;

# TODO: output user name and role for all records with a non-null user name and role name

SELECT users.name, roles.name
FROM users
         INNER JOIN roles ON roles.id = users.role_id;


# TODO: output user name and their role name for all matches and all users regardless of null roles (LEFT)

SELECT users.name, roles.name
FROM users
         LEFT JOIN roles ON roles.id = users.role_id;

# TODO: output user name and role for all non-null matches and all roles with null users (RIGHT)
SELECT users.name, roles.name
FROM users
         RIGHT JOIN roles ON roles.id = users.role_id;

USE employees;
SELECT *
FROM employees;
SELECT *
FROM titles;


# TODO: output all current employee names and their current titles
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       t.title,
       t.to_date                              AS end_date
FROM employees e
         JOIN titles t ON t.emp_no = e.emp_no
WHERE t.to_date LIKE '9999%';

# or

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       t.title,
       t.to_date                              AS end_date
FROM employees e
         JOIN titles t ON t.emp_no = e.emp_no
WHERE t.to_date > NOW();

# using aliases


# TODO: output name and current department for employee number 10001

# name field -> employees (E) table
# dept_name -> departments (D) table
# dept_emp (DE) -> Match the emp_no on employees table and the
#               dept_no on the dept_name table


SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name, COUNT(d.dept_name)
FROM employees e
         JOIN dept_emp de ON de.emp_no = e.emp_no
         JOIN departments d ON d.dept_no = de.dept_no
GROUP BY e.emp_no;
WHERE e.emp_no = 10010;



SELECT e.emp_no,
       CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       d.dept_name
FROM employees e
         JOIN dept_emp de ON de.emp_no = e.emp_no
         JOIN departments d ON d.dept_no = de.dept_no
WHERE e.emp_no = 10010
  AND de.to_date > NOW();
