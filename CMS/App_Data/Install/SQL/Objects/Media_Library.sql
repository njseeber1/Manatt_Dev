SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media_Library](
	[LibraryID] [int] IDENTITY(1,1) NOT NULL,
	[LibraryName] [nvarchar](250) NOT NULL,
	[LibraryDisplayName] [nvarchar](250) NOT NULL,
	[LibraryDescription] [nvarchar](max) NULL,
	[LibraryFolder] [nvarchar](250) NOT NULL,
	[LibraryAccess] [int] NULL,
	[LibraryGroupID] [int] NULL,
	[LibrarySiteID] [int] NOT NULL,
	[LibraryGUID] [uniqueidentifier] NULL,
	[LibraryLastModified] [datetime2](7) NULL,
	[LibraryTeaserPath] [nvarchar](450) NULL,
	[LibraryTeaserGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Media_Library] PRIMARY KEY NONCLUSTERED 
(
	[LibraryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Media_Library_LibraryDisplayName] ON [dbo].[Media_Library]
(
	[LibrarySiteID] ASC,
	[LibraryDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Media_Library_LibraryGroupID] ON [dbo].[Media_Library]
(
	[LibraryGroupID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID] ON [dbo].[Media_Library]
(
	[LibrarySiteID] ASC,
	[LibraryName] ASC,
	[LibraryGUID] ASC
)
GO
ALTER TABLE [dbo].[Media_Library] ADD  CONSTRAINT [DEFAULT_Media_Library_LibraryName]  DEFAULT (N'') FOR [LibraryName]
GO
ALTER TABLE [dbo].[Media_Library]  WITH CHECK ADD  CONSTRAINT [FK_Media_Library_LibraryGroupID_Community_Group] FOREIGN KEY([LibraryGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Media_Library] CHECK CONSTRAINT [FK_Media_Library_LibraryGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Media_Library]  WITH CHECK ADD  CONSTRAINT [FK_Media_Library_LibrarySiteID_CMS_Site] FOREIGN KEY([LibrarySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Media_Library] CHECK CONSTRAINT [FK_Media_Library_LibrarySiteID_CMS_Site]
GO
