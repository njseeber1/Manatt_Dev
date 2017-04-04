SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_OM_RemoveDataFromWebAnalytics]
@Name nvarchar(100),
	@SiteID int
AS
BEGIN
DELETE FROM Analytics_YearHits WHERE HitsStatisticsID IN (SELECT StatisticsID FROM Analytics_Statistics WHERE
        (StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID)
	 
	 DELETE FROM Analytics_MonthHits WHERE HitsStatisticsID IN (SELECT StatisticsID FROM Analytics_Statistics WHERE
		(StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID)
	 
	 DELETE FROM Analytics_WeekHits WHERE HitsStatisticsID IN (SELECT StatisticsID FROM Analytics_Statistics WHERE
		(StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID)
	 
	 DELETE FROM Analytics_DayHits WHERE HitsStatisticsID IN (SELECT StatisticsID FROM Analytics_Statistics WHERE
		(StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID)
	 
	 DELETE FROM Analytics_HourHits WHERE HitsStatisticsID IN (SELECT StatisticsID FROM Analytics_Statistics WHERE
		(StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID)
		 
     DELETE FROM Analytics_Statistics WHERE
        (StatisticsCode LIKE 'abconversion;'+ @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'absessionconversionrecurring;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitfirst;' + @Name + ';%' OR
         StatisticsCode LIKE 'abvisitreturn;' + @Name + ';%') AND
         StatisticsSiteID = @SiteID
END


GO
