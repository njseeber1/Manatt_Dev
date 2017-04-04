SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_PageTemplateSite](
	[PageTemplateID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_PageTemplateSite] PRIMARY KEY CLUSTERED 
(
	[PageTemplateID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateSite_SiteID] ON [dbo].[CMS_PageTemplateSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_PageTemplateSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateSite_PageTemplateID_CMS_PageTemplate] FOREIGN KEY([PageTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateSite] CHECK CONSTRAINT [FK_CMS_PageTemplateSite_PageTemplateID_CMS_PageTemplate]
GO
ALTER TABLE [dbo].[CMS_PageTemplateSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateSite] CHECK CONSTRAINT [FK_CMS_PageTemplateSite_SiteID_CMS_Site]
GO
