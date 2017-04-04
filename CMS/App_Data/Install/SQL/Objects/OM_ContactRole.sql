SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ContactRole](
	[ContactRoleID] [int] IDENTITY(1,1) NOT NULL,
	[ContactRoleName] [nvarchar](200) NOT NULL,
	[ContactRoleDisplayName] [nvarchar](200) NOT NULL,
	[ContactRoleDescription] [nvarchar](max) NULL,
	[ContactRoleSiteID] [int] NULL,
 CONSTRAINT [PK_OM_ContactRole] PRIMARY KEY CLUSTERED 
(
	[ContactRoleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ContactRole_ContactRoleSiteID] ON [dbo].[OM_ContactRole]
(
	[ContactRoleSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_ContactRole] ADD  CONSTRAINT [DEFAULT_OM_ContactRole_ContactRoleName]  DEFAULT ('') FOR [ContactRoleName]
GO
ALTER TABLE [dbo].[OM_ContactRole] ADD  CONSTRAINT [DEFAULT_OM_ContactRole_ContactRoleDisplayName]  DEFAULT ('') FOR [ContactRoleDisplayName]
GO
ALTER TABLE [dbo].[OM_ContactRole]  WITH CHECK ADD  CONSTRAINT [FK_OM_ContactRole_CMS_Site] FOREIGN KEY([ContactRoleSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_ContactRole] CHECK CONSTRAINT [FK_OM_ContactRole_CMS_Site]
GO
