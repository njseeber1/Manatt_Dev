SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_MetaFile](
	[MetaFileID] [int] IDENTITY(1,1) NOT NULL,
	[MetaFileObjectID] [int] NOT NULL,
	[MetaFileObjectType] [nvarchar](100) NOT NULL,
	[MetaFileGroupName] [nvarchar](100) NULL,
	[MetaFileName] [nvarchar](250) NOT NULL,
	[MetaFileExtension] [nvarchar](50) NOT NULL,
	[MetaFileSize] [int] NOT NULL,
	[MetaFileMimeType] [nvarchar](100) NOT NULL,
	[MetaFileBinary] [varbinary](max) NULL,
	[MetaFileImageWidth] [int] NULL,
	[MetaFileImageHeight] [int] NULL,
	[MetaFileGUID] [uniqueidentifier] NOT NULL,
	[MetaFileLastModified] [datetime2](7) NOT NULL,
	[MetaFileSiteID] [int] NULL,
	[MetaFileTitle] [nvarchar](250) NULL,
	[MetaFileDescription] [nvarchar](max) NULL,
	[MetaFileCustomData] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_MetaFile] PRIMARY KEY NONCLUSTERED 
(
	[MetaFileID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] ON [dbo].[CMS_MetaFile]
(
	[MetaFileObjectType] ASC,
	[MetaFileObjectID] ASC,
	[MetaFileGroupName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName] ON [dbo].[CMS_MetaFile]
(
	[MetaFileGUID] ASC,
	[MetaFileSiteID] ASC,
	[MetaFileObjectType] ASC,
	[MetaFileObjectID] ASC,
	[MetaFileGroupName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_MetaFile_MetaFileSiteID] ON [dbo].[CMS_MetaFile]
(
	[MetaFileSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_MetaFile]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_MetaFile_MetaFileSiteID_CMS_Site] FOREIGN KEY([MetaFileSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_MetaFile] CHECK CONSTRAINT [FK_CMS_MetaFile_MetaFileSiteID_CMS_Site]
GO
