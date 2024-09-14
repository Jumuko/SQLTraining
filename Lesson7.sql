--version control, joins﻿﻿﻿
--Data Migration
--Left ,Right, Lenght, Exist, Top 

select *
from World

--Left
select CountryName,
left(CountryName,3) as CountryNameAbbr
from World

--Right
select CountryName,
right(CountryName,3) as CountryNameAbr
from World

--lenght
select CountryName,
len(CountryName)  CountryNameLenght
from World

--exist
select *
from HrAnalysis1 as A
where not exists (select *
from HrAnalysisMale as B
where A.Age=B.Age)

select *
from HrAnalysisMale as A
where exists (select *
from HrAnalysis1 as B
where A.Age=B.Age
)


CREATE TABLE EmployeeJoin
(    
name varchar(45) NOT NULL,      
occupation varchar(35) NOT NULL,      
working_date date,    
working_hours varchar(10),  
salary INT  
);  

INSERT INTO EmployeeJoin VALUES      
('Jolly Evans', 'HR', '2020-10-04', 9, 25000),    
('Brayden Simmons', 'Engineer', '2020-10-04', 12, 65000),    
('Rose Huges', 'Writer', '2020-10-04', 13, 35000),    
('Laura Paul', 'Manager', '2020-10-04', 10, 45000),    
('Diego Simmons', 'Teacher', '2020-10-04', 12, 30000),    
('Antonio Bennet', 'Writer', '2020-10-04', 13, 35000);

CREATE TABLE emp_address
(    
name varchar(45),      
cellphone varchar(25),      
address varchar(90),  
city varchar(35)  
);  
INSERT INTO emp_address(name, cellphone, address, city) VALUES   
('Jolly Evans', '334369253659', '777 Brockton Avenue, Abington MA 2351', 'California'),    
('Brayden Simmons', '359436598356', '3849 Route 31, Clay NY 12041', 'New York'),    
('Rose Huges', '768055634859', '345 East Meighan Blvd, Gadsden AL 359', 'Alaska'),    
('Laura Paul', '948563945327', '301 RT 9W, Glenmont NY 12077', 'New York'),    
('Diego Simmons', '465676423435', '501 Memorial Dr, Chicopee MA 1030', 'California'),    
('Antonio Bennet', '506705670323', '317 Russell St, Hadley MA 1415', 'California'
);

/**
Questions: 
1:Write a query that returns the total number of employees data stored in the employee table.
2: Write a query that calculates the total summed up salary of all employees stored in the employee table
3: Write a query that calculates the average salary of employees stored in the employee table.
4: Write a query that returns the lowest salary of an employee stored in the employee table.
5: Write a query that returns the highest salary of employees stored in the employee table.
**/

select *
from EmployeeJoin

--1:Write a query that returns the total number of employees data stored in the employee table.
select
count(name) as TotalNoOfEmp
from EmployeeJoin

--2: Write a query that calculates the total summed up salary of all employees stored in the employee table
select 
sum(salary) as TotalSalary
from EmployeeJoin

--3: Write a query that calculates the average salary of employees stored in the employee table.
select 
avg(salary) as TotalSalary
from EmployeeJoin

--4: Write a query that returns the lowest salary of an employee stored in the employee table.
select *
from EmployeeJoin
where salary=
(
		select
		min(salary) as TotalSalary
		from EmployeeJoin
)

--another way
select top 1 *
from EmployeeJoin
order by Salary asc



--5: Write a query that returns the highest salary of employees stored in the employee table.
select 
max(salary) as TotalSalary
from EmployeeJoin

select *
from EmployeeJoin
where salary=
(
		select
		max(salary) as TotalSalary
		from EmployeeJoin
)
--another way
select top 1 *
from EmployeeJoin
order by Salary desc

select *
from emp_address as A,EmployeeJoin as B
where A.name=B.name

select *
from emp_address as A
join 
EmployeeJoin as B
on A.name=B.name

select 
A.city,
A.address,
A.cellphone,
B.occupation,
B.salary,
A.name
from emp_address as A
join 
EmployeeJoin as B
on A.name=B.name

--Question:1: calculate the total number of employee and their addresses from two different tables.

select 
count(B.name) as TotalNoOfEmp,
count(A.address) as TotalNoOfAddress
from emp_address as A
join 
EmployeeJoin as B
on A.name=B.name

select * into Prod.dbo.EmployeeJoin
from SQLTraining.dbo.Employeejoin

create database Prod
