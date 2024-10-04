/**
Assignment 3: Create a table named: FoodCo. Load the data, 
1: write a query to show the unique fruitsname. 
2: write a query to show the highest amount. 
3. Write a query to show the lowest amount . Make sure to include in your output result these fields s.no, fruitsname, amount 
4. Write a query to show the fruit that  does not have any amount 
5: Give 2500 for any record that shows missing amount
**/

--Create a table named: FoodCo. Load the data
drop table if exists [FoodCo.]
create table [FoodCo.]
("S.no" int null,
FruitsName varchar (50) not null,
Amount int null)

insert into [FoodCo.]
([S.no], FruitsName, Amount)
values
(1,'Apple',150),
(2,'Banana',75),
(3,'Orange',60),
(4,'Papaya',80),
(5,'Mango',95),
(6,'Apple',150),
(7,'lechi', null)

select *
from [FoodCo.]

--write a query to show the unique fruitsname
select distinct FruitsName
from [FoodCo.]

select [S.no],FruitsName,Amount
from [FoodCo.]
group by [S.no],FruitsName,Amount
Order by FruitsName

--write a query to show the highest amount
select 
max(Amount) as HighestAmount
from [FoodCo.]

select [S.no],FruitsName,Amount,
max(Amount) as HighestAmount
from [FoodCo.]
group by [S.no],FruitsName,Amount
Order by FruitsName

--Write a query to show the lowest amount
select 
min(Amount) as LowestAmount
from [FoodCo.]

select [S.no],FruitsName,Amount,
min(Amount) as lowestAmount
from [FoodCo.]
group by [S.no],FruitsName,Amount
Order by FruitsName

--Write a query to show the fruit that  does not have any amount
select *
from [FoodCo.]
where Amount is null

--Give 2500 for any record that shows missing amount
update [FoodCo.]
set amount = 2500
where amount is null