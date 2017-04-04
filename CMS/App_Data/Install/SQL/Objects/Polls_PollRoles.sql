SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polls_PollRoles](
	[PollID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Polls_PollRoles] PRIMARY KEY CLUSTERED 
(
	[PollID] ASC,
	[RoleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Polls_PollRoles_RoleID] ON [dbo].[Polls_PollRoles]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[Polls_PollRoles]  WITH CHECK ADD  CONSTRAINT [FK_Polls_PollRoles_PollID_Polls_Poll] FOREIGN KEY([PollID])
REFERENCES [dbo].[Polls_Poll] ([PollID])
GO
ALTER TABLE [dbo].[Polls_PollRoles] CHECK CONSTRAINT [FK_Polls_PollRoles_PollID_Polls_Poll]
GO
ALTER TABLE [dbo].[Polls_PollRoles]  WITH CHECK ADD  CONSTRAINT [FK_Polls_PollRoles_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[Polls_PollRoles] CHECK CONSTRAINT [FK_Polls_PollRoles_RoleID_CMS_Role]
GO
