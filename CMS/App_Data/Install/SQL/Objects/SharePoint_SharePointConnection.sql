SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SharePoint_SharePointConnection](
	[SharePointConnectionID] [int] IDENTITY(1,1) NOT NULL,
	[SharePointConnectionGUID] [uniqueidentifier] NOT NULL,
	[SharePointConnectionSiteID] [int] NOT NULL,
	[SharePointConnectionSiteUrl] [nvarchar](512) NOT NULL,
	[SharePointConnectionAuthMode] [nvarchar](30) NOT NULL,
	[SharePointConnectionDisplayName] [nvarchar](100) NOT NULL,
	[SharePointConnectionName] [nvarchar](100) NOT NULL,
	[SharePointConnectionSharePointVersion] [nvarchar](30) NOT NULL,
	[SharePointConnectionUserName] [nvarchar](100) NULL,
	[SharePointConnectionPassword] [nvarchar](100) NULL,
	[SharePointConnectionDomain] [nvarchar](100) NULL,
	[SharePointConnectionLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SharePoint_SharePointConnection] PRIMARY KEY CLUSTERED 
(
	[SharePointConnectionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SharePoint_SharePointConnection_SharePointConnectionSiteID] ON [dbo].[SharePoint_SharePointConnection]
(
	[SharePointConnectionSiteID] ASC
)
GO
ALTER TABLE [dbo].[SharePoint_SharePointConnection] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointConnection_SharePointConnectionAuthMode]  DEFAULT (N'default') FOR [SharePointConnectionAuthMode]
GO
ALTER TABLE [dbo].[SharePoint_SharePointConnection] ADD  CONSTRAINT [DEFAULT_SharePoint_SharePointConnection_SharePointConnectionSharePointVersion]  DEFAULT (N'sp2010') FOR [SharePointConnectionSharePointVersion]
GO
