USE [SQLTraining]
GO

/****** Object:  StoredProcedure [dbo].[spContinent]    Script Date: 9/11/2024 11:32:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[spCompanyInfo]    Script Date: 9/11/2024 10:12:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the continent info records
--ChangeLog:Modifying this stored procedure to include Country parameter
--Version: v2.0
--Date: 09/11/2024
-- =============================================

alter PROCEDURE [dbo].[spContinent]
@Country varchar(50),
@First_Name varchar(50)

AS
BEGIN
	

    -- Insert statements for procedure here
select *
from CompanyinfoCaseContinent
where Country=@Country
and First_Name=@First_Name

	
END

exec spContinent @Country='USA',@First_Name='John'




/****** Object:  StoredProcedure [dbo].[spContinent]    Script Date: 9/11/2024 11:32:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[spCompanyInfo]    Script Date: 9/11/2024 10:12:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to generate the continent info records
--ChangeLog:Modifying this stored procedure to include Country parameter and Continent parameter
--Version: v2.1
--Date: 09/11/2024
-- =============================================

create PROCEDURE [dbo].[spUpdateContinent]
@Country varchar(50),
@NewContinent varchar(50)


AS
BEGIN
	

    -- Insert statements for procedure here
update CompanyinfoCaseContinent
set Continent=@NewContinent
where Country=@Country

	
END

exec spUpdateContinent @Country='USA',@NewContinent='Global'

select * 
from CompanyinfoCaseContinent