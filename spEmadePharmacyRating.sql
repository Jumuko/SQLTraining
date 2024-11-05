USE [Dev]
GO

/****** Object:  StoredProcedure [dbo].[spEmadePharmacyRating]    Script Date: 10/16/2024 10:24:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spEmadePharmacyRating]
@Rating varchar(50)
as
begin
select *
from EMADEPHARMACY
where Rating=@Rating
end
GO


