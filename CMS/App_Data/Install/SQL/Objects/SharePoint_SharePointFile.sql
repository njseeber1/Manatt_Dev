SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SharePoint_SharePointFile](
	[SharePointFileID] [int] IDENTITY(1,1) NOT NULL,
	[SharePointFileGUID] [uniqueidentifier] NOT NULL,
	[SharePointFileSiteID] [int] NOT NULL,
	[SharePointFileName] [nvarchar](150) NOT NULL,
	[SharePointFileExtension] [nvarchar](150) NULL,
	[SharePointFileMimeType] [nvarchar](255) NULL,
	[SharePointFileETag] [nvarchar](255) NULL,
	[SharePointFileSize] [bigint] NOT NULL,
	[SharePointFileServerLastModified] [datetime2](7) NOT NULL,
	[SharePointFileServerRelativeURL] [nvarchar](300) NOT NULL,
	[SharePointFileSharePointLibraryID] [int] NOT NULL,
	[SharePointFileBinary] [varbinary](max) NULL,
 CONSTRAINT [PK_SharePoint_SharePointFile] PRIMARY KEY CLUSTERED 
(
	[SharePointFileID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SharePoint_SharePointFile_SharePointFileSiteID] ON [dbo].[SharePoint_SharePointFile]
(
	[SharePointFileSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_SharePoint_SharePointFile_LibraryID_ServerRelativeURL] ON [dbo].[SharePoint_SharePointFile]
(
	[SharePointFileSharePointLibraryID] ASC,
	[SharePointFileServerRelativeURL] ASC
)
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SharePointFileGUID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileSiteID]  DEFAULT ((0)) FOR [SharePointFileSiteID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileName]  DEFAULT (N'') FOR [SharePointFileName]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileExtension]  DEFAULT (N'') FOR [SharePointFileExtension]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileMimeType]  DEFAULT (N'') FOR [SharePointFileMimeType]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileETag]  DEFAULT (N'') FOR [SharePointFileETag]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileSize]  DEFAULT ((0)) FOR [SharePointFileSize]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileServerRelativeURL]  DEFAULT (N'') FOR [SharePointFileServerRelativeURL]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointFile_SharePointFileSharePointLibraryID]  DEFAULT ((0)) FOR [SharePointFileSharePointLibraryID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile]  WITH CHECK ADD  CONSTRAINT [FK_SharePoint_SharePointFile_CMS_Site] FOREIGN KEY([SharePointFileSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] CHECK CONSTRAINT [FK_SharePoint_SharePointFile_CMS_Site]
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile]  WITH CHECK ADD  CONSTRAINT [FK_SharePoint_SharePointFile_SharePoint_SharePointLibrary] FOREIGN KEY([SharePointFileSharePointLibraryID])
REFERENCES [dbo].[SharePoint_SharePointLibrary] ([SharePointLibraryID])
GO
ALTER TABLE [dbo].[SharePoint_SharePointFile] CHECK CONSTRAINT [FK_SharePoint_SharePointFile_SharePoint_SharePointLibrary]
GO
