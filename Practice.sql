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

--Handling NULLS using case or coalesce
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
;
--creating views
drop view vwRAYstring if exists
create view
vwRAYstring as
select *
from EmployeeJoin
where Name like '%ray%'
;
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
select *
from Noble

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

--Gap Analysis using exists and metrics
select 'DEV' as source, * from employeejoin A
join emp_address B 
on A.name=B.name
where not exists
(select 'Task' as source, * from employeejoin A
join emp_address B 
on A.name=B.name)

select 'Prod' as source, 
sum(salary) TotalSalary
from EmployeeJoin
union
select 'DEV' as source,
sum(salary) TotalSalary
from EmployeeJoin

select A.occupation, A.working_date, A.working_hours,B.cellphone,B.address,B.city,
sum(working_hours*Salary) stipend
from employeejoin A
join emp_address B 
on A.name=B.name
group by A.occupation, A.working_date, A.working_hours,B.cellphone,B.address,B.city

--find Total no. of Hypertensive disorder in DEV and TEST environment.
select 'DEV'source, 
count(DESCRIPTION) TotalHypertensionDisorder 
from dev.dbo.CarePlansData
where  DESCRIPTION like '%hypertension%'
union 
select 'TEST' source, 
count(DESCRIPTION) TotalHypertensionDisorder 
from dev.dbo.CarePlansData
where  DESCRIPTION like '%hypertension%'

--Changed data type using convert
select *,
convert(varchar(10), START, 10) NewStart,
convert(varchar(10), STOP, 10) NewStop
from CarePlansData

alter table careplans
alter column START date 

alter table careplans
alter column STOP date 

--Selected specified information from 2 tables
select *
from ClaimsTransactionData A
join ClaimsData B on A.PATIENTID=B.PATIENTID
where Amount in ('85.55','136.00')
and DIAGNOSISREF3 = 3

--used cte
with Plans as 
(
select A.Id,A.CODE,B.PATIENT,B.ENCOUNTER
from careplans A,ConditionsData B
where A.PATIENT=B.PATIENT
)
select *
from Plans

select *
from ClaimsData A
join ClaimsTransactionData B on A.Id=B.CLAIMID

use Dev
go
;

alter table ClaimsTransactionData
alter column CLAIMID varchar(200) not null 

alter table ClaimsData
alter column ID varchar(200) not null 


 --create table and bulk insert
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
Drop Table if exists HospitalFacilityListing
create table HospitalFacilityListing
(
LICENSED_CERTIFIED varchar(250) null,
FLAG varchar(250) null,
T18_19 varchar(250) null,	
FACID int not null,
FAC_STATUS_TYPE_CODE varchar(250) null,	
ASPEN_FACID varchar(250) null,
CCN varchar(250) null,
TERMINAT_SW varchar(250) null,	
PARTICIPATION_DATE date,	
APPROVAL_DATE date,
NPI varchar(250) null,
CAN_BE_DEEMED_FAC_TYPE varchar(250) null,	
CAN_BE_CERTIFIED_FAC_TYPE varchar(250) null,	
DEEMED varchar(250) null,
AO_CD varchar(250) null,
DMG_EFCTV_DT varchar(250) null,	
AO_TRMNTN_DT varchar(250) null,	
AO_NAME	varchar(250) null,
FACNAME varchar(250) null,	
FAC_TYPE_CODE varchar(250) null,	
FAC_FDR varchar(250) null,
LTC varchar(250) null,
CAPACITY int,	
ADDRESS varchar(250) null,
CITY varchar(250) null,	
ZIP varchar(250) null,	
ZIP9 varchar(250) null,	
FACADMIN varchar(250) null,	
CONTACT_EMAIL varchar(250) null,
CONTACT_FAX varchar(250) null,
CONTACT_PHONE_NUMBER varchar(250) null,	
COUNTY_CODE varchar(250) null,
COUNTY_NAME varchar(250) null,
DISTRICT_NUMBER varchar(250) null,	
DISTRICT_NAME varchar(250) null,
ISFACMAIN varchar(250) null,
PARENT_FACID varchar(250) null,	
FAC_FAC_RELATIONSHIP_TYPE_CODE varchar(250) null,	
START_DATE date,
LICENSE_NUMBER varchar(250) null,	
BUSINESS_NAME varchar(250) null,
LICENSE_STATUS_DESCRIPTION varchar(250) null,	
INITIAL_LICENSE_DATE date,
LICENSE_EFFECTIVE_DATE date,	
LICENSE_EXPIRATION_DATE date,	
ENTITY_TYPE_DESCRIPTION varchar(250) null,
LATITUDE varchar(250) null,
LONGITUDE varchar(250) null,	
LOCATION varchar(250) null,	
HCAI_ID varchar(250) null,
CCLHO_CODE varchar(250) null,	
CCLHO_NAME varchar(250) null,	
FIPS_COUNTY_CODE varchar(250) null,	
BIRTHING_FACILITY_FLAG varchar(250) null,	
TRAUMA_PED_CTR varchar(250) null,	
TRAUMA_CTR varchar(250) null,
TYPE_OF_CARE varchar(250) null,	
CRITICAL_ACCESS_HOSPITAL varchar(250) null,	
DATA_DATE date,
DMG_EFCTV_DATE date
)


 bulk insert HospitalFacilityListing
 from 'C:\Users\John\OneDrive\Documents\ETL Training\Inbound\Hospital Facility Project\health_facility_locations.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)

