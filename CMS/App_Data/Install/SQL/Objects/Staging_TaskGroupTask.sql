SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_TaskGroupTask](
	[TaskGroupTaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskGroupID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
 CONSTRAINT [PK_staging_TaskGroupTask] PRIMARY KEY CLUSTERED 
(
	[TaskGroupTaskID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Staging_TaskGroupTask_TaskGroupID] ON [dbo].[staging_TaskGroupTask]
(
	[TaskGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_TaskGroupTask_TaskID] ON [dbo].[staging_TaskGroupTask]
(
	[TaskID] ASC
)
GO
ALTER TABLE [dbo].[staging_TaskGroupTask] ADD  CONSTRAINT [DEFAULT_staging_TaskGroupTask_TaskGroupID]  DEFAULT ((0)) FOR [TaskGroupID]
GO
ALTER TABLE [dbo].[staging_TaskGroupTask] ADD  CONSTRAINT [DEFAULT_staging_TaskGroupTask_TaskID]  DEFAULT ((0)) FOR [TaskID]
GO
ALTER TABLE [dbo].[staging_TaskGroupTask]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskGroupTask_Staging_Task] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Staging_Task] ([TaskID])
GO
ALTER TABLE [dbo].[staging_TaskGroupTask] CHECK CONSTRAINT [FK_Staging_TaskGroupTask_Staging_Task]
GO
ALTER TABLE [dbo].[staging_TaskGroupTask]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskGroupTask_Staging_TaskGroup] FOREIGN KEY([TaskGroupID])
REFERENCES [dbo].[staging_TaskGroup] ([TaskGroupID])
GO
ALTER TABLE [dbo].[staging_TaskGroupTask] CHECK CONSTRAINT [FK_Staging_TaskGroupTask_Staging_TaskGroup]
GO
