/** create database SQLTrainingCase
**/

use SQLTrainingCase

drop table if exists Business
--Create table Business
create table Business
(
ID int not null,
[NAME] varchar (50) null,
AGE int not null,
[ADDRESS] varchar (50) null,
SALARY int not null
)

--Load data
insert into Business
(
ID,
[NAME],
AGE,
[ADDRESS],
SALARY
)

values
(1, 'Ramesh', 32, 'Ahmedabad', 2000),
(2, 'Khilan', 25, 'Delhi', 1500),
(3, 'Kaushik', 23, 'Kota', 2000),
(4, 'Chaitali', 25, 'Mumbai', 6500),
(5, 'Hardik', 27, 'Bhopal', 8500),
(6, 'Komal', 22, 'MP', 4500),
(7, 'Muffy', 24, 'Indore', 10000)

 --display business table
select *
from Business

/** if customer age > or = 25 then Senior Developer
if customer age < 25 then Intern
if customer age > and = 25 but also < and = 27 then Associate Engineer
Name field as JobPosition
**/

select 
AGE,
ID,
[NAME],
[ADDRESS],
SALARY,
case when AGE > 25 then 'Senior Developer'
--when (AGE >= 25) and (AGE < 27) then 'Associate Engineer'
when (AGE = 25) then 'Associate Engineer'
when AGE < 25 then 'Intern'
end as JobPosition
--save case as new table
into BusinessCaseJobPosition
from Business

select 
AGE,
ID,
[NAME],
[ADDRESS],
SALARY,
case when AGE > 25 then 'Senior Developer'
when AGE < 25 then 'Intern'
when AGE > = 25 and AGE < = 27 then 'Associate Engineer'
end as JobPosition
from Business



/** 
If customer age is more than 30 then Gen X
If customer age is 23,24,25 then Gen Z
If customer age is 22 then Gen Alpha
If customer age is 27 then Gen Y
name field as Generation
**/

select 
AGE,
ID,
[NAME],
[ADDRESS],
SALARY,
case 
when AGE > 30 then 'Gen X'
when AGE between 23 and 25 then 'Gen Z'
when AGE = 22 then 'Gen Alpha'
when AGE = 27 then 'Gen Y'
end as Generation
--save case as new table
into BusinessCaseGeneration
from Business

select *
from BusinessCaseGeneration