SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](250) NOT NULL,
	[CategoryName] [nvarchar](250) NULL,
	[CategoryDescription] [nvarchar](max) NULL,
	[CategoryCount] [int] NULL,
	[CategoryEnabled] [bit] NOT NULL,
	[CategoryUserID] [int] NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[CategoryLastModified] [datetime2](7) NOT NULL,
	[CategorySiteID] [int] NULL,
	[CategoryParentID] [int] NULL,
	[CategoryIDPath] [nvarchar](450) NULL,
	[CategoryNamePath] [nvarchar](1500) NULL,
	[CategoryLevel] [int] NULL,
	[CategoryOrder] [int] NULL,
 CONSTRAINT [PK_CMS_Category] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Category_CategoryDisplayName_CategoryEnabled] ON [dbo].[CMS_Category]
(
	[CategoryDisplayName] ASC,
	[CategoryEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Category_CategorySiteID] ON [dbo].[CMS_Category]
(
	[CategorySiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Category_CategoryUserID] ON [dbo].[CMS_Category]
(
	[CategoryUserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Category] ADD  CONSTRAINT [DEFAULT_CMS_Category_CategoryDisplayName]  DEFAULT ('') FOR [CategoryDisplayName]
GO
ALTER TABLE [dbo].[CMS_Category] ADD  CONSTRAINT [DEFAULT_CMS_Category_CategoryEnabled]  DEFAULT ((1)) FOR [CategoryEnabled]
GO
ALTER TABLE [dbo].[CMS_Category] ADD  CONSTRAINT [DEFAULT_CMS_Category_CategoryGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CategoryGUID]
GO
ALTER TABLE [dbo].[CMS_Category]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Category_CategorySiteID_CMS_Site] FOREIGN KEY([CategorySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Category] CHECK CONSTRAINT [FK_CMS_Category_CategorySiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_Category]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Category_CategoryUserID_CMS_User] FOREIGN KEY([CategoryUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Category] CHECK CONSTRAINT [FK_CMS_Category_CategoryUserID_CMS_User]
GO
