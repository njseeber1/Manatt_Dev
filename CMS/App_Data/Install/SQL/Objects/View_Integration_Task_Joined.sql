SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_Integration_Task_Joined
AS
SELECT        dbo.Integration_Synchronization.SynchronizationID, dbo.Integration_Synchronization.SynchronizationTaskID, 
                         dbo.Integration_Synchronization.SynchronizationConnectorID, dbo.Integration_Synchronization.SynchronizationLastRun, 
                         dbo.Integration_Synchronization.SynchronizationErrorMessage, dbo.Integration_Synchronization.SynchronizationIsRunning, dbo.Integration_Task.TaskID, 
                         dbo.Integration_Task.TaskNodeID, dbo.Integration_Task.TaskDocumentID, dbo.Integration_Task.TaskNodeAliasPath, dbo.Integration_Task.TaskTitle, 
                         dbo.Integration_Task.TaskTime, dbo.Integration_Task.TaskType, dbo.Integration_Task.TaskObjectType, dbo.Integration_Task.TaskObjectID, 
                         dbo.Integration_Task.TaskIsInbound, dbo.Integration_Task.TaskProcessType, dbo.Integration_Task.TaskData, dbo.Integration_Task.TaskSiteID, 
                         dbo.Integration_Task.TaskDataType
FROM            dbo.Integration_Synchronization RIGHT OUTER JOIN
                         dbo.Integration_Task ON dbo.Integration_Synchronization.SynchronizationTaskID = dbo.Integration_Task.TaskID


GO