--Create a query listing out for each continent and country the number of events taking place therein:
use WorldEvent
go
;



select A.ContinentName,B.CountryName,
count(EventID) NumberOfEvents
from tblContinent A
join tblCountry B on A.ContinentID=B.ContinentID
join tblEvent C on C.CountryID=B.CountryID
group by A.ContinentName,B.CountryName
order by B.CountryName Asc

--Now change your query so that it omits events taking place in the continent of Europe:
select A.ContinentName,B.CountryName,
count(EventID) NumberOfEvents
from tblContinent A
join tblCountry B on A.ContinentID=B.ContinentID
join tblEvent C on C.CountryID=B.CountryID
where ContinentName <> 'Europe'
group by A.ContinentName,B.CountryName
order by B.CountryName Asc

--Finally, change your query so that it only shows countries having 5 or more events:
select A.ContinentName,B.CountryName,
count(EventID) NumberOfEvents
from tblContinent A
join tblCountry B on A.ContinentID=B.ContinentID
join tblEvent C on C.CountryID=B.CountryID
where ContinentName <> 'Europe'
group by A.ContinentName,B.CountryName
having count(EventID) > 5
order by B.CountryName Asc

use Music_01
go
;

select *
from Track

--Unfortunately, the track names aren't sorted properly because some have leading spaces and double-quotes. 
--Create a function which will accept the name of a track and return a cleaned version of it by doing the following:
--Use the TRIM function to remove leading and trailing spaces.
--Use the REPLACE function to replace double-quote characters with empty strings.
--Use your new function in the query to show a sorted list of cleaned track names, ALbum_name,Track_mins,Track_secs

select B.Title Album_Name,A.Track_mins,A.Track_secs,
trim(replace(Track_name,'"','')) Clean_Track_Name
from Track A
join Album B on B.Album_ID=A.Album_ID
order by Clean_Track_Name

--Create a new function which you can call in a query as shown below: dbo.fn.Track_time(t.Track_mins, T.Track_secs) as Track_Length
select B.Title Album_Name,A.Track_mins,A.Track_secs,
trim(replace(Track_name,'"','')) Clean_Track_Name,
concat(format(Track_mins, '00'), ':', format(Track_secs, '00')) Track_Length
from Track A
join Album B on B.Album_ID=A.Album_ID
order by Clean_Track_Name

