SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_CssStylesheetSite](
	[StylesheetID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_CssStylesheetSite] PRIMARY KEY CLUSTERED 
(
	[StylesheetID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_CssStylesheetSite_SiteID] ON [dbo].[CMS_CssStylesheetSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_CssStylesheetSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_CssStylesheetSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_CssStylesheetSite] CHECK CONSTRAINT [FK_CMS_CssStylesheetSite_SiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_CssStylesheetSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_CssStylesheetSite_StylesheetID_CMS_CssStylesheet] FOREIGN KEY([StylesheetID])
REFERENCES [dbo].[CMS_CssStylesheet] ([StylesheetID])
GO
ALTER TABLE [dbo].[CMS_CssStylesheetSite] CHECK CONSTRAINT [FK_CMS_CssStylesheetSite_StylesheetID_CMS_CssStylesheet]
GO
