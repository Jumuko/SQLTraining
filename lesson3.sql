use SQLTraining
go 

-- =============================================
-- Author:		John 
-- Create date: 08/22/2024
-- Description:	This stored procedure was created to generate final exam results
--Version: v1.0
-- =============================================
CREATE PROCEDURE spNoble
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from Noble
END
GO

exec spNoble


exec spFinalExam
/**
DDL-Data Definition Language(Create,Truncate,Alter,Drop)
DML-Data Manipulation Language(Update, Delete, Insert)
TCL-Transaction Control Language(Commit, Rollback)
DQL-Data Querry Language(Select)
DCL-Data Control Language(grant,revoke)

**/

select *
from [Results 1]
where NAME = 'Ivan'

--how to delete record from a table
begin tran
delete 
from [Results 1]
where NAME = 'Ivan'
rollback

begin tran
delete 
from [Results 1]
where NAME = 'Simisola'
commit

--how to create a backup of a table
drop table if exists ResultBkup
select * into ResultBkup
from [Results 1]

select *
from ResultBkup

--How to clear records from a table
truncate table ResultBkup

--How to clear records from a table
delete from ResultBkup

/**
we have 3 types of temporary table
temporary table also called local temporary table
global table
CTE common table expression
**/

select * into #ResultBkupTemp
from [Results 1]


select * into ##ResultBkupTemp
from [Results 1]

select * from #ResultBkupTemp
select * from ##ResultBkupTemp
;
--how to create common table expression
with cte as 
(
select *
from [Results 1]
)
select * from cte

select @@SERVERNAME
select * from INFORMATION_SCHEMA.tables

select * into SQLTraining.dbo.Results_1
from FinalExam.dbo.[Results 1]

select * from ##vwGradeBkupTemp

select * 
from #GamesBkupTemp
