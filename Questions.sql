/** Top HCL SQL Interview Questions and Answers
Basic SQL Questions
1. What is SQL?

SQL (STRUCTURED QUERY LANGUAGE) IS A LANGUAGE USED FOR MANAGING AND MANIPULATING RELATIONAL DATABASES.

2. What are the different types of SQL statements?

DML: Data Manipulation Language (e.g., SELECT, INSERT, UPDATE, DELETE).

DDL: Data Definition Language (e.g., CREATE, ALTER, DROP).

DCL: Data Control Language (e.g., GRANT, REVOKE).

TCL: Transaction Control Language (e.g., COMMIT, ROLLBACK).

3. What is a primary key?

A primary key is a unique identifier for each record in a table. It must be unique and not null.

4. What is a foreign key?

A foreign key is a column or a set of columns in one table that uniquely identifies a row in another table.

5. What is normalization?

Normalization is the process of organizing data to reduce redundancy and improve data integrity.

Intermediate SQL Questions
6. Explain the different types of joins.

INNER JOIN: Returns rows with matching values in both tables.

LEFT JOIN: Returns all rows from the left table and matched rows from the right table.

RIGHT JOIN: Returns all rows from the right table and matched rows from the left table.

FULL JOIN: Returns rows when there is a match in one of the tables.

7. What is a subquery?

A subquery is a query nested inside another query. It is used to perform operations that need to retrieve data from one query to use in another.

8. What are aggregate functions?

Aggregate functions perform calculations on a set of values and return a single value. Examples include COUNT, SUM, AVG, MIN, and MAX.

9. What is an index?

An index is a database object that improves the speed of data retrieval operations on a table at the cost of additional space and maintenance overhead.

10. Explain the difference between UNION and UNION ALL.

UNION: Combines results from two or more SELECT queries and removes duplicate rows.

UNION ALL: Combines results from two or more SELECT queries and includes all duplicates.

Advanced SQL Questions
11. How do you optimize a slow-running query?

Optimize by analyzing query execution plans, creating indexes, rewriting the query for efficiency, and reducing the amount of data processed.

12. What is a stored procedure?

A stored procedure is a precompiled collection of SQL statements and optional control-of-flow statements stored under a name and processed as a unit.

13. What is a view?

A view is a virtual table based on the result of a SELECT query. It does not store data physically but provides a way to simplify complex queries.

14. How can you retrieve unique values from a column?

Use the DISTINCT keyword in a SELECT statement to retrieve unique values.

15. What is a transaction in SQL?

A transaction is a sequence of operations performed as a single logical unit of work. It ensures data integrity by following properties of ACID (Atomicity, Consistency, Isolation, Durability).**/

--Coding Questions
--16. Write a SQL query to find the second highest salary from a table employees.

SELECT MAX(salary) AS SecondHighestSalary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

--17. Write a SQL query to get the total number of employees in each department.

SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

--18. Write a SQL query to update the salary of employees in department 10 by 10%.

UPDATE employees
SET salary = salary * 1.10
WHERE department_id = 10;

--19. Write a SQL query to delete all employees who joined before January 1, 2020.

DELETE FROM employees
WHERE join_date < ‘2020-01-01’;

--20. Write a SQL query to find employees who have the same salary as at least one other employee.
SELECT employee_id, salary
FROM employees
WHERE salary IN (SELECT salary FROM employees GROUP BY salary HAVING COUNT(*) > 1);

/**
Scenario-Based Questions
21. How would you design a database for an e-commerce application?

Create tables for Customers, Products,Orders,OrderDetails, and Categories.Define relationships between tables and ensure data integrity with foreign keys.

22. Explain how you would handle a many-to-many relationship.

Use a junction table to manage many-to-many relationships. For example, a StudentCourses table linking Students and Courses.

23. How would you implement error handling in SQL?

Use TRY…CATCH blocks in SQL Server or similar constructs in other SQL dialects to handle errors and exceptions.

24. What is the purpose of the GROUP BY clause?

The GROUP BY clause groups rows that have the same values into summary rows, like calculating aggregates for each group.
**/

--25. Write a SQL query to list all employees who do not have managers.

SELECT employee_id, employee_name
FROM employees
WHERE manager_id IS NULL;

--26. Write a SQL query to find the total sales and average sales per month from a sales table.

SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
SUM(sales_amount) AS total_sales,
AVG(sales_amount) AS average_sales
FROM sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
ORDER BY year, month;

--27. How can you identify duplicate rows in a table?
SELECT column1, column2, COUNT(*)
FROM table_name
GROUP BY column1, column2
HAVING COUNT(*) > 1;
--This query finds duplicate rows based on the values in column1 and column2. Adjust the columns as needed to suit your table structure.
