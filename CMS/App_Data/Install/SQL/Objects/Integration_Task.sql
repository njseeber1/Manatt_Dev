SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Integration_Task](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskNodeID] [int] NULL,
	[TaskDocumentID] [int] NULL,
	[TaskNodeAliasPath] [nvarchar](450) NULL,
	[TaskTitle] [nvarchar](450) NOT NULL,
	[TaskTime] [datetime2](7) NOT NULL,
	[TaskType] [nvarchar](50) NOT NULL,
	[TaskObjectType] [nvarchar](100) NULL,
	[TaskObjectID] [int] NULL,
	[TaskIsInbound] [bit] NOT NULL,
	[TaskProcessType] [nvarchar](50) NULL,
	[TaskData] [nvarchar](max) NOT NULL,
	[TaskSiteID] [int] NULL,
	[TaskDataType] [nvarchar](50) NULL,
 CONSTRAINT [PK_Integration_Task] PRIMARY KEY NONCLUSTERED 
(
	[TaskID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Integration_Task_TaskNodeAliasPath] ON [dbo].[Integration_Task]
(
	[TaskNodeAliasPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Integration_Task_TaskIsInbound] ON [dbo].[Integration_Task]
(
	[TaskIsInbound] ASC
)
INCLUDE ( 	[TaskID])
GO
CREATE NONCLUSTERED INDEX [IX_Integration_Task_TaskSiteID] ON [dbo].[Integration_Task]
(
	[TaskSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Integration_Task_TaskType] ON [dbo].[Integration_Task]
(
	[TaskType] ASC
)
GO
ALTER TABLE [dbo].[Integration_Task]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationTask_TaskSiteID_CMS_Site] FOREIGN KEY([TaskSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Integration_Task] CHECK CONSTRAINT [FK_IntegrationTask_TaskSiteID_CMS_Site]
GO
