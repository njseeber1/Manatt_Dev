SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebPartCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](100) NOT NULL,
	[CategoryParentID] [int] NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[CategoryLastModified] [datetime2](7) NOT NULL,
	[CategoryImagePath] [nvarchar](450) NULL,
	[CategoryPath] [nvarchar](450) NOT NULL,
	[CategoryLevel] [int] NULL,
	[CategoryChildCount] [int] NULL,
	[CategoryWebPartChildCount] [int] NULL,
 CONSTRAINT [PK_CMS_WebPartCategory] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [IX_CMS_WebPartCategory_CategoryPath] ON [dbo].[CMS_WebPartCategory]
(
	[CategoryPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartCategory_CategoryParentID] ON [dbo].[CMS_WebPartCategory]
(
	[CategoryParentID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebPartCategory] ADD  CONSTRAINT [DEFAULT_CMS_WebPartCategory_CategoryPath]  DEFAULT ('') FOR [CategoryPath]
GO
ALTER TABLE [dbo].[CMS_WebPartCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebPartCategory_CategoryParentID_CMS_WebPartCategory] FOREIGN KEY([CategoryParentID])
REFERENCES [dbo].[CMS_WebPartCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_WebPartCategory] CHECK CONSTRAINT [FK_CMS_WebPartCategory_CategoryParentID_CMS_WebPartCategory]
GO
