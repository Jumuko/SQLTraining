USE [SQLTraining]
GO
/****** Object:  StoredProcedure [dbo].[spGeneration]    Script Date: 9/12/2024 8:37:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 08/23/2024
-- Description:	This stored procedure was created to view generation records in the BusinessCaseGeneration table
--Version: v1.1
--Change Log: Modified to view get information specific to age and generation
--Date: 9/12/2024
-- =============================================
ALTER PROCEDURE [dbo].[spGeneration]
@Age int null,
@Generation varchar null
	
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from BusinessCaseGeneration
	where Age=@Age 
	and Generation=@Generation

END
Go

exec spGeneration @Age =25, @Generation='Gen Z'

SELECT *
	from BusinessCaseGeneration
	where Age=25
	and Generation='Gen Z'