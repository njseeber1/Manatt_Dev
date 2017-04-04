SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SettingsCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](200) NOT NULL,
	[CategoryOrder] [int] NULL,
	[CategoryName] [nvarchar](100) NULL,
	[CategoryParentID] [int] NULL,
	[CategoryIDPath] [nvarchar](450) NULL,
	[CategoryLevel] [int] NULL,
	[CategoryChildCount] [int] NULL,
	[CategoryIconPath] [nvarchar](200) NULL,
	[CategoryIsGroup] [bit] NULL,
	[CategoryIsCustom] [bit] NULL,
	[CategoryResourceID] [int] NULL,
 CONSTRAINT [PK_CMS_SettingsCategory] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_SettingsCategory_CategoryOrder] ON [dbo].[CMS_SettingsCategory]
(
	[CategoryOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_SettingsCategory_CategoryParentID] ON [dbo].[CMS_SettingsCategory]
(
	[CategoryParentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_SettingsCategory_CategoryResourceID] ON [dbo].[CMS_SettingsCategory]
(
	[CategoryResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_SettingsCategory] ADD  CONSTRAINT [DEFAULT_CMS_SettingsCategory_CategoryDisplayName]  DEFAULT ('') FOR [CategoryDisplayName]
GO
ALTER TABLE [dbo].[CMS_SettingsCategory] ADD  CONSTRAINT [DEFAULT_CMS_SettingsCategory_CategoryIsGroup]  DEFAULT ((0)) FOR [CategoryIsGroup]
GO
ALTER TABLE [dbo].[CMS_SettingsCategory] ADD  CONSTRAINT [DEFAULT_CMS_SettingsCategory_CategoryIsCustom]  DEFAULT ((0)) FOR [CategoryIsCustom]
GO
ALTER TABLE [dbo].[CMS_SettingsCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_SettingsCategory_CategoryResourceID_CMS_Resource] FOREIGN KEY([CategoryResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_SettingsCategory] CHECK CONSTRAINT [FK_CMS_SettingsCategory_CategoryResourceID_CMS_Resource]
GO
ALTER TABLE [dbo].[CMS_SettingsCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_SettingsCategory_CMS_SettingsCategory1] FOREIGN KEY([CategoryParentID])
REFERENCES [dbo].[CMS_SettingsCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_SettingsCategory] CHECK CONSTRAINT [FK_CMS_SettingsCategory_CMS_SettingsCategory1]
GO
