SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Server](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](100) NOT NULL,
	[ServerDisplayName] [nvarchar](440) NOT NULL,
	[ServerSiteID] [int] NOT NULL,
	[ServerURL] [nvarchar](450) NOT NULL,
	[ServerEnabled] [bit] NOT NULL,
	[ServerAuthentication] [nvarchar](20) NOT NULL,
	[ServerUsername] [nvarchar](100) NULL,
	[ServerPassword] [nvarchar](100) NULL,
	[ServerX509ClientKeyID] [nvarchar](200) NULL,
	[ServerX509ServerKeyID] [nvarchar](200) NULL,
	[ServerGUID] [uniqueidentifier] NOT NULL,
	[ServerLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Staging_Server] PRIMARY KEY NONCLUSTERED 
(
	[ServerID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Staging_Server_ServerSiteID_ServerDisplayName] ON [dbo].[Staging_Server]
(
	[ServerSiteID] ASC,
	[ServerDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_Server_ServerEnabled] ON [dbo].[Staging_Server]
(
	[ServerEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_Server_ServerSiteID] ON [dbo].[Staging_Server]
(
	[ServerSiteID] ASC
)
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerName]  DEFAULT ('') FOR [ServerName]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_staging_server_ServerDisplayName]  DEFAULT ('') FOR [ServerDisplayName]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerSiteID]  DEFAULT ((0)) FOR [ServerSiteID]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerURL]  DEFAULT (N'') FOR [ServerURL]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerEnabled]  DEFAULT ((1)) FOR [ServerEnabled]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerAuthentication]  DEFAULT ('USERNAME') FOR [ServerAuthentication]
GO
ALTER TABLE [dbo].[Staging_Server] ADD  CONSTRAINT [DEFAULT_Staging_Server_ServerGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ServerGUID]
GO
ALTER TABLE [dbo].[Staging_Server]  WITH CHECK ADD  CONSTRAINT [FK_Staging_Server_ServerSiteID_CMS_Site] FOREIGN KEY([ServerSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Staging_Server] CHECK CONSTRAINT [FK_Staging_Server_ServerSiteID_CMS_Site]
GO
