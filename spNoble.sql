USE [SQLTraining]
GO
/****** Object:  StoredProcedure [dbo].[spNoble]    Script Date: 9/10/2024 11:28:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John 
-- Create date: 08/22/2024
-- Description:	This stored procedure was created to generate final exam results
-- changelog: Modifying this store procedure to parameterise it
--Version:v2.0
--Modify Date: 09/10/2024
-- =============================================
ALTER PROCEDURE [dbo].[spNoble]
	@year int,
	@subject varchar(50) null
AS
BEGIN
	

    -- Insert statements for procedure here
	SELECT *
	from Noble
	where year = @year and subject=@subject
END
