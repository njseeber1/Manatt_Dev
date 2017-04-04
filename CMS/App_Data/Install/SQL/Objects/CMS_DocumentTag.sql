SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DocumentTag](
	[DocumentID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_DocumentTag] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC,
	[TagID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentTag_TagID] ON [dbo].[CMS_DocumentTag]
(
	[TagID] ASC
)
GO
ALTER TABLE [dbo].[CMS_DocumentTag]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentTag_DocumentID_CMS_Document] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[CMS_DocumentTag] CHECK CONSTRAINT [FK_CMS_DocumentTag_DocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[CMS_DocumentTag]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentTag_TagID_CMS_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[CMS_Tag] ([TagID])
GO
ALTER TABLE [dbo].[CMS_DocumentTag] CHECK CONSTRAINT [FK_CMS_DocumentTag_TagID_CMS_Tag]
GO
