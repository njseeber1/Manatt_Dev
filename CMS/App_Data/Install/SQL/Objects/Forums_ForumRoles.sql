SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_ForumRoles](
	[ForumID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
 CONSTRAINT [PK_Forums_ForumRoles] PRIMARY KEY CLUSTERED 
(
	[ForumID] ASC,
	[RoleID] ASC,
	[PermissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumRoles_PermissionID] ON [dbo].[Forums_ForumRoles]
(
	[PermissionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumRoles_RoleID] ON [dbo].[Forums_ForumRoles]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[Forums_ForumRoles]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumRoles_ForumID_Forums_Forum] FOREIGN KEY([ForumID])
REFERENCES [dbo].[Forums_Forum] ([ForumID])
GO
ALTER TABLE [dbo].[Forums_ForumRoles] CHECK CONSTRAINT [FK_Forums_ForumRoles_ForumID_Forums_Forum]
GO
ALTER TABLE [dbo].[Forums_ForumRoles]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumRoles_PermissionID_CMS_Permission] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[CMS_Permission] ([PermissionID])
GO
ALTER TABLE [dbo].[Forums_ForumRoles] CHECK CONSTRAINT [FK_Forums_ForumRoles_PermissionID_CMS_Permission]
GO
ALTER TABLE [dbo].[Forums_ForumRoles]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumRoles_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[Forums_ForumRoles] CHECK CONSTRAINT [FK_Forums_ForumRoles_RoleID_CMS_Role]
GO
