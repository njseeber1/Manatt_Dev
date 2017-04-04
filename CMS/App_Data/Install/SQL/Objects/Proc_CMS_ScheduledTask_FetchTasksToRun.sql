SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_CMS_ScheduledTask_FetchTasksToRun]
@TaskSiteID int,
@DateTime datetime,
@TaskServerName nvarchar(100),
@UseExternalService bit = null
AS
BEGIN
DECLARE @TaskIDs TABLE (TaskID int, TaskDisplayName nvarchar(200));
BEGIN TRAN
    IF (@TaskSiteID IS NOT NULL)
    BEGIN
      /* Get tasks for specified site and global tasks that should be processed by application */
      IF (@UseExternalService = 0)
        BEGIN
          INSERT INTO @TaskIDs SELECT TaskID, TaskDisplayName FROM CMS_ScheduledTask WHERE TaskNextRunTime IS NOT NULL AND TaskNextRunTime <= @DateTime AND TaskEnabled = 1
              AND (TaskSiteID = @TaskSiteID OR TaskSiteID IS NULL) AND (TaskServerName IS NULL OR TaskServerName = '' OR TaskServerName = @TaskServerName) AND (TaskUseExternalService = 0 OR TaskUseExternalService IS NULL);
        END
      ELSE IF (@UseExternalService = 1)
        /* Get tasks for specified site and global tasks that should be processed by external service */
        BEGIN
          INSERT INTO @TaskIDs SELECT TaskID, TaskDisplayName FROM CMS_ScheduledTask WHERE TaskNextRunTime IS NOT NULL AND TaskNextRunTime <= @DateTime AND TaskEnabled = 1
              AND (TaskSiteID = @TaskSiteID OR TaskSiteID IS NULL) AND (TaskServerName IS NULL OR TaskServerName = '' OR TaskServerName = @TaskServerName) AND (TaskUseExternalService = 1);
        END
      ELSE IF (@UseExternalService IS NULL)
        /* Get tasks for specified site and global tasks */
        BEGIN
          INSERT INTO @TaskIDs SELECT TaskID, TaskDisplayName FROM CMS_ScheduledTask WHERE TaskNextRunTime IS NOT NULL AND TaskNextRunTime <= @DateTime AND TaskEnabled = 1
              AND (TaskSiteID = @TaskSiteID OR TaskSiteID IS NULL) AND (TaskServerName IS NULL OR TaskServerName = '' OR TaskServerName = @TaskServerName);
        END
    END
    ELSE
    BEGIN
      IF (@UseExternalService = 1)
      /* Get sites and global tasks for external service (only for running sites) */
        BEGIN
            INSERT INTO @TaskIDs SELECT TaskID, TaskDisplayName FROM CMS_ScheduledTask
              WHERE TaskNextRunTime IS NOT NULL AND TaskNextRunTime <= @DateTime AND TaskEnabled = 1 AND (TaskSiteID IN (SELECT SiteID FROM CMS_Site WHERE SiteStatus = N'RUNNING') OR TaskSiteID IS NULL)
              AND (TaskServerName IS NULL OR TaskServerName = '' OR TaskServerName = @TaskServerName) AND (TaskUseExternalService = 1);
        END
      ELSE IF (@UseExternalService IS NULL)
      /* Get only global tasks if there is no site */
        BEGIN
            INSERT INTO @TaskIDs SELECT TaskID, TaskDisplayName FROM CMS_ScheduledTask
              WHERE TaskNextRunTime IS NOT NULL AND TaskNextRunTime <= @DateTime AND TaskEnabled = 1 AND (TaskSiteID IS NULL)
              AND (TaskServerName IS NULL OR TaskServerName = '' OR TaskServerName = @TaskServerName);
        END
    END

UPDATE CMS_ScheduledTask SET TaskNextRunTime = NULL, TaskExecutingServerName = @TaskServerName WHERE TaskID IN (SELECT TaskID FROM @TaskIDs);
COMMIT TRAN
SELECT * FROM @TaskIDs;
END



GO
