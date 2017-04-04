SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Banner](
	[BannerID] [int] IDENTITY(1,1) NOT NULL,
	[BannerName] [nvarchar](256) NOT NULL,
	[BannerDisplayName] [nvarchar](256) NOT NULL,
	[BannerCategoryID] [int] NOT NULL,
	[BannerEnabled] [bit] NOT NULL,
	[BannerFrom] [datetime2](7) NULL,
	[BannerTo] [datetime2](7) NULL,
	[BannerGuid] [uniqueidentifier] NOT NULL,
	[BannerLastModified] [datetime2](7) NOT NULL,
	[BannerType] [int] NOT NULL,
	[BannerURL] [nvarchar](2083) NOT NULL,
	[BannerBlank] [bit] NOT NULL,
	[BannerWeight] [float] NOT NULL,
	[BannerHitsLeft] [int] NULL,
	[BannerClicksLeft] [int] NULL,
	[BannerSiteID] [int] NULL,
	[BannerContent] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BannerID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Banner_BannerCategoryID] ON [dbo].[CMS_Banner]
(
	[BannerCategoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Banner_BannerSiteID] ON [dbo].[CMS_Banner]
(
	[BannerSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerName]  DEFAULT ('') FOR [BannerName]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerDisplayName]  DEFAULT ('') FOR [BannerDisplayName]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerCategoryID]  DEFAULT ((0)) FOR [BannerCategoryID]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_CMS_Banner_BannerEnabled]  DEFAULT ((1)) FOR [BannerEnabled]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [BannerGuid]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerLastModified]  DEFAULT ('1/1/1970 12:00:00 AM') FOR [BannerLastModified]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_CMS_Banner_BannerType]  DEFAULT ((2)) FOR [BannerType]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_cms_banner_BannerBlank]  DEFAULT ((0)) FOR [BannerBlank]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_CMS_Banner_BannerWeight]  DEFAULT ((5)) FOR [BannerWeight]
GO
ALTER TABLE [dbo].[CMS_Banner] ADD  CONSTRAINT [DEFAULT_CMS_Banner_BannerContent]  DEFAULT (N'') FOR [BannerContent]
GO
ALTER TABLE [dbo].[CMS_Banner]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Banner_CMS_BannerCategory] FOREIGN KEY([BannerCategoryID])
REFERENCES [dbo].[CMS_BannerCategory] ([BannerCategoryID])
GO
ALTER TABLE [dbo].[CMS_Banner] CHECK CONSTRAINT [FK_CMS_Banner_CMS_BannerCategory]
GO
ALTER TABLE [dbo].[CMS_Banner]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Banner_CMS_Site] FOREIGN KEY([BannerSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Banner] CHECK CONSTRAINT [FK_CMS_Banner_CMS_Site]
GO
