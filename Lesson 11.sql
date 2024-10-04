drop table if exists MedalOfHonor

create table dbo.MedalOfHonor (
Id int identity (1,1) primary key,
MilRank varchar (50),
SoldierName varchar (50),
YearOfAction varchar(4)
)
insert into dbo.MedalOfHonor (MilRank, SoldierName, YearOfAction)
values
('Staff Sergeant','Ty Carter', '2009'),
('Captain', 'Florent Groberg', '2012'), 
('Major', 'William D. Swenson', '2009'), 
('Corporal', 'Frank L. Anders', '1899'), 
('First Lieutenant', 'George C. Shaw', '1903')

--Questions--
/**
Assign a pay grade as follows 
if the Mil Rank is a Sergent,show as Level 6,
if the Mil Rank is a Captain,show as Level 3,
if the Mil Rank is a Major,show as Level 4,
if the Mil Rank is a Corporal,show as Level 2,
if the Mil Rank is a Lueitenant,show as Level 1,
Make sure to show no rank for non of the conditions Above
Show a new column as Grade Scale
**/

select *,
case
when MilRank = 'Staff Sergeant' then 'Level 6'
when MilRank = 'Captain' then 'Level 3'
when MilRank = 'Major' then 'Level 4'
when MilRank = 'Corporal' then 'Level 2'
when MilRank = 'First Lieutenant' then 'Level 1'
else 'No Rank'
end as 'Grade Scale'
from MedalOfHonor

--show the highest year of action 
-- The lowest year of action

select *
from MedalOfHonor
where YearOfAction =
(select 
max(YearOfAction) 'HighestYearofAction'
from MedalOfHonor)

select top 1*
from MedalOfHonor
order by YearOfAction desc


select *
from MedalOfHonor
where YearOfAction =
(select
min(YearOfAction) 'LowestYearofAction'
from MedalOfHonor)



--Total No of Records
select
count(*) TotalNoOfRecords
from MedalOfHonor

DROP TABLE IF EXISTS AfricaTemperature;

CREATE TABLE AfricaTemperature
(
    [RecordedDate] DATE NOT NULL,
    [DegreeInFahrenheit] DECIMAL(4, 2) NULL
);

INSERT INTO AfricaTemperature
(
    [RecordedDate],
    [DegreeInFahrenheit]
)
VALUES
('01-01-2023', '32.60'),
('01-02-2023', '31.20'),
('01-03-2023', '42.00'),
('01-04-2023', '44.60'),
('01-05-2023', '39.40'),
('01-06-2023', '31.70'),
('01-07-2023', NULL),
('01-08-2023', '21.20'),
('01-09-2023', '19.15'),
('01-10-2023', '07.90');


/**
Business requirements:

DegreeInFahrenheit is more than 40.00' , show as Hot
If DegreeInFahrenheit is below 32:00, show as 'It''s too cold outside!'
 If DegreeInFahrenheit is not available, show as  'Why didn''t you record this?'
  Otherwise, shows as Sounds about right'
   Show the result in a new column Weather

   **/

 
 select *,
   case
   when DegreeInFahrenheit > 40.00 then 'Hot'
   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
   else 'Sounds about right'
   end Weather
   from AfricaTemperature

  -- Produce a report to show the unique weather count

  select Weather,
  count(*) WeatherCount
  from 
  (
		  select *,
		  case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end as Weather
		   from AfricaTemperature
   ) X
   group by Weather

   --Another Approach
   
		  select 
		  Weather = case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end,
		   WeatherCount = Count(case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end)
		   from AfricaTemperature
		   group by case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end 

		   --Assignment: Load the Africantempdata to PowerBI and show the Weather

