SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_PageTemplateCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](200) NOT NULL,
	[CategoryParentID] [int] NULL,
	[CategoryName] [nvarchar](200) NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[CategoryLastModified] [datetime2](7) NOT NULL,
	[CategoryImagePath] [nvarchar](450) NULL,
	[CategoryChildCount] [int] NULL,
	[CategoryTemplateChildCount] [int] NULL,
	[CategoryPath] [nvarchar](450) NULL,
	[CategoryLevel] [int] NULL,
 CONSTRAINT [PK_CMS_PageTemplateCategory] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [IX_CMS_PageTemplateCategory_CategoryPath] ON [dbo].[CMS_PageTemplateCategory]
(
	[CategoryPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateCategory_CategoryLevel] ON [dbo].[CMS_PageTemplateCategory]
(
	[CategoryLevel] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateCategory_CategoryParentID] ON [dbo].[CMS_PageTemplateCategory]
(
	[CategoryParentID] ASC
)
GO
ALTER TABLE [dbo].[CMS_PageTemplateCategory] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplateCategory_CategoryDisplayName]  DEFAULT ('') FOR [CategoryDisplayName]
GO
ALTER TABLE [dbo].[CMS_PageTemplateCategory] ADD  CONSTRAINT [DF_CMS_PageTemplateCategory_CategoryChildCount]  DEFAULT ((0)) FOR [CategoryChildCount]
GO
ALTER TABLE [dbo].[CMS_PageTemplateCategory] ADD  CONSTRAINT [DF_CMS_PageTemplateCategory_CategoryTemplateChildCount]  DEFAULT ((0)) FOR [CategoryTemplateChildCount]
GO
ALTER TABLE [dbo].[CMS_PageTemplateCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_PageTemplateCategory_CategoryParentID_CMS_PageTemplateCategory] FOREIGN KEY([CategoryParentID])
REFERENCES [dbo].[CMS_PageTemplateCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateCategory] CHECK CONSTRAINT [FK_CMS_PageTemplateCategory_CategoryParentID_CMS_PageTemplateCategory]
GO
