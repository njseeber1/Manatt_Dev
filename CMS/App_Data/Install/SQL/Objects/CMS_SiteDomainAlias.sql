SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SiteDomainAlias](
	[SiteDomainAliasID] [int] IDENTITY(1,1) NOT NULL,
	[SiteDomainAliasName] [nvarchar](400) NOT NULL,
	[SiteID] [int] NOT NULL,
	[SiteDefaultVisitorCulture] [nvarchar](50) NULL,
	[SiteDomainGUID] [uniqueidentifier] NULL,
	[SiteDomainLastModified] [datetime2](7) NOT NULL,
	[SiteDomainDefaultAliasPath] [nvarchar](450) NULL,
	[SiteDomainRedirectUrl] [nvarchar](450) NULL,
 CONSTRAINT [PK_CMS_SiteDomainAlias] PRIMARY KEY CLUSTERED 
(
	[SiteDomainAliasID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_SiteDomainAlias_SiteDomainAliasName] ON [dbo].[CMS_SiteDomainAlias]
(
	[SiteDomainAliasName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_SiteDomainAlias_SiteID] ON [dbo].[CMS_SiteDomainAlias]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_SiteDomainAlias] ADD  CONSTRAINT [DEFAULT_CMS_SiteDomainAlias_SiteDomainAliasName]  DEFAULT ('') FOR [SiteDomainAliasName]
GO
ALTER TABLE [dbo].[CMS_SiteDomainAlias]  WITH CHECK ADD  CONSTRAINT [FK_CMS_SiteDomainAlias_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_SiteDomainAlias] CHECK CONSTRAINT [FK_CMS_SiteDomainAlias_SiteID_CMS_Site]
GO
