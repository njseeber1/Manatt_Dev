SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AttachmentHistory](
	[AttachmentHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentName] [nvarchar](255) NOT NULL,
	[AttachmentExtension] [nvarchar](50) NOT NULL,
	[AttachmentSize] [int] NOT NULL,
	[AttachmentMimeType] [nvarchar](100) NOT NULL,
	[AttachmentBinary] [varbinary](max) NULL,
	[AttachmentImageWidth] [int] NULL,
	[AttachmentImageHeight] [int] NULL,
	[AttachmentDocumentID] [int] NOT NULL,
	[AttachmentGUID] [uniqueidentifier] NOT NULL,
	[AttachmentIsUnsorted] [bit] NULL,
	[AttachmentOrder] [int] NULL,
	[AttachmentGroupGUID] [uniqueidentifier] NULL,
	[AttachmentHash] [nvarchar](32) NULL,
	[AttachmentTitle] [nvarchar](250) NULL,
	[AttachmentDescription] [nvarchar](max) NULL,
	[AttachmentCustomData] [nvarchar](max) NULL,
	[AttachmentLastModified] [datetime2](7) NULL,
	[AttachmentHistoryGUID] [uniqueidentifier] NOT NULL,
	[AttachmentSiteID] [int] NULL,
	[AttachmentSearchContent] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_AttachmentHistory] PRIMARY KEY NONCLUSTERED 
(
	[AttachmentHistoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName] ON [dbo].[CMS_AttachmentHistory]
(
	[AttachmentDocumentID] ASC,
	[AttachmentName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AttachmentHistory_AttachmentGUID] ON [dbo].[CMS_AttachmentHistory]
(
	[AttachmentGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder] ON [dbo].[CMS_AttachmentHistory]
(
	[AttachmentIsUnsorted] ASC,
	[AttachmentGroupGUID] ASC,
	[AttachmentOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AttachmentHistory_AttachmentSiteID] ON [dbo].[CMS_AttachmentHistory]
(
	[AttachmentSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AttachmentHistory] ADD  CONSTRAINT [DEFAULT_CMS_AttachmentHistory_AttachmentHistoryGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [AttachmentHistoryGUID]
GO
ALTER TABLE [dbo].[CMS_AttachmentHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AttachmentHistory_AttachmentSiteID_CMS_Site] FOREIGN KEY([AttachmentSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_AttachmentHistory] CHECK CONSTRAINT [FK_CMS_AttachmentHistory_AttachmentSiteID_CMS_Site]
GO
