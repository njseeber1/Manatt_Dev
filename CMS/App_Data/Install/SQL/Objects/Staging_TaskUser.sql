SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_TaskUser](
	[TaskUserID] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Staging_TaskUser] PRIMARY KEY CLUSTERED 
(
	[TaskUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Staging_TaskUser_TaskID] ON [dbo].[Staging_TaskUser]
(
	[TaskID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_TaskUser_UserID] ON [dbo].[Staging_TaskUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[Staging_TaskUser] ADD  CONSTRAINT [DEFAULT_Staging_TaskUser_TaskID]  DEFAULT ((0)) FOR [TaskID]
GO
ALTER TABLE [dbo].[Staging_TaskUser] ADD  CONSTRAINT [DEFAULT_Staging_TaskUser_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[Staging_TaskUser]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskUser_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Staging_TaskUser] CHECK CONSTRAINT [FK_Staging_TaskUser_CMS_User]
GO
ALTER TABLE [dbo].[Staging_TaskUser]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskUser_StagingTask] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Staging_Task] ([TaskID])
GO
ALTER TABLE [dbo].[Staging_TaskUser] CHECK CONSTRAINT [FK_Staging_TaskUser_StagingTask]
GO
