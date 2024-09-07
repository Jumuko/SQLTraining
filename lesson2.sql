select *
from Games

--data flow (case statement)
/**
if the year is 2000 show as good
if the year is 2004, 2008 show as better 
if the year is below 2024 and above 2008 show as best
anything else show as perfect.
show result in a new column and name it year status
**/

select 
YEAR, 
City,
case when YEAR = 2000 then 'Good'
when YEAR in (2004, 2008) then 'Better'
when YEAR < 2024 and YEAR > 2008 then 'Best'
when YEAR not in (2000, 2004, 2008) and (year < 2024 and year > 2008) then 'Perfect'
end as YearStatus
from Games

select 
YEAR, 
City,
case when YEAR = 2000 then 'Good'
when YEAR in (2004, 2008) then 'Better'
when YEAR < 2024 and YEAR > 2008 then 'Best'
when YEAR not in (2000, 2004, 2008) then 'Perfect'
end as YearStatus
from Games

select 
YEAR, 
City,
case when YEAR = 2000 then 'Good'
when YEAR between 2004 and 2008 then 'Better'
when YEAR < 2024 and YEAR > 2008 then 'Best'
else 'Perfect'
end as YearStatus
from Games
 