--Write a query using the Venue and Show tables to display the aggregations shown below for each venue: Venue,Count_0f_shows,Sum_tickets_sold,avg_revenue_$

select Venue,
count(show_ID) Count_of_shows,
sum(Tickets_sold) Sum_tickets_sold,
avg(revenue_$) avg_revenue_$
from Venue A
join Show B on B.Venue_ID=A.Venue_ID
group by Venue
order by Count_of_shows desc

--Make another version of the same query which shows the same statistics for different cities.
select City,
count(show_ID) Count_of_shows,
sum(Tickets_sold) Sum_tickets_sold,
avg(revenue_$) avg_revenue_$
from Venue A
join Show B on B.Venue_ID=A.Venue_ID
join City C on C.City_ID=A.City_ID
group by City
order by Count_of_shows desc

--Make another version of the same query which groups the data by Country
select Country,
count(show_ID) Count_of_shows,
sum(Tickets_sold) Sum_tickets_sold,
avg(revenue_$) avg_revenue_$
from Venue A
join Show B on B.Venue_ID=A.Venue_ID
join City C on C.City_ID=A.City_ID
join Country D on D.Country_ID=C.Country_ID
group by Country
order by Count_of_shows desc

--Make another version of the query which groups the data by Continent.
select Continent,
count(show_ID) Count_of_shows,
sum(Tickets_sold) Sum_tickets_sold,
avg(revenue_$) avg_revenue_$
from Venue A
join Show B on B.Venue_ID=A.Venue_ID
join City C on C.City_ID=A.City_ID
join Country D on D.Country_ID=C.Country_ID
join Continent E on E.Continent_ID=D.Continent_ID
group by Continent
order by Count_of_shows desc

--Create a version of the previous query which groups the data by each of the previous group fields
select Continent,Country,City,Venue,
count(show_ID) Count_of_shows,
sum(Tickets_sold) Sum_tickets_sold,
avg(revenue_$) avg_revenue_$
from Venue A
join Show B on B.Venue_ID=A.Venue_ID
join City C on C.City_ID=A.City_ID
join Country D on D.Country_ID=C.Country_ID
join Continent E on E.Continent_ID=D.Continent_ID
group by Continent,Country,City,Venue
order by Count_of_shows desc

--Create a query which shows two statistics for each category initial:
--The number of events for categories beginning with this letter; and
--The average length in characters of the event name for categories beginning with this letter


		
		select EventName,EventDetails,
		count(CategoryName) NumberOfEvents,
		substring(CategoryName, 1,1) as FirstLetter
		from tblCategory A
		join tblEvent B on B.CategoryID=A.CategoryID
		group by EventName,EventDetails

			select distinct count(CategoryName) NumberOfEvents,
			len(EventName) avgEventNameLength,
		substring(CategoryName, 1,1) as CategoryInitial
		from tblCategory A
		join tblEvent B on B.CategoryID=A.CategoryID
		group by CategoryName,EventName
		Order by CategoryInitial asc
		;
--To find only even numbers	
select *
from hranalysis1
where Age % 2 = 0

--To find only odd numbers	
select *
from hranalysis1
where Age % 2 = 1
;

--[Music_01 DB]find the difference between the total number of CITY entries in the table and the 
--number of distinct CITY entries in the table

select 
count(city) - 
count(distinct city) NumberOfDistinctCity
from City
;

select *
from employee

--Querry the 2 EmployeeFirstNames with the longest and shortest length and thier lenght(no of character)

select top 1
len(EmployeeFirstName) lenght,EmployeeFirstName
from Employee
Order by EmployeeFirstName asc


select top 1
len(EmployeeFirstName) lenght,EmployeeFirstName
from Employee
Order by EmployeeFirstName desc


