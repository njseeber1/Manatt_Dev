SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DocumentCategory](
	[DocumentID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_DocumentCategory] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC,
	[CategoryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentCategory_CategoryID] ON [dbo].[CMS_DocumentCategory]
(
	[CategoryID] ASC
)
GO
ALTER TABLE [dbo].[CMS_DocumentCategory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentCategory_CategoryID_CMS_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CMS_Category] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_DocumentCategory] CHECK CONSTRAINT [FK_CMS_DocumentCategory_CategoryID_CMS_Category]
GO
ALTER TABLE [dbo].[CMS_DocumentCategory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentCategory_DocumentID_CMS_Document] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[CMS_DocumentCategory] CHECK CONSTRAINT [FK_CMS_DocumentCategory_DocumentID_CMS_Document]
GO
