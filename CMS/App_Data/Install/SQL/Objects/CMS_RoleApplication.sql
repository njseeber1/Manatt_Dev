SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_RoleApplication](
	[RoleID] [int] NOT NULL,
	[ElementID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_RoleApplication] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[ElementID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_RoleApplication] ON [dbo].[CMS_RoleApplication]
(
	[ElementID] ASC
)
GO
ALTER TABLE [dbo].[CMS_RoleApplication]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RoleApplication_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[CMS_RoleApplication] CHECK CONSTRAINT [FK_CMS_RoleApplication_CMS_Role]
GO
ALTER TABLE [dbo].[CMS_RoleApplication]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RoleApplication_CMS_UIElement] FOREIGN KEY([ElementID])
REFERENCES [dbo].[CMS_UIElement] ([ElementID])
GO
ALTER TABLE [dbo].[CMS_RoleApplication] CHECK CONSTRAINT [FK_CMS_RoleApplication_CMS_UIElement]
GO
