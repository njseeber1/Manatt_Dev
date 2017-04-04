SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ScheduledTask](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](200) NOT NULL,
	[TaskDisplayName] [nvarchar](200) NOT NULL,
	[TaskAssemblyName] [nvarchar](200) NOT NULL,
	[TaskClass] [nvarchar](200) NULL,
	[TaskInterval] [nvarchar](1000) NOT NULL,
	[TaskData] [nvarchar](max) NOT NULL,
	[TaskLastRunTime] [datetime2](7) NULL,
	[TaskNextRunTime] [datetime2](7) NULL,
	[TaskProgress] [int] NULL,
	[TaskLastResult] [nvarchar](max) NULL,
	[TaskEnabled] [bit] NOT NULL,
	[TaskSiteID] [int] NULL,
	[TaskDeleteAfterLastRun] [bit] NULL,
	[TaskServerName] [nvarchar](100) NULL,
	[TaskGUID] [uniqueidentifier] NOT NULL,
	[TaskLastModified] [datetime2](7) NOT NULL,
	[TaskExecutions] [int] NULL,
	[TaskResourceID] [int] NULL,
	[TaskRunInSeparateThread] [bit] NULL,
	[TaskUseExternalService] [bit] NULL,
	[TaskAllowExternalService] [bit] NULL,
	[TaskLastExecutionReset] [datetime2](7) NULL,
	[TaskCondition] [nvarchar](400) NULL,
	[TaskRunIndividually] [bit] NULL,
	[TaskUserID] [int] NULL,
	[TaskType] [int] NULL,
	[TaskObjectType] [nvarchar](100) NULL,
	[TaskObjectID] [int] NULL,
	[TaskExecutingServerName] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_ScheduledTask] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName] ON [dbo].[CMS_ScheduledTask]
(
	[TaskNextRunTime] ASC,
	[TaskEnabled] ASC,
	[TaskServerName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ScheduledTask_TaskResourceID] ON [dbo].[CMS_ScheduledTask]
(
	[TaskResourceID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName] ON [dbo].[CMS_ScheduledTask]
(
	[TaskSiteID] ASC,
	[TaskDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ScheduledTask_TaskUserID] ON [dbo].[CMS_ScheduledTask]
(
	[TaskUserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ScheduledTask] ADD  CONSTRAINT [DEFAULT_CMS_ScheduledTask_TaskAllowExternalService]  DEFAULT ((0)) FOR [TaskAllowExternalService]
GO
ALTER TABLE [dbo].[CMS_ScheduledTask] ADD  CONSTRAINT [DEFAULT_CMS_ScheduledTask_TaskExecutingServerName]  DEFAULT (N'') FOR [TaskExecutingServerName]
GO
ALTER TABLE [dbo].[CMS_ScheduledTask]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_ScheduledTask_TaskResourceID_CMS_Resource] FOREIGN KEY([TaskResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_ScheduledTask] CHECK CONSTRAINT [FK_CMS_ScheduledTask_TaskResourceID_CMS_Resource]
GO
ALTER TABLE [dbo].[CMS_ScheduledTask]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_ScheduledTask_TaskSiteID_CMS_Site] FOREIGN KEY([TaskSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_ScheduledTask] CHECK CONSTRAINT [FK_CMS_ScheduledTask_TaskSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_ScheduledTask]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_ScheduledTask_TaskUserID_CMS_User] FOREIGN KEY([TaskUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_ScheduledTask] CHECK CONSTRAINT [FK_CMS_ScheduledTask_TaskUserID_CMS_User]
GO
