-- Data Migration
--UAT


drop table if exists prod.dbo.AllergiesData
select * into prod.dbo.AllergiesData
from dev.dbo.AllergiesData
where category='food'

SELECT *
FROM DEV.dbo.AllergiesData

select * 
from prod.dbo.AllergiesData

--TestCase001:Show total number of records
select 
count(*) TotalRecords
from prod.dbo.AllergiesData

--TestCase002:Validate the category='food' is present
select *,
case when CATEGORY='food' then 'Found'
else 'Missing'
end as Expected
from prod.dbo.AllergiesData

--TestCase003:Validate that other categories are not present
select *,
case when CATEGORY <>'water' then 'Missing'
else 'Found'
end as Expected
from prod.dbo.AllergiesData

--TestCase004:Validate count
select
count(*) Total, 'Prod' as source,
case when CATEGORY <>'environment' then 'Missing'
else 'Found'
end as Expected
from prod.dbo.AllergiesData
group by CATEGORY
UNION ALL
select
count(*) Total, 'Dev' as source,
case when CATEGORY <>'environment' then 'Missing'
else 'Found'
end as Expected
from DEV.dbo.AllergiesData
where Description is null
group by CATEGORY