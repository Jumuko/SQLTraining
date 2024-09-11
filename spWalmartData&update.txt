drop proc if exists spWalmartData
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 09/11/2024
-- Description:	This stored procedure was created to get WalmartData by department and brand.
--Version: v1.0
-- =============================================

create PROCEDURE [dbo].[spWalmartData]
@Department varchar(50) null,
@Brand varchar null


AS
BEGIN
	

    -- Insert statements for procedure here
select *
from WalmartData
where Department=@Department 
and Brand=@Brand


	
END

exec spWalmartData @Department='Beverages',@Brand='v8'

select * 
from WalmartData
where department='Beverages' and brand='V8'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John 
-- Create date: 09/11/2024
-- Description:	This stored procedure was created to update WalmartData.
--Version: v1.1
-- =============================================

create PROCEDURE [dbo].[spUpdateWalmartData]
@Department varchar(50) null,
@Brand varchar null


AS
BEGIN
	

    -- Insert statements for procedure here
update WalmartData
set Brand=@Brand
where Department=@Department 



	
END

exec spUpdateWalmartData @Department='Beverages',@Brand='Great Value'

select * 
from WalmartData
where department='Beverages' 

