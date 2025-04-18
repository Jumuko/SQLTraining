select * 
from NetflixBusiness

--Convert date_added to date data type
alter table NetflixBusinessData
alter column date_added date

--Rename table
exec sp_rename @objname='NetflixBusinessData', @newname= 'NetflixBusiness'

--Count of TV-Shows
select count(type) as NumberofTVShows
from NetflixBusiness 
where type = 'TV Show'

--Count of Movies
select count(type) as NumberofMovies
from NetflixBusiness 
where type = 'Movie'

--Count of Movies and TV-Shows by year
select distinct release_year,
count(type) as TotalMoviesandShowsReleased
from NetflixBusiness
group by release_year
order by release_year asc


--Count of movies and shows by directors
select distinct director,
count(type) as TotalShowsandMoviesDirected
from NetflixBusiness
group by director 
order by TotalShowsandMoviesDirected desc




