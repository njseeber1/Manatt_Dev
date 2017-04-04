SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Attachment](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentFileName] [nvarchar](200) NOT NULL,
	[AttachmentFileExtension] [nvarchar](10) NOT NULL,
	[AttachmentBinary] [varbinary](max) NULL,
	[AttachmentGUID] [uniqueidentifier] NOT NULL,
	[AttachmentLastModified] [datetime2](7) NOT NULL,
	[AttachmentMimeType] [nvarchar](100) NOT NULL,
	[AttachmentFileSize] [int] NOT NULL,
	[AttachmentImageHeight] [int] NULL,
	[AttachmentImageWidth] [int] NULL,
	[AttachmentPostID] [int] NOT NULL,
	[AttachmentSiteID] [int] NOT NULL,
 CONSTRAINT [PK_Forums_Attachment] PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Forums_Attachment_AttachmentGUID] ON [dbo].[Forums_Attachment]
(
	[AttachmentSiteID] ASC,
	[AttachmentGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_Attachment_AttachmentPostID] ON [dbo].[Forums_Attachment]
(
	[AttachmentPostID] ASC
)
GO
ALTER TABLE [dbo].[Forums_Attachment] ADD  CONSTRAINT [DEFAULT_Forums_Attachment_AttachmentPostID]  DEFAULT ((0)) FOR [AttachmentPostID]
GO
ALTER TABLE [dbo].[Forums_Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Attachment_AttachmentPostID_Forums_ForumPost] FOREIGN KEY([AttachmentPostID])
REFERENCES [dbo].[Forums_ForumPost] ([PostId])
GO
ALTER TABLE [dbo].[Forums_Attachment] CHECK CONSTRAINT [FK_Forums_Attachment_AttachmentPostID_Forums_ForumPost]
GO
ALTER TABLE [dbo].[Forums_Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Attachment_AttachmentSiteID_CMS_Site] FOREIGN KEY([AttachmentSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Forums_Attachment] CHECK CONSTRAINT [FK_Forums_Attachment_AttachmentSiteID_CMS_Site]
GO
