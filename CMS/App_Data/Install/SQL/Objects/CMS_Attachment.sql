SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Attachment](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentName] [nvarchar](255) NOT NULL,
	[AttachmentExtension] [nvarchar](50) NOT NULL,
	[AttachmentSize] [int] NOT NULL,
	[AttachmentMimeType] [nvarchar](100) NOT NULL,
	[AttachmentBinary] [varbinary](max) NULL,
	[AttachmentImageWidth] [int] NULL,
	[AttachmentImageHeight] [int] NULL,
	[AttachmentDocumentID] [int] NULL,
	[AttachmentGUID] [uniqueidentifier] NOT NULL,
	[AttachmentLastHistoryID] [int] NULL,
	[AttachmentSiteID] [int] NULL,
	[AttachmentLastModified] [datetime2](7) NOT NULL,
	[AttachmentIsUnsorted] [bit] NULL,
	[AttachmentOrder] [int] NULL,
	[AttachmentGroupGUID] [uniqueidentifier] NULL,
	[AttachmentFormGUID] [uniqueidentifier] NULL,
	[AttachmentHash] [nvarchar](32) NULL,
	[AttachmentTitle] [nvarchar](250) NULL,
	[AttachmentDescription] [nvarchar](max) NULL,
	[AttachmentCustomData] [nvarchar](max) NULL,
	[AttachmentSearchContent] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_Attachment] PRIMARY KEY NONCLUSTERED 
(
	[AttachmentID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder] ON [dbo].[CMS_Attachment]
(
	[AttachmentDocumentID] ASC,
	[AttachmentName] ASC,
	[AttachmentIsUnsorted] ASC,
	[AttachmentOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentDocumentID] ON [dbo].[CMS_Attachment]
(
	[AttachmentDocumentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID] ON [dbo].[CMS_Attachment]
(
	[AttachmentGUID] ASC,
	[AttachmentSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder] ON [dbo].[CMS_Attachment]
(
	[AttachmentIsUnsorted] ASC,
	[AttachmentGroupGUID] ASC,
	[AttachmentFormGUID] ASC,
	[AttachmentOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentSiteID] ON [dbo].[CMS_Attachment]
(
	[AttachmentSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Attachment]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Attachment_AttachmentDocumentID_CMS_Document] FOREIGN KEY([AttachmentDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[CMS_Attachment] CHECK CONSTRAINT [FK_CMS_Attachment_AttachmentDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[CMS_Attachment]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Attachment_AttachmentSiteID_CMS_Site] FOREIGN KEY([AttachmentSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Attachment] CHECK CONSTRAINT [FK_CMS_Attachment_AttachmentSiteID_CMS_Site]
GO
