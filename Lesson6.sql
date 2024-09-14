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

--info for Highest priced product 
select top 1 *
from WalmartData
order by PRICE_CURRENT desc


select *
from WalmartData
		where PRICE_CURRENT = (select
		max(PRICE_CURRENT) as HighestPrice
		from WalmartData)




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

 select *,
 case 
 when BusinessTravel = 'Travel_Frequently' then 'Travel_Frequently'
 when BusinessTravel = 'Travel_Rarely' then 'Travel_Rarely'
 else 'Non_Travel'
 end as TravelFrequency
 from HrAnalysisDataBkup

 select *
 from HrAnalysisDataBkup
 where BusinessTravel = 'Travel_Frequently'

 select *
 from HrAnalysis
 insert into HrAnalysisFreqTra
 
 select *
 into HrAnalysis_RareTrav
 from HrAnalysis

 select distinct *
 from [dbo].[HrAnalysis_FreqTrav]

 select *
 from HrAnalysis_FreqTrav

  select *
 from HrAnalysis_RareTrav


 select distinct *
 into HrAnalysis1
 from HrAnalysis

 select *
 from HrAnalysisNew

 select * 
 into HrAnalysisMedical
 from HrAnalysis1

 select *
 into HrAnalysisTechDegree
 from HrAnalysis1

 select *
 into HrAnalysisLifeSciences
 from HrAnalysis1

 select *
 into HrAnalysisOther
 from HrAnalysis1

 select *
 into HrAnalysisMarketing
 from HrAnalysis1


 select *
 from HrAnalysis1

 select distinct JobRole
 from HrAnalysis1
 
 select *
 into HrAnalysisSalesRep
 from HrAnalysis1

 select *
 into HrAnalysisSalesExe
 from HrAnalysis1

 select *
 into HrAnalysisResearchSci
 from HrAnalysis1

 select *
 into HrAnalysisHR
 from HrAnalysis1

 select *
 into HrAnalysisHealthcareRep
 from HrAnalysis1

 select *
 into HrAnalysisResearchDir
 from HrAnalysis1

 select *
 into HrAnalysisMgr
 from HrAnalysis1

 select *
 into HrAnalysisManufacturingDir
 from HrAnalysis1

 select *
 into HrAnalysisLabTech
 from HrAnalysis1

 select 
 count([Type]) as totalrecord
from Movies
where [Type] = 'drama'

select *
from Movies
where Price > 20
order by Price

select *
from Movies
where Price > 20
order by Qty desc

select Type,Price as [CurrentValue],
sum(Qty*Price*1.15) as 'ReplacementValue'
from Movies
group by Type,Price

select Type,Price as [CurrentValue],
sum(Qty*Price*1.15) as 'ReplacementValue'
from Movies
group by Price,Type

select
count(Rating) as 'NewRating'
from Movies
where Rating <> 'G'

insert into Movies
(No,Name,Type,Rating,Stars,Qty,Price)
values
(12,'I Am A Tiger','Tales By Moonlight','R','Witch',8,80)

 
 select *
 from UniqueEmployeeInfo

 select EmpName
 from UniqueEmployeeInfo

 select *
 from UniqueEmployeeInfo
 where EmpSalary =
		(select
		max(EmpSalary) as HighestSalary
		from UniqueEmployeeInfo)

select top 1 *
from UniqueEmployeeInfo
order by EmpSalary desc