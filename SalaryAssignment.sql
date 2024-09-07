/**
What is a Primary Key: Unique non-nullible identifier for each record in a table. 
It can either be one column or a combination of columns, but each table can only have one primary key.
**/

drop Table if exists Employees
Create Table Employees  
(  
Id int primary key identity(1, 1),  
Name varchar(50), 
Gender varchar(10),  
Salary int,  
Country varchar(10)  
)  

Insert Into Employees Values ('Usama', 'Male', 5000, 'USA')  
Insert Into Employees Values ('Safwan', 'Male', 4500, 'India')  
Insert Into Employees Values ('Gulraiz', 'Female', 5500, 'USA')  
Insert Into Employees Values ('Ayesha', 'Female', 4000, 'India')  
Insert Into Employees Values ('Anas', 'Male', 3500, 'India')  
Insert Into Employees Values ('Areeha', 'Female', 5000, 'UK')  
Insert Into Employees Values ('Raza', 'Male', 6500, 'UK')  
Insert Into Employees Values ('Eeman', 'Female', 7000, 'USA')  
Insert Into Employees Values ('Faseeh', 'Male', 5500, 'UK')  
Insert Into Employees Values ('Hassan', 'Male', 5000, 'USA')

/**
1: show the total salaries of individual countries
2: show the total salaries by gender
3: show the highest salaries 
4: show the total number of records in the table 
5: show the lowest salary in the table 
6: show the average salary in the table
**/

select *
from Employees

--show the total salaries of individual countries
select Country,
count(*) as CountryI,
sum (Salary) as  TotalSalary
from Employees
Group by Country