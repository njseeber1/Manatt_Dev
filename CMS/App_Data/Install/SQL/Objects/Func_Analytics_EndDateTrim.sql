SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_Analytics_EndDateTrim]
(
        @EndDate DATETIME,
        @DayPart   VARCHAR(5) 
)        
RETURNS DATETIME
AS BEGIN      	
	IF (@DayPart = 'year') BEGIN
		IF (@EndDate IS NULL)
		BEGIN
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_YearHits ORDER BY HitsStartTime DESC)
		END
		ELSE 
		BEGIN
			-- Trim time
			SET @EndDate =  DATEADD(dd, DATEDIFF(dd, 0, @EndDate), 0);
	
			-- Get first day of next year
			SET @EndDate = DATEADD(yy, DATEDIFF(yy, 0, DATEADD(YEAR,1,@EndDate)), 0);		
		END
	END;
	
	
	IF (@DayPart = 'month') 
	BEGIN
		IF (@EndDate IS NULL)
		BEGIN
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_MonthHits ORDER BY HitsStartTime DESC)
		END
		ELSE 
		BEGIN
			-- Trim time
			SET @EndDate =  DATEADD(dd, DATEDIFF(dd, 0, @EndDate), 0);
	
			-- Get first day of month
			SET @EndDate = DATEADD(dd,-(DAY(@EndDate)-1),@EndDate);
		
			-- Add month
			SET @EndDate = DATEADD(mm,1,@EndDate);
		END;
	END;
	
	IF (@DayPart = 'week') BEGIN	
		IF (@EndDate IS NULL)
		BEGIN
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_WeekHits ORDER BY HitsStartTime DESC)
		END
		ELSE 
		BEGIN	
			-- Trim time
			SET @EndDate =  DATEADD(dd, DATEDIFF(dd, 0, @EndDate), 0);
			---- Get first day of week
			SET @EndDate = DATEADD(wk, DATEDIFF(wk, 6, @EndDate), 6);
		
			-- Add week
			SET @EndDate = DATEADD(dd,7,@EndDate);
		END;
	END;
	
	IF (@DayPart ='day') BEGIN
		IF (@EndDate IS NULL)
		BEGIN
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_DayHits ORDER BY HitsStartTime DESC)
		END
		ELSE 
		BEGIN
			SET @EndDate =  DATEADD(dd, DATEDIFF(dd, 0, @EndDate), 0);
		
			-- Add day
			SET @EndDate = DATEADD(dd,1,@EndDate);
		END;
	END;
	
	IF (@DayPart = 'hour') BEGIN
		IF (@EndDate IS NULL)
		BEGIN
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_HourHits ORDER BY HitsStartTime DESC)
		END
		ELSE 
		BEGIN
			SET @EndDate =  DATEADD(hh, DATEDIFF(hh, 0, @EndDate), 0);
		
			-- Add hour
			SET @EndDate = DATEADD(hh,1,@EndDate);
		END;
	END;
	
	RETURN (@EndDate)
		
END;


GO
