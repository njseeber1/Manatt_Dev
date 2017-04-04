SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ResourceLibrary](
	[ResourceLibraryID] [int] IDENTITY(1,1) NOT NULL,
	[ResourceLibraryResourceID] [int] NOT NULL,
	[ResourceLibraryPath] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_CMS_ResourceLibrary] PRIMARY KEY CLUSTERED 
(
	[ResourceLibraryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceLibrary] ON [dbo].[CMS_ResourceLibrary]
(
	[ResourceLibraryResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ResourceLibrary] ADD  CONSTRAINT [DEFAULT_CMS_ResourceLibrary_ResourceLibraryResourceID]  DEFAULT ((0)) FOR [ResourceLibraryResourceID]
GO
ALTER TABLE [dbo].[CMS_ResourceLibrary] ADD  CONSTRAINT [DEFAULT_CMS_ResourceLibrary_ResourceLibraryPath]  DEFAULT (N'') FOR [ResourceLibraryPath]
GO
ALTER TABLE [dbo].[CMS_ResourceLibrary]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ResourceLibrary_CMS_Resource] FOREIGN KEY([ResourceLibraryResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_ResourceLibrary] CHECK CONSTRAINT [FK_CMS_ResourceLibrary_CMS_Resource]
GO
