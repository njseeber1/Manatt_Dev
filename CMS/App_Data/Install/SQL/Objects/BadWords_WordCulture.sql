SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BadWords_WordCulture](
	[WordID] [int] NOT NULL,
	[CultureID] [int] NOT NULL,
 CONSTRAINT [PK_BadWords_WordCulture] PRIMARY KEY CLUSTERED 
(
	[WordID] ASC,
	[CultureID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_BadWords_WordCulture_CultureID] ON [dbo].[BadWords_WordCulture]
(
	[CultureID] ASC
)
GO
ALTER TABLE [dbo].[BadWords_WordCulture]  WITH NOCHECK ADD  CONSTRAINT [FK_BadWords_WordCulture_CultureID_CMS_Culture] FOREIGN KEY([CultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[BadWords_WordCulture] CHECK CONSTRAINT [FK_BadWords_WordCulture_CultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[BadWords_WordCulture]  WITH NOCHECK ADD  CONSTRAINT [FK_BadWords_WordCulture_WordID_BadWords_Word] FOREIGN KEY([WordID])
REFERENCES [dbo].[BadWords_Word] ([WordID])
GO
ALTER TABLE [dbo].[BadWords_WordCulture] CHECK CONSTRAINT [FK_BadWords_WordCulture_WordID_BadWords_Word]
GO
