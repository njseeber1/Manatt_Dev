SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CI_FileMetadata](
	[FileMetadataID] [int] IDENTITY(1,1) NOT NULL,
	[FileLocation] [nvarchar](260) NOT NULL,
	[FileHash] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_CI_FileMetadata] PRIMARY KEY CLUSTERED 
(
	[FileMetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_CI_FileMetadata_FileLocation] UNIQUE NONCLUSTERED 
(
	[FileLocation] ASC
)
)

GO
ALTER TABLE [dbo].[CI_FileMetadata] ADD  CONSTRAINT [DEFAULT_CI_FileMetadata_FileLocation]  DEFAULT (N'') FOR [FileLocation]
GO
ALTER TABLE [dbo].[CI_FileMetadata] ADD  CONSTRAINT [DEFAULT_CI_FileMetadata_FileHash]  DEFAULT (N'') FOR [FileHash]
GO
