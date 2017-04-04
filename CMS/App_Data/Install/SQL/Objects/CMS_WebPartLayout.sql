SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebPartLayout](
	[WebPartLayoutID] [int] IDENTITY(1,1) NOT NULL,
	[WebPartLayoutCodeName] [nvarchar](200) NOT NULL,
	[WebPartLayoutDisplayName] [nvarchar](200) NOT NULL,
	[WebPartLayoutDescription] [nvarchar](max) NULL,
	[WebPartLayoutCode] [nvarchar](max) NULL,
	[WebPartLayoutVersionGUID] [nvarchar](100) NULL,
	[WebPartLayoutWebPartID] [int] NOT NULL,
	[WebPartLayoutGUID] [uniqueidentifier] NOT NULL,
	[WebPartLayoutLastModified] [datetime2](7) NOT NULL,
	[WebPartLayoutCSS] [nvarchar](max) NULL,
	[WebPartLayoutIsDefault] [bit] NULL,
 CONSTRAINT [PK_CMS_WebPartLayout] PRIMARY KEY NONCLUSTERED 
(
	[WebPartLayoutID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName] ON [dbo].[CMS_WebPartLayout]
(
	[WebPartLayoutWebPartID] ASC,
	[WebPartLayoutCodeName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartLayout_WebPartLayoutWebPartID] ON [dbo].[CMS_WebPartLayout]
(
	[WebPartLayoutWebPartID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebPartLayout] ADD  CONSTRAINT [DEFAULT_CMS_WebPartLayout_WebPartLayoutCodeName]  DEFAULT ('') FOR [WebPartLayoutCodeName]
GO
ALTER TABLE [dbo].[CMS_WebPartLayout] ADD  CONSTRAINT [DEFAULT_CMS_WebPartLayout_WebPartLayoutDisplayName]  DEFAULT ('') FOR [WebPartLayoutDisplayName]
GO
ALTER TABLE [dbo].[CMS_WebPartLayout]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutWebPartID_CMS_WebPart] FOREIGN KEY([WebPartLayoutWebPartID])
REFERENCES [dbo].[CMS_WebPart] ([WebPartID])
GO
ALTER TABLE [dbo].[CMS_WebPartLayout] CHECK CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutWebPartID_CMS_WebPart]
GO
