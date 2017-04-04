SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_Analytics_Pivot]
@Type nvarchar(5),
@StaticColumns nvarchar(MAX) = N''
AS
BEGIN
	IF  OBJECT_ID('tempdb..#AnalyticsTempTable') IS NULL
	BEGIN
	   RETURN;
    END;

	IF ((SELECT COUNT (*) FROM #AnalyticsTempTable WHERE Name IS NOT NULL) > 0)
	BEGIN
        
		------ Get all columns for PIVOT functions
		DECLARE @Columns NVARCHAR(MAX)
		DECLARE @ColumnsNull NVARCHAR (MAX)

		---- Columns for pivot
		SELECT @Columns = COALESCE(@Columns + N',[' + CAST(Name AS NVARCHAR(MAX)) + N']',
			N'[' + CAST(Name AS NVARCHAR(MAX))+ N']')
			FROM #AnalyticsTempTable
			GROUP BY Name ORDER BY Name

		---- Columns for ISNULL function
		SELECT @ColumnsNull = COALESCE(@ColumnsNull + N',ISNULL([' + CAST(Name AS NVARCHAR(MAX)) + N'],0) AS '''+CAST(Name AS NVARCHAR(MAX))+'''',
			'ISNULL([' + CAST(Name AS NVARCHAR(MAX))+ N'],0) AS '''+ CAST(Name AS NVARCHAR(MAX))+'''')
			FROM #AnalyticsTempTable
			GROUP BY Name ORDER BY Name
			
		------ Pivot function
		DECLARE @Query NVARCHAR(MAX)
		IF (@Type = N'week')
		BEGIN
			SET @Query = N'SELECT  CONVERT (NVARCHAR(2),DATEPART(wk,[StartTime]))+''/''+CONVERT (NVARCHAR(4),DATEPART(YEAR,[StartTime])), '+  @Columns + @StaticColumns + N' FROM #AnalyticsTempTable PIVOT ( SUM(Hits) FOR [Name] IN (' + @Columns + N') ) AS p'-- ORDER BY StartTime'
		END
		ELSE
		BEGIN
			SET @Query = N'SELECT  StartTime, '+  @Columns + @StaticColumns + N'  FROM #AnalyticsTempTable PIVOT ( SUM(Hits) FOR [Name] IN (' + @Columns + N') ) AS p ORDER BY StartTime'
		END
		
		EXECUTE(@Query)		
		
	END
	ELSE 
    BEGIN 
		IF (@Type =N'week')
		BEGIN
			 EXECUTE(N'SELECT CONVERT (NVARCHAR(2),DATEPART(wk,[StartTime]))+''/''+CONVERT (NVARCHAR(4),DATEPART(YEAR,[StartTime])),Hits '+ @StaticColumns  +N' FROM #AnalyticsTempTable');
		END
		ELSE
		BEGIN
			EXECUTE(N'SELECT StartTime,Hits'+@StaticColumns+N' FROM #AnalyticsTempTable')
		END
	END
END




GO
