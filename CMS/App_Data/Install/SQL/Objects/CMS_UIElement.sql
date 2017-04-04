SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_UIElement](
	[ElementID] [int] IDENTITY(1,1) NOT NULL,
	[ElementDisplayName] [nvarchar](200) NOT NULL,
	[ElementName] [nvarchar](200) NOT NULL,
	[ElementCaption] [nvarchar](200) NULL,
	[ElementTargetURL] [nvarchar](650) NULL,
	[ElementResourceID] [int] NOT NULL,
	[ElementParentID] [int] NULL,
	[ElementChildCount] [int] NOT NULL,
	[ElementOrder] [int] NULL,
	[ElementLevel] [int] NOT NULL,
	[ElementIDPath] [nvarchar](450) NOT NULL,
	[ElementIconPath] [nvarchar](200) NULL,
	[ElementIsCustom] [bit] NULL,
	[ElementLastModified] [datetime2](7) NOT NULL,
	[ElementGUID] [uniqueidentifier] NOT NULL,
	[ElementSize] [int] NULL,
	[ElementDescription] [nvarchar](max) NULL,
	[ElementFromVersion] [nvarchar](20) NULL,
	[ElementPageTemplateID] [int] NULL,
	[ElementType] [nvarchar](50) NULL,
	[ElementProperties] [nvarchar](max) NULL,
	[ElementIsMenu] [bit] NULL,
	[ElementFeature] [nvarchar](200) NULL,
	[ElementIconClass] [nvarchar](100) NULL,
	[ElementIsGlobalApplication] [bit] NULL,
	[ElementCheckModuleReadPermission] [bit] NULL,
	[ElementAccessCondition] [nvarchar](max) NULL,
	[ElementVisibilityCondition] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_UIElement] PRIMARY KEY NONCLUSTERED 
(
	[ElementID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption] ON [dbo].[CMS_UIElement]
(
	[ElementResourceID] ASC,
	[ElementLevel] ASC,
	[ElementParentID] ASC,
	[ElementOrder] ASC,
	[ElementCaption] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UIElement_ElementParentID] ON [dbo].[CMS_UIElement]
(
	[ElementParentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UIElement_ElementResourceID] ON [dbo].[CMS_UIElement]
(
	[ElementResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementName]  DEFAULT (N'') FOR [ElementName]
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementIsCustom]  DEFAULT ((0)) FOR [ElementIsCustom]
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementSize]  DEFAULT ((0)) FOR [ElementSize]
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementIsMenu]  DEFAULT ((0)) FOR [ElementIsMenu]
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementIsGlobalApplication]  DEFAULT ((0)) FOR [ElementIsGlobalApplication]
GO
ALTER TABLE [dbo].[CMS_UIElement] ADD  CONSTRAINT [DEFAULT_CMS_UIElement_ElementCheckModuleReadPermission]  DEFAULT ((1)) FOR [ElementCheckModuleReadPermission]
GO
ALTER TABLE [dbo].[CMS_UIElement]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UIElement_ElementParentID_CMS_UIElement] FOREIGN KEY([ElementParentID])
REFERENCES [dbo].[CMS_UIElement] ([ElementID])
GO
ALTER TABLE [dbo].[CMS_UIElement] CHECK CONSTRAINT [FK_CMS_UIElement_ElementParentID_CMS_UIElement]
GO
ALTER TABLE [dbo].[CMS_UIElement]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UIElement_ElementResourceID_CMS_Resource] FOREIGN KEY([ElementResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_UIElement] CHECK CONSTRAINT [FK_CMS_UIElement_ElementResourceID_CMS_Resource]
GO
