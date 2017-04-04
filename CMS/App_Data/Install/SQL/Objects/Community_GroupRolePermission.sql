SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community_GroupRolePermission](
	[GroupID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
 CONSTRAINT [PK_Community_GroupRolePermission] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC,
	[RoleID] ASC,
	[PermissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupRolePermission_PermissionID] ON [dbo].[Community_GroupRolePermission]
(
	[PermissionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupRolePermission_RoleID] ON [dbo].[Community_GroupRolePermission]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[Community_GroupRolePermission] ADD  CONSTRAINT [DEFAULT_community_GroupRolePermission_RoleID]  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[Community_GroupRolePermission] ADD  CONSTRAINT [DEFAULT_community_GroupRolePermission_PermissionID]  DEFAULT ((0)) FOR [PermissionID]
GO
ALTER TABLE [dbo].[Community_GroupRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_community_GroupRolePermission_GroupID_Community_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Community_GroupRolePermission] CHECK CONSTRAINT [FK_community_GroupRolePermission_GroupID_Community_Group]
GO
ALTER TABLE [dbo].[Community_GroupRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_community_GroupRolePermission_PermissionID_CMS_Permission] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[CMS_Permission] ([PermissionID])
GO
ALTER TABLE [dbo].[Community_GroupRolePermission] CHECK CONSTRAINT [FK_community_GroupRolePermission_PermissionID_CMS_Permission]
GO
ALTER TABLE [dbo].[Community_GroupRolePermission]  WITH CHECK ADD  CONSTRAINT [FK_community_GroupRolePermission_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[Community_GroupRolePermission] CHECK CONSTRAINT [FK_community_GroupRolePermission_RoleID_CMS_Role]
GO
