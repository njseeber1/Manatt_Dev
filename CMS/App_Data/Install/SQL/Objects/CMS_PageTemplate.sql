SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_PageTemplate](
	[PageTemplateID] [int] IDENTITY(1,1) NOT NULL,
	[PageTemplateDisplayName] [nvarchar](200) NOT NULL,
	[PageTemplateCodeName] [nvarchar](100) NOT NULL,
	[PageTemplateDescription] [nvarchar](max) NULL,
	[PageTemplateFile] [nvarchar](400) NULL,
	[PageTemplateIsPortal] [bit] NULL,
	[PageTemplateCategoryID] [int] NULL,
	[PageTemplateLayoutID] [int] NULL,
	[PageTemplateWebParts] [nvarchar](max) NULL,
	[PageTemplateIsReusable] [bit] NULL,
	[PageTemplateShowAsMasterTemplate] [bit] NULL,
	[PageTemplateInheritPageLevels] [nvarchar](200) NULL,
	[PageTemplateLayout] [nvarchar](max) NULL,
	[PageTemplateVersionGUID] [nvarchar](200) NULL,
	[PageTemplateHeader] [nvarchar](max) NULL,
	[PageTemplateGUID] [uniqueidentifier] NOT NULL,
	[PageTemplateLastModified] [datetime2](7) NOT NULL,
	[PageTemplateSiteID] [int] NULL,
	[PageTemplateForAllPages] [bit] NULL,
	[PageTemplateType] [nvarchar](10) NULL,
	[PageTemplateLayoutType] [nvarchar](50) NULL,
	[PageTemplateCSS] [nvarchar](max) NULL,
	[PageTemplateIsAllowedForProductSection] [bit] NULL,
	[PageTemplateInheritParentHeader] [bit] NULL,
	[PageTemplateAllowInheritHeader] [bit] NULL,
	[PageTemplateThumbnailGUID] [uniqueidentifier] NULL,
	[PageTemplateCloneAsAdHoc] [bit] NULL,
	[PageTemplateDefaultController] [nvarchar](200) NULL,
	[PageTemplateDefaultAction] [nvarchar](200) NULL,
	[PageTemplateNodeGUID] [uniqueidentifier] NULL,
	[PageTemplateMasterPageTemplateID] [int] NULL,
	[PageTemplateProperties] [nvarchar](max) NULL,
	[PageTemplateIsLayout] [bit] NULL,
	[PageTemplateIconClass] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_PageTemplate] PRIMARY KEY NONCLUSTERED 
(
	[PageTemplateID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_PageTemplate_PageTemplateCategoryID] ON [dbo].[CMS_PageTemplate]
(
	[PageTemplateCategoryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName] ON [dbo].[CMS_PageTemplate]
(
	[PageTemplateCodeName] ASC,
	[PageTemplateDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate] ON [dbo].[CMS_PageTemplate]
(
	[PageTemplateIsReusable] ASC,
	[PageTemplateForAllPages] ASC,
	[PageTemplateShowAsMasterTemplate] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplate_PageTemplateLayoutID] ON [dbo].[CMS_PageTemplate]
(
	[PageTemplateLayoutID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID] ON [dbo].[CMS_PageTemplate]
(
	[PageTemplateSiteID] ASC,
	[PageTemplateCodeName] ASC,
	[PageTemplateGUID] ASC
)
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateDisplayName]  DEFAULT ('') FOR [PageTemplateDisplayName]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateCodeName]  DEFAULT ('') FOR [PageTemplateCodeName]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateIsPortal]  DEFAULT ((0)) FOR [PageTemplateIsPortal]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateIsReusable]  DEFAULT ((0)) FOR [PageTemplateIsReusable]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateShowAsMasterTemplate]  DEFAULT ((0)) FOR [PageTemplateShowAsMasterTemplate]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateForAllPages]  DEFAULT ((1)) FOR [PageTemplateForAllPages]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateCloneAsAdHoc]  DEFAULT ((0)) FOR [PageTemplateCloneAsAdHoc]
GO
ALTER TABLE [dbo].[CMS_PageTemplate] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplate_PageTemplateIsLayout]  DEFAULT ((0)) FOR [PageTemplateIsLayout]
GO
ALTER TABLE [dbo].[CMS_PageTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_PageTemplate_PageTemplateCategoryID_CMS_PageTemplateCategory] FOREIGN KEY([PageTemplateCategoryID])
REFERENCES [dbo].[CMS_PageTemplateCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_PageTemplate] CHECK CONSTRAINT [FK_CMS_PageTemplate_PageTemplateCategoryID_CMS_PageTemplateCategory]
GO
ALTER TABLE [dbo].[CMS_PageTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_PageTemplate_PageTemplateLayoutID_CMS_Layout] FOREIGN KEY([PageTemplateLayoutID])
REFERENCES [dbo].[CMS_Layout] ([LayoutID])
GO
ALTER TABLE [dbo].[CMS_PageTemplate] CHECK CONSTRAINT [FK_CMS_PageTemplate_PageTemplateLayoutID_CMS_Layout]
GO
ALTER TABLE [dbo].[CMS_PageTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_PageTemplate_PageTemplateSiteID_CMS_Site] FOREIGN KEY([PageTemplateSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_PageTemplate] CHECK CONSTRAINT [FK_CMS_PageTemplate_PageTemplateSiteID_CMS_Site]
GO
