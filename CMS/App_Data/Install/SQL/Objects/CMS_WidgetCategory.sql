SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WidgetCategory](
	[WidgetCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[WidgetCategoryName] [nvarchar](100) NOT NULL,
	[WidgetCategoryDisplayName] [nvarchar](100) NOT NULL,
	[WidgetCategoryParentID] [int] NULL,
	[WidgetCategoryPath] [nvarchar](450) NOT NULL,
	[WidgetCategoryLevel] [int] NOT NULL,
	[WidgetCategoryChildCount] [int] NULL,
	[WidgetCategoryWidgetChildCount] [int] NULL,
	[WidgetCategoryImagePath] [nvarchar](450) NULL,
	[WidgetCategoryGUID] [uniqueidentifier] NOT NULL,
	[WidgetCategoryLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_WidgetCategory] PRIMARY KEY NONCLUSTERED 
(
	[WidgetCategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [IX_CMS_WidgetCategory_CategoryPath] ON [dbo].[CMS_WidgetCategory]
(
	[WidgetCategoryPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WidgetCategory_WidgetCategoryParentID] ON [dbo].[CMS_WidgetCategory]
(
	[WidgetCategoryParentID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WidgetCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WidgetCategory_WidgetCategoryParentID_CMS_WidgetCategory] FOREIGN KEY([WidgetCategoryParentID])
REFERENCES [dbo].[CMS_WidgetCategory] ([WidgetCategoryID])
GO
ALTER TABLE [dbo].[CMS_WidgetCategory] CHECK CONSTRAINT [FK_CMS_WidgetCategory_WidgetCategoryParentID_CMS_WidgetCategory]
GO
