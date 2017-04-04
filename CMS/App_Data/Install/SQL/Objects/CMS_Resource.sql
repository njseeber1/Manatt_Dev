SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Resource](
	[ResourceID] [int] IDENTITY(1,1) NOT NULL,
	[ResourceDisplayName] [nvarchar](100) NOT NULL,
	[ResourceName] [nvarchar](100) NOT NULL,
	[ResourceDescription] [nvarchar](max) NULL,
	[ShowInDevelopment] [bit] NULL,
	[ResourceURL] [nvarchar](1000) NULL,
	[ResourceGUID] [uniqueidentifier] NOT NULL,
	[ResourceLastModified] [datetime2](7) NOT NULL,
	[ResourceIsInDevelopment] [bit] NULL,
	[ResourceHasFiles] [bit] NULL,
	[ResourceVersion] [nvarchar](200) NULL,
	[ResourceAuthor] [nvarchar](200) NULL,
	[ResourceInstallationState] [nvarchar](50) NULL,
	[ResourceInstalledVersion] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMS_Resource] PRIMARY KEY NONCLUSTERED 
(
	[ResourceID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Resource_ResourceDisplayName] ON [dbo].[CMS_Resource]
(
	[ResourceDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Resource_ResourceName] ON [dbo].[CMS_Resource]
(
	[ResourceName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Resource] ADD  CONSTRAINT [DEFAULT_CMS_Resource_ShowInDevelopment]  DEFAULT ((0)) FOR [ShowInDevelopment]
GO
ALTER TABLE [dbo].[CMS_Resource] ADD  CONSTRAINT [DEFAULT_CMS_Resource_ResourceHasFiles]  DEFAULT ((0)) FOR [ResourceHasFiles]
GO
ALTER TABLE [dbo].[CMS_Resource] ADD  CONSTRAINT [DEFAULT_CMS_Resource_ResourceInstallationState]  DEFAULT (N'') FOR [ResourceInstallationState]
GO
ALTER TABLE [dbo].[CMS_Resource] ADD  CONSTRAINT [DEFAULT_CMS_Resource_ResourceInstalledVersion]  DEFAULT (N'') FOR [ResourceInstalledVersion]
GO
