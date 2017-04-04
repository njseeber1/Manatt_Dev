SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WidgetRole](
	[WidgetID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_WidgetRole] PRIMARY KEY CLUSTERED 
(
	[WidgetID] ASC,
	[RoleID] ASC,
	[PermissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WidgetRole_PermissionID] ON [dbo].[CMS_WidgetRole]
(
	[PermissionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WidgetRole_RoleID] ON [dbo].[CMS_WidgetRole]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WidgetRole]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WidgetRole_PermissionID_CMS_Permission] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[CMS_Permission] ([PermissionID])
GO
ALTER TABLE [dbo].[CMS_WidgetRole] CHECK CONSTRAINT [FK_CMS_WidgetRole_PermissionID_CMS_Permission]
GO
ALTER TABLE [dbo].[CMS_WidgetRole]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WidgetRole_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[CMS_WidgetRole] CHECK CONSTRAINT [FK_CMS_WidgetRole_RoleID_CMS_Role]
GO
ALTER TABLE [dbo].[CMS_WidgetRole]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WidgetRole_WidgetID_CMS_Widget] FOREIGN KEY([WidgetID])
REFERENCES [dbo].[CMS_Widget] ([WidgetID])
GO
ALTER TABLE [dbo].[CMS_WidgetRole] CHECK CONSTRAINT [FK_CMS_WidgetRole_WidgetID_CMS_Widget]
GO
