SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ContactGroup](
	[ContactGroupID] [int] IDENTITY(1,1) NOT NULL,
	[ContactGroupName] [nvarchar](200) NOT NULL,
	[ContactGroupDisplayName] [nvarchar](200) NOT NULL,
	[ContactGroupDescription] [nvarchar](max) NULL,
	[ContactGroupSiteID] [int] NULL,
	[ContactGroupDynamicCondition] [nvarchar](max) NULL,
	[ContactGroupEnabled] [bit] NULL,
	[ContactGroupLastModified] [datetime2](7) NULL,
	[ContactGroupGUID] [uniqueidentifier] NULL,
	[ContactGroupStatus] [int] NULL,
 CONSTRAINT [PK_CMS_ContactGroup] PRIMARY KEY CLUSTERED 
(
	[ContactGroupID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ContactGroup_ContactGroupSiteID] ON [dbo].[OM_ContactGroup]
(
	[ContactGroupSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_ContactGroup] ADD  CONSTRAINT [DEFAULT_OM_ContactGroup_ContactGroupName]  DEFAULT (N'__AUTO__') FOR [ContactGroupName]
GO
ALTER TABLE [dbo].[OM_ContactGroup]  WITH CHECK ADD  CONSTRAINT [FK_OM_ContactGroup_CMS_Site] FOREIGN KEY([ContactGroupSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_ContactGroup] CHECK CONSTRAINT [FK_OM_ContactGroup_CMS_Site]
GO
