SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Export_Task](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskSiteID] [int] NULL,
	[TaskTitle] [nvarchar](450) NOT NULL,
	[TaskData] [nvarchar](max) NOT NULL,
	[TaskTime] [datetime2](7) NOT NULL,
	[TaskType] [nvarchar](50) NOT NULL,
	[TaskObjectType] [nvarchar](100) NULL,
	[TaskObjectID] [int] NULL,
 CONSTRAINT [PK_Export_Task] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Export_Task_TaskSiteID_TaskObjectType] ON [dbo].[Export_Task]
(
	[TaskSiteID] ASC,
	[TaskObjectType] ASC
)
GO
ALTER TABLE [dbo].[Export_Task]  WITH CHECK ADD  CONSTRAINT [FK_Export_Task_TaskSiteID_CMS_Site] FOREIGN KEY([TaskSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Export_Task] CHECK CONSTRAINT [FK_Export_Task_TaskSiteID_CMS_Site]
GO
