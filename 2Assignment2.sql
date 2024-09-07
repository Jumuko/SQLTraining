use SQLTrainingCase

--create table named CompanyInfo
drop table if exists CompanyInfo 
create table CompanyInfo
(
FIRST_NAME varchar (50) not null,
LAST_NAME varchar (50) not null,
COUNTRY varchar (50) not null
)

select *
from CompanyInfo

--load data
insert into CompanyInfo
(
FIRST_NAME,
LAST_NAME,
COUNTRY
)
values
('Adam', 'Cooper', 'USA'),
('John', 'Smith', 'USA'),
('Mark', 'Allan', 'UK'),
('Sally', 'Jones', 'USA'),
('Steve', 'Brown', 'Canada')

select *
from CompanyInfo

/** If country is Canada and USA then North America
if country is UK then Europe **/

select 
FIRST_NAME,
LAST_NAME,
COUNTRY,
case 
when COUNTRY = 'USA' then 'North America'
when COUNTRY = 'Canada' then 'North America'
else 'Europe'
end as Continent
into CompanyinfoCaseContinent
from CompanyInfo

--another way
select *,
case 
when COUNTRY = 'USA' then 'North America'
when COUNTRY = 'Canada' then 'North America'
else 'Europe'
end as Continent
from CompanyInfo

select *,
case 
when COUNTRY in ('USA', 'Canada') then 'North America'
else 'Europe'
end as Continent
from CompanyInfo

select *,
case 
when COUNTRY not in ('USA', 'Canada') then 'Europe'
else 'North America'
end as Continent
from CompanyInfo



drop table if exists EmployeeInfo
create table EmployeeInfo
(
FIRST_NAME varchar (50) not null,
LAST_NAME varchar (50) not null,
EMPLOYEES int null
)

select *
from EmployeeInfo

--load data
insert into EmployeeInfo
(
FIRST_NAME,
LAST_NAME,
EMPLOYEES
)
values
('Adam', 'Cooper', 55),
('John', 'Smith', 4),
('Mark', 'Allan', 23),
('Sally', 'Jones', 10),
('Steve', 'Brown', 15),
('Michael', 'James', 1)

/** 
If employees are not more than 1 show SizeOfCompany as No Employees
If employees are not more than 10 show SizeOfCompany as Small
If employees are not more than 50 or equal to 50 show SizeOfCompany as Medium
If employees are more than 50 show SizeOfCompany as Large
save as SizeOfEmployees **/

select *,
case 
when Employees < 2 then 'No Employees'
when Employees between 2 and 10 then 'Small'
when Employees between 11 and 50 then 'Medium'
else 'Large'
end as SizeOfCompany
into EmmployeeInfoCaseSizeOfCompany
from EmployeeInfo

select *,
case 
when Employees > 50 then 'Large'
when Employees in (15,23) then 'Medium'
when Employees >= 2 and Employees <= 10 then 'Small'
else 'No Employees'
end as SizeOfCompany
from EmployeeInfo