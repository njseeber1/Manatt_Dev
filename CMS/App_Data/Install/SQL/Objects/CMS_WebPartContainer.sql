SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebPartContainer](
	[ContainerID] [int] IDENTITY(1,1) NOT NULL,
	[ContainerDisplayName] [nvarchar](200) NOT NULL,
	[ContainerName] [nvarchar](200) NOT NULL,
	[ContainerTextBefore] [nvarchar](max) NULL,
	[ContainerTextAfter] [nvarchar](max) NULL,
	[ContainerGUID] [uniqueidentifier] NOT NULL,
	[ContainerLastModified] [datetime2](7) NOT NULL,
	[ContainerCSS] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_WebPartContainer] PRIMARY KEY NONCLUSTERED 
(
	[ContainerID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_WebPartContainer_ContainerDisplayName] ON [dbo].[CMS_WebPartContainer]
(
	[ContainerDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartContainer_ContainerName] ON [dbo].[CMS_WebPartContainer]
(
	[ContainerName] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebPartContainer] ADD  CONSTRAINT [DEFAULT_CMS_WebPartContainer_ContainerDisplayName]  DEFAULT ('') FOR [ContainerDisplayName]
GO
ALTER TABLE [dbo].[CMS_WebPartContainer] ADD  CONSTRAINT [DEFAULT_CMS_WebPartContainer_ContainerName]  DEFAULT ('') FOR [ContainerName]
GO
