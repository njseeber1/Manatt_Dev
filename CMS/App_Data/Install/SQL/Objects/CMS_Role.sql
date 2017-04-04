SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleDisplayName] [nvarchar](100) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[RoleDescription] [nvarchar](max) NULL,
	[SiteID] [int] NULL,
	[RoleGUID] [uniqueidentifier] NOT NULL,
	[RoleLastModified] [datetime2](7) NOT NULL,
	[RoleGroupID] [int] NULL,
	[RoleIsGroupAdministrator] [bit] NULL,
	[RoleIsDomain] [bit] NULL,
 CONSTRAINT [PK_CMS_Role] PRIMARY KEY NONCLUSTERED 
(
	[RoleID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Role_SiteID_RoleName_RoleDisplayName] ON [dbo].[CMS_Role]
(
	[SiteID] ASC,
	[RoleName] ASC,
	[RoleDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Role_RoleGroupID] ON [dbo].[CMS_Role]
(
	[RoleGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Role_SiteID_RoleID] ON [dbo].[CMS_Role]
(
	[SiteID] ASC,
	[RoleID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_Role_SiteID_RoleName_RoleGroupID] ON [dbo].[CMS_Role]
(
	[SiteID] ASC,
	[RoleName] ASC,
	[RoleGroupID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Role]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Role_RoleGroupID_Community_Group] FOREIGN KEY([RoleGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[CMS_Role] CHECK CONSTRAINT [FK_CMS_Role_RoleGroupID_Community_Group]
GO
ALTER TABLE [dbo].[CMS_Role]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Role_SiteID_CMS_SiteID] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Role] CHECK CONSTRAINT [FK_CMS_Role_SiteID_CMS_SiteID]
GO
