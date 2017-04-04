SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_Analytics_EnsureDates]
        (
        @StartDate DATETIME,
        @EndDate   DATETIME,
        @DayPart   VARCHAR(5) -- support 'day','month','week','year','hour', default 'day'
        )
RETURNS @rtnTable TABLE
(
	[DATE] datetime PRIMARY KEY
)
AS
BEGIN
	IF (@DayPart = 'year') BEGIN
		IF (@EndDate IS NULL)
		BEGIN		
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_YearHits ORDER BY HitsStartTime DESC)
		END;
		IF (@StartDate IS NULL)
		BEGIN
			SET @StartDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_YearHits ORDER BY HitsStartTime ASC)
		END;			
	END;
	IF (@DayPart = 'month') BEGIN
		IF (@EndDate IS NULL)
		BEGIN		
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_MonthHits ORDER BY HitsStartTime DESC)
		END;
		IF (@StartDate IS NULL)
		BEGIN
			SET @StartDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_MonthHits ORDER BY HitsStartTime ASC)
		END;			
	END;
	IF (@DayPart = 'week') BEGIN
		IF (@EndDate IS NULL)
		BEGIN		
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_WeekHits ORDER BY HitsStartTime DESC)
		END;
		IF (@StartDate IS NULL)
		BEGIN
			SET @StartDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_WeekHits ORDER BY HitsStartTime ASC)
		END;			
	END;
	IF (@DayPart = 'day') BEGIN
		IF (@EndDate IS NULL)
		BEGIN		
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_DayHits ORDER BY HitsStartTime DESC)
		END;
		IF (@StartDate IS NULL)
		BEGIN
			SET @StartDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_DayHits ORDER BY HitsStartTime ASC)
		END;			
	END;
	IF (@DayPart = 'hour') BEGIN
		IF (@EndDate IS NULL)
		BEGIN		
			SET @EndDate = (SELECT TOP 1 HitsStartTime FROM Analytics_HourHits ORDER BY HitsStartTime DESC)
		END;
		IF (@StartDate IS NULL)
		BEGIN
			SET @StartDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_HourHits ORDER BY HitsStartTime ASC)
		END;			
	END;				
	
	WITH dateTable AS
	(
		SELECT TOP (
			CASE @DayPart 
				WHEN 'day'   THEN DATEDIFF(dd,@StartDate,@EndDate)+1
				WHEN 'month' THEN DATEDIFF(mm,@StartDate,@EndDate)+1
				WHEN 'year'  THEN DATEDIFF(yy,@StartDate,@EndDate)+1
				WHEN 'hour'  THEN DATEDIFF(hh,@StartDate,@EndDate)+1
				WHEN 'week'  THEN DATEDIFF(ww,@StartDate,@EndDate)+1
			END  
		)
		ROW_NUMBER() OVER (ORDER BY GetDate())-1 AS N
		FROM sys.All_Columns Sc1
		CROSS JOIN sys.All_Columns Sc2
    )
    INSERT INTO @rtnTable
    SELECT CASE @DayPart 
		WHEN 'day'   THEN DATEADD(dd,t.N,@StartDate)
		WHEN 'month' THEN DATEADD(mm,t.N,@StartDate)
		WHEN 'year'  THEN DATEADD(yy,t.N,@StartDate)
		WHEN 'hour'  THEN DATEADD(hh,t.N,@StartDate)
		WHEN 'week'  THEN DATEADD(ww,t.N,@StartDate)
	END AS DATE
    FROM dateTable t
    
    RETURN
END



GO
