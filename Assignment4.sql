
select * from INFORMATION_SCHEMA.tables
/**
select * into SQLTraining.dbo.EmployeeInfo
from SQLTrainingCase.dbo.EmployeeInfo

select * into SQLTraining.dbo.CompanyInfo
from SQLTrainingCase.dbo.CompanyInfo

select * into SQLTraining.dbo.Business
from SQLTrainingCase.dbo.Business

select * into SQLTraining.dbo.Employee
from CompanyInfo.dbo.Employee

select * into SQLTraining.dbo.Results_1
from FinalExam.dbo.[Results 1]
**/



-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the records in the world table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spWorld
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from World
END
GO

exec spWorld;

drop view if exists vwSizeOfCompany;

create view vwSizeOfCompany as
select SizeOfCompany
from EmmployeeInfoCaseSizeOfCompany

create view vwJobPosition as
select JobPosition
from BusinessCaseJobPosition

create view vwGeneration as
select Generation
from BusinessCaseGeneration

create view vwContinent as
select Continent
from CompanyInfoCaseContinent

select *
from vwSizeOfCompany

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to view Old Games in the Games table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spvwOldGames
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from vwOldGames
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to view low GDP countries in the World table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spvwlowGdpCountries
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from vwlowGdpCountries
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to view business records in the Business table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spBusiness
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from Business
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to view generation records in the BusinessCaseGeneration table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spGeneration
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from BusinessCaseGeneration
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the job position records in the Business table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spJobPosition
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from BusinessCaseJobPosition
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the job company info records
--Version: v1.0
-- =============================================
CREATE PROCEDURE spCompanyInfo
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from CompanyInfo
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the continent records in the CompanyInfo table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spContinent
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from CompanyInfoCaseContinent
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the size of company records in the EmployeeInfo table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spSizeOfCompany
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from EmmployeeInfoCaseSizeOfCompany
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate employee records
--Version: v1.0
-- =============================================
CREATE PROCEDURE spEmployee
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from Employee
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate employee info records
--Version: v1.0
-- =============================================
CREATE PROCEDURE spEmployeeInfo
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from EmployeeInfo
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate exam records from Results_1 table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spExamRecord
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from Results_1
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate grade records from ResultsCaseGrade table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spGrade
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from ResultCaseGrade
END
GO

-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate pass or fail records from ResultCaseResult table
--Version: v1.0
-- =============================================
CREATE PROCEDURE spResult
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from ResultCaseResult
END
GO

select * into #GamesBkupTemp
from Games

select * into ##GamesBkupTemp
from Games

select * into #vwOldGamesBkupTemp
from vwOldGames

select * into ##vwOldGamesBkupTemp
from vwOldGames

select * into #WorldBkupTemp
from World

select * into ##WorldBkupTemp
from World

select * into #vwlowGdpCountriesBkupTemp
from vwlowGdpCountries

select * into ##vwlowGdpCountriesBkupTemp
from vwlowGdpCountries

select * into #vwOldNobleBkupTemp
from vwOldNoble

select * into ##vwOldNobleBkupTemp
from vwOldNoble

select * into #NobleBkupTemp
from Noble

select * into ##NobleBkupTemp
from Noble

select * into #BusinessBkupTemp
from Business

select * into ##BusinessBkupTemp
from Business

select * into #Results_1BkupTemp
from Results_1

select * into ##Results_1BkupTemp
from Results_1

select * into #EmployeeBkupTemp
from Employee

select * into ##EmployeeBkupTemp
from Employee

select * into #CompanyInfoBkupTemp
from CompanyInfo

select * into ##CompanyInfoBkupTemp
from CompanyInfo

select * into #EmployeeInfoBkupTemp
from EmployeeInfo

select * into ##EmployeeInfoBkupTemp
from EmployeeInfo

select * into #EmployeeInfoCaseSizeOfCompBkupTemp
from EmmployeeInfoCaseSizeOfCompany

select * into ##EmployeeInfoCaseSizeOfCompBkupTemp
from EmmployeeInfoCaseSizeOfCompany

select * into #CompanyInfoCaseContinentBkupTemp
from CompanyInfoCaseContinent

select * into ##CompanyInfoCaseContinentBkupTemp
from CompanyInfoCaseContinent

select * into #BusinessCaseGenerationBkupTemp
from BusinessCaseGeneration

select * into ##BusinessCaseGenerationBkupTemp
from BusinessCaseGeneration

select * into #BusinessCaseJobPositionBkupTemp
from BusinessCaseJobPosition

select * into ##BusinessCaseJobPositionBkupTemp
from BusinessCaseJobPosition

select * into #vwContinentBkupTemp
from vwContinent

select * into ##vwContinentBkupTemp
from vwContinent

select * into #vwGenerationBkupTemp
from vwGeneration

select * into ##vwGenerationBkupTemp
from vwGeneration

select * into #vwJobPositionBkupTemp
from vwJobPosition

select * into ##vwJobPositionBkupTemp
from vwJobPosition

select * into #vwSizeOfCompanyBkupTemp
from vwSizeOfCompany

select * into ##vwSizeOfCompanyBkupTemp
from vwSizeOfCompany

select * into #ResultCaseResultBkupTemp
from ResultCaseResult

select * into ##ResultCaseResultBkupTemp
from ResultCaseResult

select * into #ResultCaseGradeBkupTemp
from ResultCaseGrade

select * into ##ResultCaseGradeBkupTemp
from ResultCaseGrade

select * into #vwResultBkupTemp
from vwResult

select * into ##vwResultBkupTemp
from vwResult

select * into #vwGradeBkupTemp
from vwGrade

select * into ##vwGradeBkupTemp
from vwGrade

SELECT name 
FROM tempdb.sys.tables 
WHERE name LIKE '##%';

SELECT name 
FROM tempdb.sys.tables 
WHERE name LIKE '#%';


sp_helptext spBusiness

select *
from Noble
