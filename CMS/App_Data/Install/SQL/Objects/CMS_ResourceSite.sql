SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ResourceSite](
	[ResourceID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_ResourceSite] PRIMARY KEY CLUSTERED 
(
	[ResourceID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceSite_SiteID] ON [dbo].[CMS_ResourceSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ResourceSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ResourceSite_ResourceID_CMS_Resource] FOREIGN KEY([ResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_ResourceSite] CHECK CONSTRAINT [FK_CMS_ResourceSite_ResourceID_CMS_Resource]
GO
ALTER TABLE [dbo].[CMS_ResourceSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ResourceSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_ResourceSite] CHECK CONSTRAINT [FK_CMS_ResourceSite_SiteID_CMS_Site]
GO
