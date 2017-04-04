SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_Analytics_DateTrim]
(
        @FromDate DATETIME,
        @DayPart   VARCHAR(5) 
)        
RETURNS DATETIME
AS BEGIN      
	DECLARE @StartDate DATETIME;	
	IF (@DayPart = 'year') BEGIN
		IF (@FromDate IS NULL)
		BEGIN
			SET @FromDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_YearHits ORDER BY HitsStartTime ASC)
		END
		ELSE 
		BEGIN	
			-- Trim time
			SET @FromDate =  DATEADD(dd, DATEDIFF(dd, 0, @FromDate), 0);

			-- Get first day of year
			SET @StartDate = DATEADD(yy, DATEDIFF(yy, 0, @FromDate), 0)

			-- if not same show next year
			IF (@StartDate <> @FromDate)
			BEGIN
				SET @FromDate = @StartDate;
			END; 
		END
	END;
	
	IF (@DayPart = 'month') 
	BEGIN
		IF (@FromDate IS NULL)
		BEGIN
			SET @FromDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_MonthHits ORDER BY HitsStartTime ASC)
		END
		ELSE 
		BEGIN	
			-- Trim time
			SET @FromDate =  DATEADD(dd, DATEDIFF(dd, 0, @FromDate), 0);
	
			-- Get first day of month
			SET @StartDate = DATEADD(dd,-(DAY(@FromDate)-1),@FromDate);

			-- if not same show next month
			IF (@StartDate <> @FromDate)
			BEGIN
				SET @FromDate = @StartDate;
			END;
		END;
	END;
	
	IF (@DayPart = 'week') BEGIN	
		IF (@FromDate IS NULL)
		BEGIN
			SET @FromDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_WeekHits ORDER BY HitsStartTime ASC)
		END
		ELSE 
		BEGIN		
			-- Trim time
			SET @FromDate =  DATEADD(dd, DATEDIFF(dd, 0, @FromDate), 0);
			---- Get first day of week
			SET @StartDate = DATEADD(wk, DATEDIFF(wk, 6, @FromDate), 6);

			--if not same show next week
			IF (@StartDate <> @FromDate)
			BEGIN
				SET @FromDate = @StartDate;
			END;
		END;
	END;
	
	IF (@DayPart ='day') BEGIN
		IF (@FromDate IS NULL)
		BEGIN
			SET @FromDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_DayHits ORDER BY HitsStartTime ASC)
		END
		ELSE 
		BEGIN			
			SET @FromDate =  DATEADD(dd, DATEDIFF(dd, 0, @FromDate), 0);
		END
	END;
	
	IF (@DayPart = 'hour') BEGIN
		IF (@FromDate IS NULL)
		BEGIN
			SET @FromDate =  (SELECT TOP 1 HitsStartTime FROM Analytics_HourHits ORDER BY HitsStartTime ASC)
		END
		ELSE 
		BEGIN	
			SET @FromDate =  DATEADD(hh, DATEDIFF(hh, 0, @FromDate), 0);
		END
	END;
	
	RETURN (@FromDate)
		
END;


GO
