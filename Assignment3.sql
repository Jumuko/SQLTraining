--create database FinalExam
--how to create a stored procedure
create procedure spFinalExam as 


--use FinalExam
begin
drop table if exists [Results 1]
create table [Results 1]
(
ID int not null,
NAME varchar (50) null,
SCORE int not null
)

insert into [Results 1]
(
ID,
NAME,
SCORE
)
values
(1, 'Simisola', 60),
(2, 'Ivan', 80),
(3, 'Metodija', 52),
(4, 'Callum', 98),
(5, 'Leia', 84),
(6, 'Aparecida', 82),
(7, 'Ursula', 69),
(8, 'Ramazan', 78),
(9, 'Corona', 87),
(10, 'Alise', 57),
(11, 'Galadriel', 89),
(12, 'Merel', 99),
(13, 'Cherice', 55),
(14, 'Nithya', 81),
(15, 'Elsad', 71),
(16, 'Liisi', 90),
(17, 'Johanna', 90),
(18, 'Anfisa', 90),
(19, 'Ryosuke', 97),
(20, 'Sakchai', 61),
(21, 'Elbert', 63),
(22, 'Katelyn', 51)

/** When score is 94 or higher, the row will have the value of A. 
If  score is  94 gets an  A, If  score is  90 gets an  A- ,
If  score is  87 gets an  B+  ,If  score is  83 gets an  B  ,
If  score is  80 gets an  B- ,If  score is  77 gets an  C+ ,
If  score is  73 gets an  C , If  score is  70 gets an  C- ,
If  score is  67 gets an  D+ ,If  score is  60 gets an  D,
If students get none of these scores, you should assign an F.
Give each student a grade, which we will add in a new column named grade. 
You can show the grades from highest to lowest
**/

select *,
case
when SCORE >= 94 then 'A'
when SCORE >=90 then 'A-'
when SCORE >=87 then 'B+'
when SCORE >=83 then 'B'
when SCORE >=80 then 'B-'
when SCORE >=77 then 'C+'
when SCORE >= 73 then 'C'
when SCORE >= 70 then 'C-'
when SCORE >= 67 then 'D+'
when SCORE >=60 then 'D'
else 'F'
end as GRADE
into ResultCaseGrade
from [Results_1]

select *,
case
when SCORE >= 94 then 'A'
when SCORE >=90 then 'A-'
when SCORE >=87 then 'B+'
when SCORE >=83 then 'B'
when SCORE >=80 then 'B-'
when SCORE >=77 then 'C+'
when SCORE >= 73 then 'C'
when SCORE >= 70 then 'C-'
when SCORE >= 67 then 'D+'
when SCORE >=60 then 'D'
else 'F'
end as GRADE
from [Results 1]
--Order by SCORE desc
end
go

--how to run a stored procedure
exec spFinalExam


/**Do analysis on the above data to show how many students passed or failed. 
If a student scores 60 or higher, that student passed but if they scored lower than 60, they have failed**/


select *,
case
when SCORE >= 60 then 'Passed'
when SCORE < 60 then 'Failed'
end as Result
into ResultCaseResult
from Results_1

create view vwResult as
select Result
from ResultCaseResult

select *
from ResultCaseResult



select Result,
Number_OF_Students = count(*)
from ResultCaseResult
group by Result