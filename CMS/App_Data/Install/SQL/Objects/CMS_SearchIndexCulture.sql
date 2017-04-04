SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SearchIndexCulture](
	[IndexID] [int] NOT NULL,
	[IndexCultureID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_SearchIndexCulture] PRIMARY KEY CLUSTERED 
(
	[IndexID] ASC,
	[IndexCultureID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_SearchIndexCulture_IndexCultureID] ON [dbo].[CMS_SearchIndexCulture]
(
	[IndexCultureID] ASC
)
GO
ALTER TABLE [dbo].[CMS_SearchIndexCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SearchIndexCulture_IndexCultureID_CMS_Culture] FOREIGN KEY([IndexCultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_SearchIndexCulture] CHECK CONSTRAINT [FK_CMS_SearchIndexCulture_IndexCultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_SearchIndexCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SearchIndexCulture_IndexID_CMS_SearchIndex] FOREIGN KEY([IndexID])
REFERENCES [dbo].[CMS_SearchIndex] ([IndexID])
GO
ALTER TABLE [dbo].[CMS_SearchIndexCulture] CHECK CONSTRAINT [FK_CMS_SearchIndexCulture_IndexID_CMS_SearchIndex]
GO
