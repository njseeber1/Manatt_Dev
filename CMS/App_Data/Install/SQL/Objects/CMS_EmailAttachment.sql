SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_EmailAttachment](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentName] [nvarchar](255) NOT NULL,
	[AttachmentExtension] [nvarchar](50) NOT NULL,
	[AttachmentSize] [int] NOT NULL,
	[AttachmentMimeType] [nvarchar](100) NOT NULL,
	[AttachmentBinary] [varbinary](max) NOT NULL,
	[AttachmentGUID] [uniqueidentifier] NOT NULL,
	[AttachmentLastModified] [datetime2](7) NOT NULL,
	[AttachmentContentID] [nvarchar](255) NULL,
	[AttachmentSiteID] [int] NULL,
 CONSTRAINT [PK_CMS_EmailAttachment] PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)
)

GO