with X as 
(
select *,
len(EmployeeFirstName) lenght
from Employee
--Order by len(EmployeeFirstName) asc
)
select top 1 Lenght,EmployeeFirstName
from X
where exists(
select
max(lenght) max,
min(lenght) min
from X)
Order by Lenght asc


with X as 
(
select 
max(len(EmployeeFirstName)) maxlenght,
min(len(EmployeeFirstName)) minlenght,
from Employee
--Order by len(EmployeeFirstName) asc
)
select Lenght,EmployeeFirstName
from X
where exists(
select
max(lenght) max,
min(lenght) min
from X)


SELECT TOP 1
    LEN(EmployeeFirstName) AS Length,
    EmployeeFirstName
FROM 
    Employee
ORDER BY 
    LEN(EmployeeFirstName) ASC

UNION ALL

SELECT TOP 1
    LEN(EmployeeFirstName) AS Length,
    EmployeeFirstName
FROM 
    Employee
ORDER BY 
    LEN(EmployeeFirstName) DESC;

WITH RankedEmployees AS (
    SELECT 
        EmployeeFirstName,
        LEN(EmployeeFirstName) AS Length,
        ROW_NUMBER() OVER (ORDER BY LEN(EmployeeFirstName) ASC) AS ShortestRank,
        ROW_NUMBER() OVER (ORDER BY LEN(EmployeeFirstName) DESC) AS LongestRank
    FROM 
        Employee
)
SELECT 
    EmployeeFirstName,
    Length
FROM 
    RankedEmployees
WHERE 
    ShortestRank = 1 OR LongestRank = 1
	Order by employeefirstname asc
select top 1
len(EmployeeFirstName) lenght,EmployeeFirstName
from Employee
where len(EmployeeFirstName) =
(select 
max(len(employeeFirstName)) maxlenght
from Employee)
Order by EmployeeFirstName asc


select top 1
len(EmployeeFirstName) lenght,EmployeeFirstName
from Employee
Order by EmployeeFirstName desc

select 
max(len(employeeFirstName)) maxlenght
from Employee

select 
min(len(employeeFirstName)) minlenght
from Employee

select *
from emadeconsulting

select *
from HospitalFacilityListingData

--USING PIVOT: ITS USED TO CONVERT ROWS TO COLUMN
SELECT *
FROM
	(
	SELECT YEAR,SUBJECT,WINNER,
	COUNT(YEAR) YEARS
	FROM NOBLE
	GROUP BY YEAR,SUBJECT,WINNER
	) SOURCETABLE

PIVOT(SUM([YEARS])
FOR YEAR IN ([1960],[1961],[1962],[1963])
	) YEARPIVOT

--MERGE OPERATION

    MERGE INTO EMADETARGETPRODUCTS AS TARGET
    USING EMADESOURCEPRODUCTS AS SOURCE
    ON TARGET.PRODUCTID = SOURCE.PRODUCTID 
    --UPDATE RECORDS IN TARGET
	WHEN MATCHED AND TARGET.PRICE<>SOURCE.PRICE THEN
        UPDATE SET 
            TARGET.IS_ACTIVE='N'
			
  --INSERT OPERATIONS 
   WHEN NOT MATCHED THEN
        INSERT (PRODUCTID,PRODUCTNAME, PRICE, IS_ACTIVE)
        VALUES (SOURCE.PRODUCTID,SOURCE.PRODUCTNAME, SOURCE.PRICE, 'Y');

	INSERT INTO EMADETARGETPRODUCTS (PRODUCTID, PRODUCTNAME, PRICE, IS_ACTIVE)
		SELECT DISTINCT SOURCE.PRODUCTID, SOURCE.PRODUCTNAME, SOURCE.PRICE,'Y'
		FROM EMADESOURCEPRODUCTS AS SOURCE
		LEFT JOIN EMADETARGETPRODUCTS AS TARGET
		ON SOURCE.PRODUCTID = TARGET.PRODUCTID
		WHERE TARGET.IS_ACTIVE = 'N';

