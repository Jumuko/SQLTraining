USE [SQLTraining]
GO

/****** Object:  StoredProcedure [dbo].[spNoble]    Script Date: 9/10/2024 11:06:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		John 
-- Create date: 09/10/2024
-- Description:	This stored procedure was created to update employee salary
-- changelog: Modifying this store procedure to parameterise it
--Version: v1.0
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateEmadeConsultingEmployee]
	@working_hours int,
	@NewSalary money
AS
BEGIN
	

    -- Insert statements for procedure here
	update EmadeConsultingEmployee
	set salary=@NewSalary 
	where working_hours=@Working_hours
END
GO

select *
from EmadeConsultingEmployee

exec spUpdateEmadeConsultingEmployee @working_hours=12,@NewSalary=200000
