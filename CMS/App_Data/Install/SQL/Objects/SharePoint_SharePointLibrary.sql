SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SharePoint_SharePointLibrary](
	[SharePointLibraryID] [int] IDENTITY(1,1) NOT NULL,
	[SharePointLibraryName] [nvarchar](100) NOT NULL,
	[SharePointLibrarySharePointConnectionID] [int] NULL,
	[SharePointLibraryListTitle] [nvarchar](100) NOT NULL,
	[SharePointLibrarySynchronizationPeriod] [int] NOT NULL,
	[SharePointLibraryGUID] [uniqueidentifier] NOT NULL,
	[SharePointLibrarySiteID] [int] NOT NULL,
	[SharePointLibraryDisplayName] [nvarchar](100) NOT NULL,
	[SharePointLibraryLastModified] [datetime2](7) NOT NULL,
	[SharePointLibraryListType] [int] NOT NULL,
 CONSTRAINT [PK_SharePoint_SharePointLibrary] PRIMARY KEY CLUSTERED 
(
	[SharePointLibraryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SharePoint_SharePointLibrary_SharePointLibrarySharepointConnectionID] ON [dbo].[SharePoint_SharePointLibrary]
(
	[SharePointLibrarySharePointConnectionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SharePoint_SharePointLibrary_SharePointlibrarySiteID] ON [dbo].[SharePoint_SharePointLibrary]
(
	[SharePointLibrarySiteID] ASC
)
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryName]  DEFAULT (N'') FOR [SharePointLibraryName]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibrarySharepointConnectionID]  DEFAULT ((0)) FOR [SharePointLibrarySharePointConnectionID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryListTitle]  DEFAULT (N'') FOR [SharePointLibraryListTitle]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibrarySynchronizationPeriod]  DEFAULT ((720)) FOR [SharePointLibrarySynchronizationPeriod]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SharePointLibraryGUID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibrarySiteID]  DEFAULT ((0)) FOR [SharePointLibrarySiteID]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryDisplayName]  DEFAULT (N'') FOR [SharePointLibraryDisplayName]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryLastModified]  DEFAULT ('10/3/2014 2:45:04 PM') FOR [SharePointLibraryLastModified]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointLibrary_SharePointLibraryListType]  DEFAULT ((0)) FOR [SharePointLibraryListType]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary]  WITH CHECK ADD  CONSTRAINT [FK_SharePoint_SharePointLibrary_CMS_Site] FOREIGN KEY([SharePointLibrarySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] CHECK CONSTRAINT [FK_SharePoint_SharePointLibrary_CMS_Site]
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary]  WITH CHECK ADD  CONSTRAINT [FK_SharePoint_SharePointLibrary_SharePoint_SharePointConnection] FOREIGN KEY([SharePointLibrarySharePointConnectionID])
REFERENCES [dbo].[SharePoint_SharePointConnection] ([SharePointConnectionID])
GO
ALTER TABLE [dbo].[SharePoint_SharePointLibrary] CHECK CONSTRAINT [FK_SharePoint_SharePointLibrary_SharePoint_SharePointConnection]
GO
