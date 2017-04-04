SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_RolePermission](
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_RolePermission] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[PermissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_RolePermission_PermissionID] ON [dbo].[CMS_RolePermission]
(
	[PermissionID] ASC
)
GO
ALTER TABLE [dbo].[CMS_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RolePermission_PermissionID_CMS_Permission] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[CMS_Permission] ([PermissionID])
GO
ALTER TABLE [dbo].[CMS_RolePermission] CHECK CONSTRAINT [FK_CMS_RolePermission_PermissionID_CMS_Permission]
GO
ALTER TABLE [dbo].[CMS_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RolePermission_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[CMS_RolePermission] CHECK CONSTRAINT [FK_CMS_RolePermission_RoleID_CMS_Role]
GO
