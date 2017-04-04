SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebFarmServer](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[ServerDisplayName] [nvarchar](300) NOT NULL,
	[ServerName] [nvarchar](300) NOT NULL,
	[ServerGUID] [uniqueidentifier] NULL,
	[ServerLastModified] [datetime2](7) NOT NULL,
	[ServerEnabled] [bit] NULL,
 CONSTRAINT [PK_CMS_WebFarmServer] PRIMARY KEY NONCLUSTERED 
(
	[ServerID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_WebFarmServer_ServerDisplayName] ON [dbo].[CMS_WebFarmServer]
(
	[ServerDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_WebFarmServer_ServerName] ON [dbo].[CMS_WebFarmServer]
(
	[ServerName] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebFarmServer] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServer_ServerDisplayName]  DEFAULT (N'') FOR [ServerDisplayName]
GO
ALTER TABLE [dbo].[CMS_WebFarmServer] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServer_ServerName]  DEFAULT (N'') FOR [ServerName]
GO
ALTER TABLE [dbo].[CMS_WebFarmServer] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServer_ServerLastModified]  DEFAULT ('9/17/2013 12:18:06 PM') FOR [ServerLastModified]
GO
ALTER TABLE [dbo].[CMS_WebFarmServer] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServer_ServerEnabled]  DEFAULT ((0)) FOR [ServerEnabled]
GO
