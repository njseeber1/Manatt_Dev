SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Widget](
	[WidgetID] [int] IDENTITY(1,1) NOT NULL,
	[WidgetWebPartID] [int] NOT NULL,
	[WidgetDisplayName] [nvarchar](100) NOT NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetDescription] [nvarchar](max) NULL,
	[WidgetCategoryID] [int] NOT NULL,
	[WidgetProperties] [nvarchar](max) NULL,
	[WidgetSecurity] [int] NOT NULL,
	[WidgetGUID] [uniqueidentifier] NOT NULL,
	[WidgetLastModified] [datetime2](7) NOT NULL,
	[WidgetIsEnabled] [bit] NOT NULL,
	[WidgetForGroup] [bit] NOT NULL,
	[WidgetForEditor] [bit] NOT NULL,
	[WidgetForUser] [bit] NOT NULL,
	[WidgetForDashboard] [bit] NOT NULL,
	[WidgetForInline] [bit] NOT NULL,
	[WidgetDocumentation] [nvarchar](max) NULL,
	[WidgetDefaultValues] [nvarchar](max) NULL,
	[WidgetLayoutID] [int] NULL,
	[WidgetSkipInsertProperties] [bit] NULL,
	[WidgetThumbnailGUID] [uniqueidentifier] NULL,
	[WidgetIconClass] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_Widget] PRIMARY KEY NONCLUSTERED 
(
	[WidgetID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName] ON [dbo].[CMS_Widget]
(
	[WidgetCategoryID] ASC,
	[WidgetDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Widget_WidgetCategoryID] ON [dbo].[CMS_Widget]
(
	[WidgetCategoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser] ON [dbo].[CMS_Widget]
(
	[WidgetIsEnabled] ASC,
	[WidgetForGroup] ASC,
	[WidgetForEditor] ASC,
	[WidgetForUser] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Widget_WidgetLayoutID] ON [dbo].[CMS_Widget]
(
	[WidgetLayoutID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Widget_WidgetWebPartID] ON [dbo].[CMS_Widget]
(
	[WidgetWebPartID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DF_CMS_Widget_WidgetSecurity]  DEFAULT ((2)) FOR [WidgetSecurity]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetIsEnabled]  DEFAULT ((0)) FOR [WidgetIsEnabled]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetForGroup]  DEFAULT ((0)) FOR [WidgetForGroup]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetForEditor]  DEFAULT ((0)) FOR [WidgetForEditor]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetForUser]  DEFAULT ((0)) FOR [WidgetForUser]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetForDashboard]  DEFAULT ((0)) FOR [WidgetForDashboard]
GO
ALTER TABLE [dbo].[CMS_Widget] ADD  CONSTRAINT [DEFAULT_CMS_Widget_WidgetForInline]  DEFAULT ((0)) FOR [WidgetForInline]
GO
ALTER TABLE [dbo].[CMS_Widget]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Widget_WidgetCategoryID_CMS_WidgetCategory] FOREIGN KEY([WidgetCategoryID])
REFERENCES [dbo].[CMS_WidgetCategory] ([WidgetCategoryID])
GO
ALTER TABLE [dbo].[CMS_Widget] CHECK CONSTRAINT [FK_CMS_Widget_WidgetCategoryID_CMS_WidgetCategory]
GO
ALTER TABLE [dbo].[CMS_Widget]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Widget_WidgetLayoutID_CMS_WebPartLayout] FOREIGN KEY([WidgetLayoutID])
REFERENCES [dbo].[CMS_WebPartLayout] ([WebPartLayoutID])
GO
ALTER TABLE [dbo].[CMS_Widget] CHECK CONSTRAINT [FK_CMS_Widget_WidgetLayoutID_CMS_WebPartLayout]
GO
ALTER TABLE [dbo].[CMS_Widget]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Widget_WidgetWebPartID_CMS_WebPart] FOREIGN KEY([WidgetWebPartID])
REFERENCES [dbo].[CMS_WebPart] ([WebPartID])
GO
ALTER TABLE [dbo].[CMS_Widget] CHECK CONSTRAINT [FK_CMS_Widget_WidgetWebPartID_CMS_WebPart]
GO
