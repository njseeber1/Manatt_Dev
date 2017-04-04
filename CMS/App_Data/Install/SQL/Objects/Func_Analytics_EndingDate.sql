SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION Func_Analytics_EndingDate 
(
	-- Add the parameters for the function here
	@dateType VARCHAR(20)
)
RETURNS DATETIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return DATETIME

	SELECT @Return = CASE @dateType 
	WHEN 'today' then getdate()
	WHEN 'thisWeek' then getdate()
	WHEN 'thisMonth' then getdate()
	WHEN 'thisQuarter' then getdate()
	WHEN 'thisHalf' then getdate()
	WHEN 'thisYear' then getdate()
	WHEN 'yesterday' then dateadd(day, datediff(day,0,getdate()), 0)
	WHEN 'lastWeek' then dateadd(week, datediff(week,0,getdate()), 0)
	WHEN 'lastMonth' then dateadd(month, datediff(month,0,getdate()), 0)
	WHEN 'lastQuarter' then dateadd(qq,datediff(qq,0,getdate()),0)
	WHEN 'lastHalf' then dateadd(month, (datediff(month, '19000101', getdate()) / 6) * 6, '19000101')
	WHEN 'lastYear' then dateadd(yy, datediff(yy,0,getdate()), 0)
	END
	
	RETURN (@Return)

END


GO
