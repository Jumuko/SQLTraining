--how to create database
/**create database SQLTraining
go
;**/

use SQLTraining

--create table named Noble
drop table if exists Noble
create table Noble
(
"year" int not null,
"subject" varchar (50) null,
winner varchar (50) null
)

--insert values to the Nobles table
insert into Noble
(
"year",
"subject",
winner
)

values
(1960, 'Chemistry', 'Willard F. Libby'),
(1961, 'Literature', 'Saint-John Perse'),
(1962, 'Medicine', 'Sir Frank Macfariane Burnet'),
(1963, 'Medicine', 'Peter Madawar')

insert into Noble
values 
(1964, 'Biology','John-Umukoro')

-- show the year 1962
select *
from Noble
where "year" = 1962

create view vwNoble 


select *
from Noble
where "year" <> 1962

select *
from Noble
where "year" not in (1962)
 
 -- show the subject Medicine
 select *
from Noble
where "subject" = 'Medicine'

-- show the latest year in the Noble table
select *
from Noble
where year = (select max(year) from Noble)

--add the next noble winner in the year 2024, the subject should be Economy
insert into Noble
(
"year",
"subject",
winner
)

values
(2024, 'Economy', 'Russell Crow')

select *
from Noble

--create a view and name it vwOldNoble and should only include records showing before year 1962
drop view if exists vwOldNoble
;
create view vwOldNoble as 
select *
from Noble
where year < 1962 

drop procedure if exists spNoble
create procedure spNoble 
@year int , @subject varchar(50) as
begin
select *
from Noble
where @year=year
and @subject=subject
end

exec spNoble @year=1960,@subject='chemistry'

;
select *
from vwOldNoble

--number of records in the Noble table
select count(*) as NumberOfRecords
from Noble

--results excluding Medine
select *
from Noble
where "subject" != 'Medicine'
;

--create table named Games
drop table if exists Games
create table Games
(
year int not null,
City varchar (50) null
)
 --insert values to the Games table
insert into Games
(
year,
City
)

values
(2000, 'Sydney'),
(2004, 'Athens'),
(2008, 'Beijing'),
(2012, 'London')

--display the Games table
select *
from Games

--show the year 2004
select *
from Games
where year = 2004

--show the city of london
select *
from Games
where City = 'London'

--show the latest year in the games table
select *
from Games
 where year = (select max(year) from Games)

 --add the next olympic games in the year 2024, which will be held in the city of Paris
 insert into Games
(
year,
City
)

values
(2024, 'Paris')

--create a view named vwOldGames to only include records showing year before 2008
drop view if exists vwOldGames
create view vwOldGames as
select *
from Games 
where year < 2008

--view vwOldGames
select *
from vwOldGames

--show the number of records in the Games table
select count(*) as NumberOfRecords
from Games

--show result to exclude London and Athens
select *
from Games
where City != 'London'
and City != 'Athens'

select *
from Games
where City not in ('London', 'Athens')

;

drop table if exists World 
--create table named World
create table World
(
CountryName varchar (50) null,
Continent varchar (50) null,
Area int  not null,
"Population" int not null,
Gdp bigint not null
)

--insert values to the Worlds table
insert into World
(
CountryName,
Continent,
Area,
"Population",
Gdp
)

values
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000)

--display the Worlds table
select *
from World

--show the area of 468
select *
from World
where Area = 468

--show the county name of Angola
select *
from World
where CountryName = 'Angola'

--show the country with the lowest Gdp 
use SQLTraining
select *
from World
where Gdp = (select min(Gdp) from World)

--create a view named vwlowGdpCountries to only include record with the lowest GDP
drop view if exists vwlowGdpCountries
create view vwlowGdpCountries as
select *
from World
where Gdp = (select min(Gdp) from World)

--view vwlowGdpCountries
select *
from vwlowGdpCountries

--show the number of records in the world table
select count(*) as NumberOfRecords
from World