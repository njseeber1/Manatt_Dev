SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media_File](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[FileTitle] [nvarchar](250) NOT NULL,
	[FileDescription] [nvarchar](max) NOT NULL,
	[FileExtension] [nvarchar](50) NOT NULL,
	[FileMimeType] [nvarchar](100) NOT NULL,
	[FilePath] [nvarchar](450) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[FileImageWidth] [int] NULL,
	[FileImageHeight] [int] NULL,
	[FileGUID] [uniqueidentifier] NOT NULL,
	[FileLibraryID] [int] NOT NULL,
	[FileSiteID] [int] NOT NULL,
	[FileCreatedByUserID] [int] NULL,
	[FileCreatedWhen] [datetime2](7) NOT NULL,
	[FileModifiedByUserID] [int] NULL,
	[FileModifiedWhen] [datetime2](7) NOT NULL,
	[FileCustomData] [nvarchar](max) NULL,
 CONSTRAINT [PK_Media_File] PRIMARY KEY NONCLUSTERED 
(
	[FileID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Media_File_FilePath] ON [dbo].[Media_File]
(
	[FilePath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_File_FileCreatedByUserID] ON [dbo].[Media_File]
(
	[FileCreatedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_File_FileLibraryID] ON [dbo].[Media_File]
(
	[FileLibraryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_File_FileModifiedByUserID] ON [dbo].[Media_File]
(
	[FileModifiedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_File_FileSiteID_FileGUID] ON [dbo].[Media_File]
(
	[FileSiteID] ASC,
	[FileGUID] ASC
)
GO
ALTER TABLE [dbo].[Media_File] ADD  CONSTRAINT [DEFAULT_Media_File_FileTitle]  DEFAULT ('') FOR [FileTitle]
GO
ALTER TABLE [dbo].[Media_File] ADD  CONSTRAINT [DEFAULT_Media_File_FileSize]  DEFAULT ((0)) FOR [FileSize]
GO
ALTER TABLE [dbo].[Media_File] ADD  CONSTRAINT [DEFAULT_Media_File_FileCreatedWhen]  DEFAULT ('11/11/2008 4:10:00 PM') FOR [FileCreatedWhen]
GO
ALTER TABLE [dbo].[Media_File] ADD  CONSTRAINT [DEFAULT_Media_File_FileModifiedWhen]  DEFAULT ('11/11/2008 4:11:15 PM') FOR [FileModifiedWhen]
GO
ALTER TABLE [dbo].[Media_File]  WITH CHECK ADD  CONSTRAINT [FK_Media_File_FileCreatedByUserID_CMS_User] FOREIGN KEY([FileCreatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Media_File] CHECK CONSTRAINT [FK_Media_File_FileCreatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Media_File]  WITH CHECK ADD  CONSTRAINT [FK_Media_File_FileLibraryID_Media_Library] FOREIGN KEY([FileLibraryID])
REFERENCES [dbo].[Media_Library] ([LibraryID])
GO
ALTER TABLE [dbo].[Media_File] CHECK CONSTRAINT [FK_Media_File_FileLibraryID_Media_Library]
GO
ALTER TABLE [dbo].[Media_File]  WITH CHECK ADD  CONSTRAINT [FK_Media_File_FileModifiedByUserID_CMS_User] FOREIGN KEY([FileModifiedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Media_File] CHECK CONSTRAINT [FK_Media_File_FileModifiedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Media_File]  WITH CHECK ADD  CONSTRAINT [FK_Media_File_FileSiteID_CMS_Site] FOREIGN KEY([FileSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Media_File] CHECK CONSTRAINT [FK_Media_File_FileSiteID_CMS_Site]
GO
