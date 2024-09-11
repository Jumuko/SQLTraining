USE [SQLTraining]
GO

/****** Object:  StoredProcedure [dbo].[spHrAnalysis]    Script Date: 9/11/2024 12:39:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John U
-- Create date: 9/4/2024
-- Description:	This is a stored procedure for HrAnalysis data
--Change Log: Modified stored procedure to include department parameter and include top 5 daily rate by department
--Version: 2.0
--Date: 9/11/2024
-- =============================================
alter PROCEDURE [dbo].[spHrAnalysis]
@Department varchar(50) null,
@EducationField varchar(50) null

	
AS
BEGIN
	

    -- Insert statements for procedure here
	select top 5*
from HrAnalysis1
where Department=@Department
and EducationField = @EducationField
order by DailyRate desc


END
GO

select *
from HrAnalysis1

exec spHrAnalysis @Department='Sales',@EducationField='Medical'


drop procedure if exists spUpdateHrAnalysis
/****** Object:  StoredProcedure [dbo].[spHrAnalysis]    Script Date: 9/11/2024 12:39:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John U
-- Create date: 9/4/2024
-- Description:	This is a stored procedure for HrAnalysis data
--Change Log: Updated stored procedure to include department parameter, job-involvement parameter and Education parameter
--Version: 2.1
--Date: 9/11/2024
-- =============================================
create PROCEDURE [dbo].[spUpdateHrAnalysis]
@Department varchar(50) null,
@NewJobInvolvement int null,
@NewEducation int null

	
AS
BEGIN
	

    -- Insert statements for procedure here
update HrAnalysis1
set JobInvolvement=@NewJobInvolvement, Education=@NewEducation
where Department=@Department


END
GO

exec spUpdateHrAnalysis @Department='Human Resources',@NewJobInvolvement=10,@NewEducation=5

select *
from HrAnalysis1
where Department = 'Human Resources'