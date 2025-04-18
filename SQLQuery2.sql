--Table valued function

select *
from Noble

drop function if exists fn_NobleByYear;
create or alter function fn_NobleByYear
(@year int,
@subject varchar(50))
Returns Table 
as 
Return
	select year,subject,winner
	from noble
	where year=@year
	and subject=@subject;
	
--How to execute a function
select *
from fn_NobleByYear(1960,'Chemistry')