SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SiteCulture](
	[SiteID] [int] NOT NULL,
	[CultureID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_SiteCulture] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[CultureID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_SiteCulture_CultureID] ON [dbo].[CMS_SiteCulture]
(
	[CultureID] ASC
)
GO
ALTER TABLE [dbo].[CMS_SiteCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SiteCulture_CultureID_CMS_Culture] FOREIGN KEY([CultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_SiteCulture] CHECK CONSTRAINT [FK_CMS_SiteCulture_CultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_SiteCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SiteCulture_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_SiteCulture] CHECK CONSTRAINT [FK_CMS_SiteCulture_SiteID_CMS_Site]
GO
