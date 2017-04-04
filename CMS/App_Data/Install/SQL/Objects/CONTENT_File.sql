SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTENT_File](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileDescription] [nvarchar](500) NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[FileAttachment] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)
)

GO
ALTER TABLE [dbo].[CONTENT_File] ADD  CONSTRAINT [DEFAULT_CONTENT_File_FileNames]  DEFAULT ('') FOR [FileName]
GO
