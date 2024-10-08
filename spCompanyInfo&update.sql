USE [SQLTraining]
GO
/****** Object:  StoredProcedure [dbo].[spCompanyInfo]    Script Date: 9/11/2024 10:12:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the job company info records
--ChangeLog:Modifying this stored procedure to include Country parameter and Continents
--Version: v2.0
--Date: 09/11/2024
-- =============================================

ALTER PROCEDURE [dbo].[spCompanyInfo]
@Country varchar(50),
@Last_Name varchar(50)

AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *,
	case 
	when Country='USA' then 'NorthAmerica'
	else 'Europe'
	end Continent
	from CompanyInfo
	where Country=@Country
	and Last_Name=@Last_Name

	
END

select *
from CompanyInfo

exec spCompanyInfo @Country='Canada',@Last_Name='Jones'

drop procedure if exists spUpdateCompanyInfo
/****** Object:  StoredProcedure [dbo].[spCompanyInfo]    Script Date: 9/11/2024 10:12:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the job company info records
--ChangeLog:Modifying this stored procedure to include Country parameter and New FirstName 
--Version: v2.1
--Date: 09/11/2024
-- =============================================

create PROCEDURE [dbo].[spUpdateCompanyInfo]
@Country varchar(50),
@NewFirst_NAME varchar(50)

AS
BEGIN
	

    -- Insert statements for procedure here
	update CompanyInfo
	set FIRST_NAME=@NewFirst_NAME
	where Country=@Country

	
END


exec spUpdateCompanyInfo @Country='Canada',@NewFirst_NAME='Agbalagba'

select *
from CompanyInfo
