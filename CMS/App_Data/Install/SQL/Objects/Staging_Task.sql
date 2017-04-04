SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Task](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskSiteID] [int] NULL,
	[TaskDocumentID] [int] NULL,
	[TaskNodeAliasPath] [nvarchar](450) NULL,
	[TaskTitle] [nvarchar](450) NOT NULL,
	[TaskData] [nvarchar](max) NOT NULL,
	[TaskTime] [datetime2](7) NOT NULL,
	[TaskType] [nvarchar](50) NOT NULL,
	[TaskObjectType] [nvarchar](100) NULL,
	[TaskObjectID] [int] NULL,
	[TaskRunning] [bit] NULL,
	[TaskNodeID] [int] NULL,
	[TaskServers] [nvarchar](max) NULL,
 CONSTRAINT [PK_Staging_Task] PRIMARY KEY NONCLUSTERED 
(
	[TaskID] ASC
)
)

GO
CREATE UNIQUE CLUSTERED INDEX [IX_Staging_TaskID] ON [dbo].[Staging_Task]
(
	[TaskID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning] ON [dbo].[Staging_Task]
(
	[TaskDocumentID] ASC,
	[TaskNodeID] ASC,
	[TaskRunning] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning] ON [dbo].[Staging_Task]
(
	[TaskObjectType] ASC,
	[TaskObjectID] ASC,
	[TaskRunning] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskSiteID] ON [dbo].[Staging_Task]
(
	[TaskSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskType] ON [dbo].[Staging_Task]
(
	[TaskType] ASC
)
GO
ALTER TABLE [dbo].[Staging_Task] ADD  CONSTRAINT [DEFAULT_Staging_Task_TaskServers]  DEFAULT ('null') FOR [TaskServers]
GO
ALTER TABLE [dbo].[Staging_Task]  WITH CHECK ADD  CONSTRAINT [FK_Staging_Task_TaskSiteID_CMS_Site] FOREIGN KEY([TaskSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Staging_Task] CHECK CONSTRAINT [FK_Staging_Task_TaskSiteID_CMS_Site]
GO
