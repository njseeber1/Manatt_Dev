SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SearchTask](
	[SearchTaskID] [int] IDENTITY(1,1) NOT NULL,
	[SearchTaskType] [nvarchar](100) NOT NULL,
	[SearchTaskObjectType] [nvarchar](100) NULL,
	[SearchTaskField] [nvarchar](200) NULL,
	[SearchTaskValue] [nvarchar](600) NOT NULL,
	[SearchTaskServerName] [nvarchar](200) NULL,
	[SearchTaskStatus] [nvarchar](100) NOT NULL,
	[SearchTaskPriority] [int] NOT NULL,
	[SearchTaskCreated] [datetime2](7) NOT NULL,
	[SearchTaskErrorMessage] [nvarchar](max) NULL,
	[SearchTaskRelatedObjectID] [int] NULL,
 CONSTRAINT [PK_CMS_SearchTask] PRIMARY KEY NONCLUSTERED 
(
	[SearchTaskID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName] ON [dbo].[CMS_SearchTask]
(
	[SearchTaskPriority] DESC,
	[SearchTaskStatus] ASC,
	[SearchTaskServerName] ASC
)
GO
ALTER TABLE [dbo].[CMS_SearchTask] ADD  CONSTRAINT [DEFAULT_cms_SearchTask_SearchTaskType]  DEFAULT ('') FOR [SearchTaskType]
GO
ALTER TABLE [dbo].[CMS_SearchTask] ADD  CONSTRAINT [DEFAULT_cms_SearchTask_SearchTaskValue]  DEFAULT ('') FOR [SearchTaskValue]
GO
ALTER TABLE [dbo].[CMS_SearchTask] ADD  CONSTRAINT [DEFAULT_cms_SearchTask_SearchTaskStatus]  DEFAULT ('') FOR [SearchTaskStatus]
GO
ALTER TABLE [dbo].[CMS_SearchTask] ADD  CONSTRAINT [DF_CMS_SearchTask_SearchTaskPriority]  DEFAULT ((0)) FOR [SearchTaskPriority]
GO
ALTER TABLE [dbo].[CMS_SearchTask] ADD  CONSTRAINT [DEFAULT_cms_SearchTask_SearchTaskCreated]  DEFAULT ('4/15/2009 11:23:52 AM') FOR [SearchTaskCreated]
GO
