SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_CMS_EventLog_DeleteOlderLogs]
@SiteId int,
@LogMaxSize int,
@MaxToDelete int
AS
BEGIN
DECLARE @items int;
IF @SiteId > 0
	SET @items = (SELECT COUNT(EventID) FROM CMS_EventLog WHERE SiteID = @SiteId);
ELSE
	SET @items = (SELECT COUNT(EventID) FROM CMS_EventLog WHERE SiteID IS NULL);


DECLARE @MaxSize int;
IF ((@items - @LogMaxSize) > @MaxToDelete)
	SET @MaxSize = @MaxToDelete;
ELSE
	SET @MaxSize = @items - @LogMaxSize;


IF @SiteId > 0
	-- Delete site logs
	DELETE eventLog
		FROM (SELECT ROW_NUMBER() 
			OVER(ORDER BY EventID) rowNumber 
			FROM CMS_EventLog WHERE SiteId = @SiteId) eventLog
		WHERE eventLog.rowNumber <= @MaxSize;
ELSE
	-- Delete global logs
    DELETE eventLog
		FROM (SELECT ROW_NUMBER() 
            OVER(ORDER BY EventID) rowNumber 
            FROM CMS_EventLog WHERE SiteId IS NULL) eventLog
		WHERE eventLog.rowNumber <= @MaxSize;
END


GO
