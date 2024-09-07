--how to create database
create database CompanyInfo
go

--how to use the correct database
use CompanyInfo

--how to create a table
create table Employee
(
EmployeeID int not null,
EmployeeFirstName varchar (50) null,
EmployeeLastName varchar (50) null,
EmployeeGender varchar(50) null,
EmployeeCountry varchar(50) null
)
;


--how to load data into a table
insert into Employee
(EmployeeID,
EmployeeFirstName,
EmployeeLastName,
EmployeeGender,
EmployeeCountry
)
values
(1, 'Israel', 'James', 'M', 'USA'),
(2, 'Iseac', 'Samuel', 'M', 'USA'),
(3, 'Juliet', 'Anderson', 'F', 'USA'),
(4, 'Emeka', 'Junior', 'M', 'USA'),
(5, 'Cynthia', 'Rothrock', 'F', 'USA')

--how to check data in a table
select *
from Employee


--how to find number of records in a table
select count(*) as TotalRecords
from Employee

--how to reveal male employees
select * 
from Employee
where EmployeeGender = 'M'

--how to reveal female employees
select *
from Employee
where EmployeeGender = 'F'

--how to reveal lastname Sam
select *
from Employee
where EmployeeLastName = 'Samuel'
;
--how to create a view
create view vwEmployeeSamuel as 
select *
from Employee
where EmployeeLastName = 'Samuel'

--how to check data in a view or how to run a view
select *
from vwEmployeeSamuel

--how to modify records in a table
update Employee
set EmployeeCountry = 'Nigeria'
where EmployeeFirstName = 'Emeka'

update Employee
set EmployeeCountry = 'India'
where EmployeeID = '2'

update Employee
set EmployeeCountry = 'Japan'
where EmployeeID = '3'

update Employee
set EmployeeCountry = 'Kuwait'
where EmployeeID = '5'

update Employee
set EmployeeCountry = 'France'
where EmployeeID = '1'

select *
from Employee