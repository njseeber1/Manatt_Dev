SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebPart](
	[WebPartID] [int] IDENTITY(1,1) NOT NULL,
	[WebPartName] [nvarchar](100) NOT NULL,
	[WebPartDisplayName] [nvarchar](100) NOT NULL,
	[WebPartDescription] [nvarchar](max) NULL,
	[WebPartFileName] [nvarchar](100) NOT NULL,
	[WebPartProperties] [nvarchar](max) NOT NULL,
	[WebPartCategoryID] [int] NOT NULL,
	[WebPartParentID] [int] NULL,
	[WebPartDocumentation] [nvarchar](max) NULL,
	[WebPartGUID] [uniqueidentifier] NOT NULL,
	[WebPartLastModified] [datetime2](0) NOT NULL,
	[WebPartType] [int] NULL,
	[WebPartLoadGeneration] [int] NOT NULL,
	[WebPartDefaultValues] [nvarchar](max) NULL,
	[WebPartResourceID] [int] NULL,
	[WebPartCSS] [nvarchar](max) NULL,
	[WebPartSkipInsertProperties] [bit] NULL,
	[WebPartThumbnailGUID] [uniqueidentifier] NULL,
	[WebPartDefaultConfiguration] [nvarchar](max) NULL,
	[WebPartIconClass] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_WebPart] PRIMARY KEY NONCLUSTERED 
(
	[WebPartID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_WebPart_WebPartLoadGeneration] ON [dbo].[CMS_WebPart]
(
	[WebPartLoadGeneration] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPart_WebPartCategoryID] ON [dbo].[CMS_WebPart]
(
	[WebPartCategoryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPart_WebPartName] ON [dbo].[CMS_WebPart]
(
	[WebPartName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPart_WebPartParentID] ON [dbo].[CMS_WebPart]
(
	[WebPartParentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPart_WebPartResourceID] ON [dbo].[CMS_WebPart]
(
	[WebPartResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartName]  DEFAULT (N'') FOR [WebPartName]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartDisplayName]  DEFAULT (N'') FOR [WebPartDisplayName]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartFileName]  DEFAULT (N'') FOR [WebPartFileName]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartProperties]  DEFAULT (N'') FOR [WebPartProperties]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartCategoryID]  DEFAULT ((0)) FOR [WebPartCategoryID]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [WebPartGUID]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartLastModified]  DEFAULT ('12/4/2013 4:51:30 PM') FOR [WebPartLastModified]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartLoadGeneration]  DEFAULT ((0)) FOR [WebPartLoadGeneration]
GO
ALTER TABLE [dbo].[CMS_WebPart] ADD  CONSTRAINT [DEFAULT_CMS_WebPart_WebPartSkipInsertProperties]  DEFAULT ((0)) FOR [WebPartSkipInsertProperties]
GO
ALTER TABLE [dbo].[CMS_WebPart]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebPart_WebPartCategoryID_CMS_WebPartCategory] FOREIGN KEY([WebPartCategoryID])
REFERENCES [dbo].[CMS_WebPartCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_WebPart] CHECK CONSTRAINT [FK_CMS_WebPart_WebPartCategoryID_CMS_WebPartCategory]
GO
ALTER TABLE [dbo].[CMS_WebPart]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebPart_WebPartParentID_CMS_WebPart] FOREIGN KEY([WebPartParentID])
REFERENCES [dbo].[CMS_WebPart] ([WebPartID])
GO
ALTER TABLE [dbo].[CMS_WebPart] CHECK CONSTRAINT [FK_CMS_WebPart_WebPartParentID_CMS_WebPart]
GO
ALTER TABLE [dbo].[CMS_WebPart]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebPart_WebPartResourceID_CMS_Resource] FOREIGN KEY([WebPartResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_WebPart] CHECK CONSTRAINT [FK_CMS_WebPart_WebPartResourceID_CMS_Resource]
GO
