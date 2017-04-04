SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_BannerCategory](
	[BannerCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[BannerCategoryName] [nvarchar](100) NOT NULL,
	[BannerCategoryDisplayName] [nvarchar](200) NOT NULL,
	[BannerCategorySiteID] [int] NULL,
	[BannerCategoryGuid] [uniqueidentifier] NOT NULL,
	[BannerCategoryLastModified] [datetime2](7) NOT NULL,
	[BannerCategoryEnabled] [bit] NOT NULL,
 CONSTRAINT [PK__CMS_BannerCategory] PRIMARY KEY CLUSTERED 
(
	[BannerCategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID] ON [dbo].[CMS_BannerCategory]
(
	[BannerCategoryName] ASC,
	[BannerCategorySiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_BannerCategory_BannerCategorySiteID] ON [dbo].[CMS_BannerCategory]
(
	[BannerCategorySiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_BannerCategory] ADD  CONSTRAINT [DEFAULT_CMS_BannerCategory_BannerCategoryName]  DEFAULT ('') FOR [BannerCategoryName]
GO
ALTER TABLE [dbo].[CMS_BannerCategory] ADD  CONSTRAINT [DEFAULT_CMS_BannerCategory_BannerCategoryDisplayName]  DEFAULT ('') FOR [BannerCategoryDisplayName]
GO
ALTER TABLE [dbo].[CMS_BannerCategory] ADD  CONSTRAINT [DEFAULT_CMS_BannerCategory_BannerCategoryGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [BannerCategoryGuid]
GO
ALTER TABLE [dbo].[CMS_BannerCategory] ADD  CONSTRAINT [DEFAULT_CMS_BannerCategory_BannerCategoryLastModified]  DEFAULT ('1/1/1970 12:00:00 AM') FOR [BannerCategoryLastModified]
GO
ALTER TABLE [dbo].[CMS_BannerCategory] ADD  CONSTRAINT [DEFAULT_CMS_BannerCategory_BannerCategoryEnabled]  DEFAULT ((1)) FOR [BannerCategoryEnabled]
GO
ALTER TABLE [dbo].[CMS_BannerCategory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_BannerCategory_CMS_Site] FOREIGN KEY([BannerCategorySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_BannerCategory] CHECK CONSTRAINT [FK_CMS_BannerCategory_CMS_Site]
GO
