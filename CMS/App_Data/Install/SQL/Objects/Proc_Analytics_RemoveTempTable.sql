SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Analytics_RemoveTempTable]

AS
BEGIN
 IF  OBJECT_ID('tempdb..#AnalyticsTempTable') IS NOT NULL
	BEGIN
	   DROP TABLE #AnalyticsTempTable;
    END;
END


GO
