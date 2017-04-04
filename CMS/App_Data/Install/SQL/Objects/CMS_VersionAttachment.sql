SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_VersionAttachment](
	[VersionHistoryID] [int] NOT NULL,
	[AttachmentHistoryID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_VersionAttachment] PRIMARY KEY CLUSTERED 
(
	[VersionHistoryID] ASC,
	[AttachmentHistoryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionAttachment_AttachmentHistoryID] ON [dbo].[CMS_VersionAttachment]
(
	[AttachmentHistoryID] ASC
)
GO
ALTER TABLE [dbo].[CMS_VersionAttachment]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionAttachment_AttachmentHistoryID_CMS_AttachmentHistory] FOREIGN KEY([AttachmentHistoryID])
REFERENCES [dbo].[CMS_AttachmentHistory] ([AttachmentHistoryID])
GO
ALTER TABLE [dbo].[CMS_VersionAttachment] CHECK CONSTRAINT [FK_CMS_VersionAttachment_AttachmentHistoryID_CMS_AttachmentHistory]
GO
ALTER TABLE [dbo].[CMS_VersionAttachment]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionAttachment_VersionHistoryID_CMS_VersionHistory] FOREIGN KEY([VersionHistoryID])
REFERENCES [dbo].[CMS_VersionHistory] ([VersionHistoryID])
GO
ALTER TABLE [dbo].[CMS_VersionAttachment] CHECK CONSTRAINT [FK_CMS_VersionAttachment_VersionHistoryID_CMS_VersionHistory]
GO
