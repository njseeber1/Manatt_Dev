SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Site](
	[SiteID] [int] IDENTITY(1,1) NOT NULL,
	[SiteName] [nvarchar](100) NOT NULL,
	[SiteDisplayName] [nvarchar](200) NOT NULL,
	[SiteDescription] [nvarchar](max) NULL,
	[SiteStatus] [nvarchar](20) NOT NULL,
	[SiteDomainName] [nvarchar](400) NOT NULL,
	[SiteDefaultStylesheetID] [int] NULL,
	[SiteDefaultVisitorCulture] [nvarchar](50) NULL,
	[SiteDefaultEditorStylesheet] [int] NULL,
	[SiteGUID] [uniqueidentifier] NOT NULL,
	[SiteLastModified] [datetime2](7) NOT NULL,
	[SiteIsOffline] [bit] NULL,
	[SiteOfflineRedirectURL] [nvarchar](400) NULL,
	[SiteOfflineMessage] [nvarchar](max) NULL,
	[SitePresentationURL] [nvarchar](400) NULL,
	[SiteIsContentOnly] [bit] NULL,
 CONSTRAINT [PK_CMS_Site] PRIMARY KEY NONCLUSTERED 
(
	[SiteID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Site_SiteDisplayName] ON [dbo].[CMS_Site]
(
	[SiteDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Site_SiteDefaultEditorStylesheet] ON [dbo].[CMS_Site]
(
	[SiteDefaultEditorStylesheet] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Site_SiteDefaultStylesheetID] ON [dbo].[CMS_Site]
(
	[SiteDefaultStylesheetID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Site_SiteDomainName_SiteStatus] ON [dbo].[CMS_Site]
(
	[SiteDomainName] ASC,
	[SiteStatus] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Site_SiteName] ON [dbo].[CMS_Site]
(
	[SiteName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Site] ADD  CONSTRAINT [DEFAULT_CMS_Site_SiteName]  DEFAULT ('') FOR [SiteName]
GO
ALTER TABLE [dbo].[CMS_Site] ADD  CONSTRAINT [DEFAULT_CMS_Site_SiteDisplayName]  DEFAULT ('') FOR [SiteDisplayName]
GO
ALTER TABLE [dbo].[CMS_Site] ADD  CONSTRAINT [DEFAULT_CMS_Site_SiteStatus]  DEFAULT ('') FOR [SiteStatus]
GO
ALTER TABLE [dbo].[CMS_Site] ADD  CONSTRAINT [DEFAULT_CMS_Site_SiteDomainName]  DEFAULT ('') FOR [SiteDomainName]
GO
ALTER TABLE [dbo].[CMS_Site]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Site_SiteDefaultEditorStylesheet_CMS_CssStylesheet] FOREIGN KEY([SiteDefaultEditorStylesheet])
REFERENCES [dbo].[CMS_CssStylesheet] ([StylesheetID])
GO
ALTER TABLE [dbo].[CMS_Site] CHECK CONSTRAINT [FK_CMS_Site_SiteDefaultEditorStylesheet_CMS_CssStylesheet]
GO
ALTER TABLE [dbo].[CMS_Site]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Site_SiteDefaultStylesheetID_CMS_CssStylesheet] FOREIGN KEY([SiteDefaultStylesheetID])
REFERENCES [dbo].[CMS_CssStylesheet] ([StylesheetID])
GO
ALTER TABLE [dbo].[CMS_Site] CHECK CONSTRAINT [FK_CMS_Site_SiteDefaultStylesheetID_CMS_CssStylesheet]
GO
