SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebFarmTask](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskType] [nvarchar](50) NOT NULL,
	[TaskTextData] [nvarchar](max) NULL,
	[TaskBinaryData] [varbinary](max) NULL,
	[TaskCreated] [datetime2](7) NULL,
	[TaskTarget] [nvarchar](max) NULL,
	[TaskMachineName] [nvarchar](450) NULL,
	[TaskGUID] [uniqueidentifier] NULL,
	[TaskIsAnonymous] [bit] NULL,
	[TaskErrorMessage] [nvarchar](max) NULL,
	[TaskIsMemory] [bit] NULL,
 CONSTRAINT [PK_CMS_WebFarmTask] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebFarmTask_TaskIsMemory] ON [dbo].[CMS_WebFarmTask]
(
	[TaskIsMemory] ASC
)
INCLUDE ( 	[TaskID])
GO
ALTER TABLE [dbo].[CMS_WebFarmTask] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmTask_TaskGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TaskGUID]
GO
ALTER TABLE [dbo].[CMS_WebFarmTask] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmTask_TaskIsMemory]  DEFAULT ((0)) FOR [TaskIsMemory]
GO
