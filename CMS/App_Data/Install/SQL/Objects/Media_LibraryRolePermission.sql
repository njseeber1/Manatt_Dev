SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media_LibraryRolePermission](
	[LibraryID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
 CONSTRAINT [PK_Media_LibraryRolePermission] PRIMARY KEY CLUSTERED 
(
	[LibraryID] ASC,
	[RoleID] ASC,
	[PermissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Media_LibraryRolePermission_PermissionID] ON [dbo].[Media_LibraryRolePermission]
(
	[PermissionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_LibraryRolePermission_RoleID] ON [dbo].[Media_LibraryRolePermission]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_Media_LibraryRolePermission_LibraryID_Media_Library] FOREIGN KEY([LibraryID])
REFERENCES [dbo].[Media_Library] ([LibraryID])
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission] CHECK CONSTRAINT [FK_Media_LibraryRolePermission_LibraryID_Media_Library]
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_Media_LibraryRolePermission_PermissionID_CMS_Permission] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[CMS_Permission] ([PermissionID])
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission] CHECK CONSTRAINT [FK_Media_LibraryRolePermission_PermissionID_CMS_Permission]
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_Media_LibraryRolePermission_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[Media_LibraryRolePermission] CHECK CONSTRAINT [FK_Media_LibraryRolePermission_RoleID_CMS_Role]
GO
