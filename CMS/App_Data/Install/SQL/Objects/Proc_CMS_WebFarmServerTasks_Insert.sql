SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_CMS_WebFarmServerTasks_Insert]
@FirstGuid uniqueidentifier,
	@Count int,
	@CurrentServerId int
AS
BEGIN
DECLARE @taskId INT;
    DECLARE @ServerList TABLE (
		ID INT,
		IsDisabled BIT);

    SELECT @taskId = [TaskID] FROM [CMS_WebFarmTask] WHERE [TaskGUID] = @FirstGuid
    SET @Count = @taskId + @Count
    INSERT INTO @ServerList
        SELECT ServerID, CAST(case when ServerLog.LogCode LIKE N'AutoDisabled' then 1 else 0 end as bit) FROM [CMS_WebFarmServer] OUTER APPLY (
            SELECT  TOP 1 LogCode
            FROM    [CMS_WebFarmServerLog]
            WHERE   [CMS_WebFarmServerLog].ServerID = [CMS_WebFarmServer].ServerID
            ORDER BY LogTime DESC) ServerLog

	INSERT INTO [CMS_WebFarmServerTask] ( [ServerID], [TaskID] )
        SELECT sl.ID, [TaskID] FROM [CMS_WebFarmTask], @ServerList as sl
        WHERE [TaskID] >= @taskId AND [TaskID] < @Count AND sl.ID <> @CurrentServerId AND ([TaskIsMemory] IS NULL OR [TaskIsMemory] = 0 OR sl.IsDisabled = 0)
END


GO
