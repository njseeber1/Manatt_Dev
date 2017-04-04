SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SearchIndexSite](
	[IndexID] [int] NOT NULL,
	[IndexSiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_SearchIndexSite] PRIMARY KEY CLUSTERED 
(
	[IndexID] ASC,
	[IndexSiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_SearchIndexSite_IndexSiteID] ON [dbo].[CMS_SearchIndexSite]
(
	[IndexSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_SearchIndexSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SearchIndexSite_IndexID_CMS_SearchIndex] FOREIGN KEY([IndexID])
REFERENCES [dbo].[CMS_SearchIndex] ([IndexID])
GO
ALTER TABLE [dbo].[CMS_SearchIndexSite] CHECK CONSTRAINT [FK_CMS_SearchIndexSite_IndexID_CMS_SearchIndex]
GO
ALTER TABLE [dbo].[CMS_SearchIndexSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SearchIndexSite_IndexSiteID_CMS_Site] FOREIGN KEY([IndexSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_SearchIndexSite] CHECK CONSTRAINT [FK_CMS_SearchIndexSite_IndexSiteID_CMS_Site]
GO
