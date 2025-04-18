/**Create a table named: UniqueEmployeeInfo. Load the data, 
1: write a query to show the unique empname. 
2: write a query to show the highest empsalary. 
3. Write a query to show the lowest empsalary. 
Make sure to include in your output result these fields empid, empname, empsalary**/


--Create a table named: UniqueEmployeeInfo. Load the data
drop table if exists UniqueEmployeeInfo
create table UniqueEmployeeInfo
(empID int null, EmpName varchar (50) not null, EmpSalary int null)

insert into UniqueEmployeeInfo
(empID,EmpName,EmpSalary)
values
(16000,'Rohatash',1),
(5000,'Loren',2),
(2000,'Meths',3),
(12000,'Rahul',4),
(13000,'Smith',5),
(9000,'Meths',6),
(20000,'Rahul',7)

select *
from UniqueEmployeeInfo

select *
from UniqueEmployeeInfo

--write a query to show the unique empname
select distinct EmpName
from UniqueEmployeeInfo
group by EmpName

select * into BkupUniqueEmployeeInfo
from UniqueEmployeeInfo


select distinct EmpName,EmpID,EmpSalary
from BkupUniqueEmployeeInfo
Order by EmpName,EmpID,EmpSalary

select distinct *
from BkupUniqueEmployeeInfo
Order by EmpName,EmpID,EmpSalary


select EmpName,EmpID,EmpSalary
from BkupUniqueEmployeeInfo
group by EmpName,EmpID,EmpSalary
Order by EmpName,EmpID,EmpSalary

select EmpName,EmpID,EmpSalary
from BkupUniqueEmployeeInfo
union
select EmpName,EmpID,EmpSalary
from UniqueEmployeeInfo

select EmpName,EmpID,EmpSalary
from BkupUniqueEmployeeInfo
union all
select EmpName,EmpID,EmpSalary
from UniqueEmployeeInfo

--how to create a backup of a table
drop table if exists ResultBkup
select * into ResultBkup
from [Results 1]


select * into BkupUniqueEmployeeInfo
from UniqueEmployeeInfo

select *
from BkupUniqueEmployeeInfo
order by EmpSalary

update BkupUniqueEmployeeInfo
set empID = 2000, EmpSalary = 4
where EmpName = 'Rahul'


--write a query to show the highest empsalary
select EmpID,EmpName,EmpSalary
from UniqueEmployeeInfo
where EmpSalary = (select
max(EmpSalary) as LowestEmpSalary
from UniqueEmployeeInfo)

select 
max(EmpSalary) as HighestEmpSalary
from UniqueEmployeeInfo

--Write a query to show the lowest empsalary.
select EmpID,EmpName,EmpSalary
from UniqueEmployeeInfo
where EmpSalary = (select
min(EmpSalary) as LowestEmpSalary
from UniqueEmployeeInfo)


select
min(EmpSalary) as LowestEmpSalary
from UniqueEmployeeInfo

