-- Gap Analysis using union,intersect,except
select  EmployeeID,EmployeeFirstName,EmployeeLastName,EmployeeGender,EmployeeCountry, 'dev'as source
from dev.dbo.Employee
union all
select  EmployeeID,EmployeeFirstName,EmployeeLastName,EmployeeGender,EmployeeCountry,'test'as source
from test.dbo.Employee
;

--Gap analysis using metrics (count,avg,sum..etc)
select  'dev'as source,
count(EmployeeFirstName) as EmpCount
from dev.dbo.Employee
union
select 'test'as source,
count(EmployeeFirstName) as EmpCount
from test.dbo.Employee
;

--pull a portion of a table into a new table
use dev
drop table if exists EmployeeBackup 
select *
into EmployeeBackup
from Employee
where EmployeeID in (1,2,3)

select *
from EmployeeBackup

--The requirement is to show records that are missing in the employeebackup table.
select *
from Employee A
where not exists
(select *
from EmployeeBackup B
where A.EmployeeID=B.EmployeeID
)

--Another method to find non matching
select *
from Employee A
where EmployeeID not in 
(select EmployeeID
from EmployeeBackup B
where A.EmployeeID=B.EmployeeID
)

--The requirement is to show records that are matching in the employeebackup table.
select *
from Employee A
where exists 
(select 1
from EmployeeBackup B
where A.EmployeeID=B.EmployeeID
)
--Another nethod to find matching
select *
from Employee A
where EmployeeCountry in
(select EmployeeCountry
from EmployeeBackup B
where A.EmployeeID=B.EmployeeID
)

--BULK INSERT PROCESS TO LOAD DATA
--loading care plan csv file into dev
drop table if exists stg_careplans
--create table to insert data 
create table stg_CarePlans
(
Id varchar (200) null, 
[START] varchar (100)null, 
[STOP] Varchar (100)null, 
PATIENT varchar (200) null,
ENCOUNTER varchar (200) null,
CODE varchar (200) null,
[DESCRIPTION] varchar (200) null, 
REASONCODE varchar (200) null,
REASONDESCRIPTION varchar(500) null
)
 --bulk insert
 bulk insert stg_CarePlans
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Patient Project\careplans.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

select
count(Patient)
from CarePlans
Where Start between '2018-01-01' and '2020-12-31'

select *
from CarePlansData

select*
from claimsdata



