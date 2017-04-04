SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_TaskGroupUser](
	[TaskGroupUserID] [int] IDENTITY(1,1) NOT NULL,
	[TaskGroupID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_staging_TaskGroupUser] PRIMARY KEY CLUSTERED 
(
	[TaskGroupUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Staging_TaskGroupUser_TaskGroup_ID] ON [dbo].[staging_TaskGroupUser]
(
	[TaskGroupID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Staging_TaskGroupUser_UserID] ON [dbo].[staging_TaskGroupUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[staging_TaskGroupUser] ADD  CONSTRAINT [DEFAULT_staging_TaskGroupUser_TaskGroupID]  DEFAULT ((0)) FOR [TaskGroupID]
GO
ALTER TABLE [dbo].[staging_TaskGroupUser] ADD  CONSTRAINT [DEFAULT_staging_TaskGroupUser_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[staging_TaskGroupUser]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskGroupUser_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[staging_TaskGroupUser] CHECK CONSTRAINT [FK_Staging_TaskGroupUser_CMS_User]
GO
ALTER TABLE [dbo].[staging_TaskGroupUser]  WITH CHECK ADD  CONSTRAINT [FK_Staging_TaskGroupUser_Staging_TaskGroup] FOREIGN KEY([TaskGroupID])
REFERENCES [dbo].[staging_TaskGroup] ([TaskGroupID])
GO
ALTER TABLE [dbo].[staging_TaskGroupUser] CHECK CONSTRAINT [FK_Staging_TaskGroupUser_Staging_TaskGroup]
GO
