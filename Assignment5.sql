--change the font for all the records in the movies table to uppercase
--HOW DO WE MODIFY RECORDS WITHOUT MAKING ANOTHER COLUMN?
update Movies
set 
Name = upper(Name),
Type = upper(Type),
Rating  = upper(Rating),
Stars = upper(Stars)

--change the font of the movie type 'drama' to lowercase
--to change to a new field
select *,
lower(Type) as upperdrama
from Movies
where Type = 'DRAMA'

--to change on the actual field
update Movies
set Type = lower(Type)
where Type = 'Drama'

select *
from Movies

--how to specify records with certain strings by placing the string inbetween wildcard(%)  
select *,
upper(substring(Type,1,3)) as TypeCode
from Movies
where Name like '%in%'