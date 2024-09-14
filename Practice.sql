/** 
Where i practice my skills
**/
select *
from Employees

--CASE
select 
  case 
  when Country = 'USA' then 'NorthAmerica'
  when Country = 'India' then 'Asia'
  else 'Europe'
  end as Continent
  from Employees

  --ALTER (add column to table) and UPDATE(add values using case statement)
  alter table Employees
  add Continent varchar(50) null
  ;

  update Employees
  set Continent =
		
		  case 
		  when Country = 'USA' then 'NorthAmerica'
		  when Country = 'India' then 'Asia'
		  else 'Europe'
		  end

Alter table Employees
add Position varchar(50) 

select case
when Salary > 5000 then 'Senior Engineer'
when Salary > 4000 then 'Junior Engineer'
else 'Intern'
end as Position
from Employees

update Employees
set Position = 
case
when Salary > 5000 then 'Senior Engineer'
when Salary > 4000 then 'Junior Engineer'
else 'Intern'
end
from Employees

drop table if exists EmpWorkInfo
create table EmpWorkInfo
(id int not null, Name varchar(50), Position varchar(50) null, SocialSecurity int not null, DistanceFromHome varchar(50), Department varchar(50)) 

insert into EmpWorkInfo
(id,Name,Position,SocialSecurity,DistanceFromHome,Department)
 values
(1,'Usama','Junior Engineer',222222222,20,'Marketing'),
(2,'Safwan','Junior Engineer',333333333,8,'Finance'),
(3,'Gulraiz','Senior Engineer',444444444,15,'Finance'),
(4,'Ayesha','Intern',888888888,32,'Technical'),
(5,'Anas','Intern',987654321,25,'Marketing'),
(6,'Areeha','Junior Engineer',444444444,6,'Finance'),
(7,'Raza', 'Senior Engineer',123456789,23,'Technical'),
(8,'Eeman','Senior Engineer',080808080,53,'Technical'),
(9,'Faseeh', 'Senior Engineer',343434343,36,'Finance'),
(10,'Hassan','Junior Engineer',565665656,20,'Marketing')

--Bring tables together using where or join
select distinct *
from EmpWorkInfo A,Employees B
where
A.Position=b.Position

select * 
from EmpWorkInfo A
join Employees B 
on A.Position=B.Position

--Ways to get highest Salary
select top 1 * 
from EmpWorkInfo A
join Employees B 
on A.Name=B.Name
order by Salary desc

select top 1 *
from EmpWorkInfo A, Employees B
where A.Name=B.Name
Order by Salary desc

select *,
max(Salary) MaxSalary
from Employees


--Viewing or Making changes using substrings,upper,left,right,lenght,%
select * ,
upper(substring(Name,1,3)) NameAbbr
from Employees

select *, 
upper(Name) UppercaseName, left(Name,2) ID
from EmployeeJoin

select *
from EmployeeJoin
where Name like '%ray%'

select *
from Employees

--Applying transactions with rollback or commit to maintain data integrity
begin tran
update Employees
set Name = lower(Name)
rollback

--combining querries
Select *
from Emadeconsultingemployee
union
select *
from EmployeeJoin

Select *
from Emadeconsultingemployee
union all
select *
from EmployeeJoin

--how to apply intercept
select * 
from Noble
intersect
select *
from NobleBkup

--how to apply except
select * 
from Noble
except
select *
from NobleBkup

--Handling NULLS using case or coarlese
select *,
case when Subcategory is Null then 0
end NewSub
from WalmartData

update WalmartData
set Subcategory = 'N/A'

begin tran
update WalmartData
set promotion='N/A'
rollback

select *
from WalmartData

select [index], [SHIPPING_LOCATION], [DEPARTMENT], [CATEGORY], coalesce(SUBCATEGORY, 'N/A') NewSub, [BREADCRUMBS], [SKU], [PRODUCT_URL], [PRODUCT_NAME], [BRAND], [PRICE_RETAIL], [PRICE_CURRENT], [PRODUCT_SIZE], [PROMOTION], [RunDate], [tid]
from WalmartData

--creating views

create view
vwRAYstring as
select *
from EmployeeJoin
where Name like '%ray%'

drop view if exists vw;
create view
vw as
select *,
case 
when working_hours <=10 then 'great!'
when working_hours <=12 then 'Excellent!'
else 'Spectacular!'
end Evaluation
from EmployeeJoin

select *
from vw

--creating backups, local temporary table, global temporary table, common table expression
select *
into #EmployeeJoinBkup
from EmployeeJoin

select *
into ##EmployeeJoinBkup
from EmployeeJoin

with HRData as 
(
		select * 
		from HrAnalysis1
)
select * from HRData

/*how to handle duplicates*/

--how to eliminate duplicates
select distinct * 
from Noble
order by YEAR desc

--another way to eliminate duplicates
select year, subject, winner 
from Noble
group by year, subject, winner
order by YEAR desc

--how to identify duplicates
select year, subject, winner,
DuplicateRecords = count (*) 
from Noble
group by year, subject, winner
order by YEAR desc

--how to identify only duplicates
select year, subject, winner,
DuplicateRecords = count (*) 
from Noble
group by year, subject, winner
having count (1) > 1
order by YEAR desc

select *
from EmployeeJoin

--replace records
update employeejoin
set occupation = Replace(occupation, 'Writer', 'Dancer')
where working_hours = 13

--using subquerries
select *
 from UniqueEmployeeInfo
 where EmpSalary =
		(select
		max(EmpSalary) as HighestSalary
		from UniqueEmployeeInfo)
--exist
select *
from HrAnalysis1 as A
where not exists (select *
from HrAnalysisMale as B
where A.Age=B.Age)

select*from employeejoin

select*from emp_address

select * from employeejoin A
join emp_address B 
on A.name=B.name

select A.occupation, A.working_date, A.working_hours,B.cellphone,B.address,B.city,
sum(working_hours*Salary) stipend
from employeejoin A
join emp_address B 
on A.name=B.name
group by A.occupation, A.working_date, A.working_hours,B.cellphone,B.address,B.city