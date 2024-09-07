--ETL Training
use SQLTraining
go

select *
from [dbo].[WalmartData]

select distinct Department
from WalmartData

--Business Requirement: Produce report for each department in the WalmartData
select *
from [dbo].[WalmartData]

select
avg(DistanceFromHome)
from [dbo].[HrAnalysisData]

alter table HrAnalysisData
alter column [DistanceFromHome] int not null




select *
from [dbo].[HrAnalysisData]

Select distinct *
from HrAnalysisData
where Gender = 'Male'

Select *
from HrAnalysisData
where Gender = 'Female'

Select *
from HrAnalysisData
where EducationField = 'Medical'

Select *
from HrAnalysisData
where EducationField = 'Technical Degree'

Select distinct EducationField
from HrAnalysisData

select *
from dbo.HrAnalysisData
where DistanceFromHome >= 19
order by DistanceFromHome desc

alter table HrAnalysisData
alter column ["age] int not null


select *,
SUBSTRING(Age,2,2) as NewAge,
substring([YearsWithCurrManager"],1,1) as YearsWithManager
into HrAnalysis
from HrAnalysisData




UPDATE HrAnalysis
SET [Age] = REPLACE([Age], '"', '')

Alter table HrAnalysis
drop column NewAge, [YearsWithManager]

--exec sp_rename [YearsWithCurrManager"], [YearsWithCurrManager]

alter table HrAnalysis
alter column Age int not null 

alter table HrAnalysis
alter column [DailyRate] int not null

alter table HrAnalysis
alter column [YearsWithCurrManager] int not null

select *
from HrAnalysisDataBkup

select * from Employees
union 
select* from EmployeesBkup

select * 
into EmployeesBkup
from Employees

exec spHrAnalysis


select * 
into HrAnalysisNew
from [dbo].[HrAnalysisDataBkup]



truncate table HrAnalysisNew

select  
avg(Age) as AVGAGE 
from HrAnalysisNew

select  
avg(cast(Age as int)) as AVGAGE 
from HrAnalysisNew

alter table [dbo].[HrAnalysisNew]
alter column Age varchar (50)

select *
from [dbo].[HrAnalysisDataBkup]

 select * 
 from [dbo].[HrAnalysisNew]

 select *
 from HrAnalysisMale

  select *
 from HrAnalysisFemale


  select *
 into HrAnalysisFemale
 from HrAnalysisNew

 select 
 case 
 when BusinessTravel = 'Travel_Frequently' then 'Travel_Frequently'
 when BusinessTravel = 'Travel_Rarely' then 'Travel_Rarely'
 else 'Non_Travel'
 from HrAnalysisDataBkup

 select *
 from HrAnalysisDataBkup
 where BusinessTravel = 'Travel_Frequently'
