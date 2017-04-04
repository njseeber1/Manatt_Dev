SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TagGroup](
	[TagGroupID] [int] IDENTITY(1,1) NOT NULL,
	[TagGroupDisplayName] [nvarchar](250) NOT NULL,
	[TagGroupName] [nvarchar](250) NOT NULL,
	[TagGroupDescription] [nvarchar](max) NULL,
	[TagGroupSiteID] [int] NOT NULL,
	[TagGroupIsAdHoc] [bit] NOT NULL,
	[TagGroupLastModified] [datetime2](7) NOT NULL,
	[TagGroupGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CMS_TagGroup] PRIMARY KEY NONCLUSTERED 
(
	[TagGroupID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_TagGroup_TagGroupDisplayName] ON [dbo].[CMS_TagGroup]
(
	[TagGroupDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_TagGroup_TagGroupSiteID] ON [dbo].[CMS_TagGroup]
(
	[TagGroupSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_TagGroup] ADD  CONSTRAINT [DEFAULT_CMS_TagGroup_TagGroupDisplayName]  DEFAULT ('') FOR [TagGroupDisplayName]
GO
ALTER TABLE [dbo].[CMS_TagGroup] ADD  CONSTRAINT [DEFAULT_CMS_TagGroup_TagGroupName]  DEFAULT ('') FOR [TagGroupName]
GO
ALTER TABLE [dbo].[CMS_TagGroup] ADD  CONSTRAINT [DEFAULT_CMS_TagGroup_TagGroupIsAdHoc]  DEFAULT ((0)) FOR [TagGroupIsAdHoc]
GO
ALTER TABLE [dbo].[CMS_TagGroup]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TagGroup_TagGroupSiteID_CMS_Site] FOREIGN KEY([TagGroupSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_TagGroup] CHECK CONSTRAINT [FK_CMS_TagGroup_TagGroupSiteID_CMS_Site]
GO
