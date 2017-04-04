SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Document](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [nvarchar](100) NOT NULL,
	[DocumentNamePath] [nvarchar](1500) NULL,
	[DocumentModifiedWhen] [datetime2](7) NULL,
	[DocumentModifiedByUserID] [int] NULL,
	[DocumentForeignKeyValue] [int] NULL,
	[DocumentCreatedByUserID] [int] NULL,
	[DocumentCreatedWhen] [datetime2](7) NULL,
	[DocumentCheckedOutByUserID] [int] NULL,
	[DocumentCheckedOutWhen] [datetime2](7) NULL,
	[DocumentCheckedOutVersionHistoryID] [int] NULL,
	[DocumentPublishedVersionHistoryID] [int] NULL,
	[DocumentWorkflowStepID] [int] NULL,
	[DocumentPublishFrom] [datetime2](7) NULL,
	[DocumentPublishTo] [datetime2](7) NULL,
	[DocumentUrlPath] [nvarchar](450) NULL,
	[DocumentCulture] [nvarchar](10) NOT NULL,
	[DocumentNodeID] [int] NOT NULL,
	[DocumentPageTitle] [nvarchar](max) NULL,
	[DocumentPageKeyWords] [nvarchar](max) NULL,
	[DocumentPageDescription] [nvarchar](max) NULL,
	[DocumentShowInSiteMap] [bit] NOT NULL,
	[DocumentMenuItemHideInNavigation] [bit] NOT NULL,
	[DocumentMenuCaption] [nvarchar](200) NULL,
	[DocumentMenuStyle] [nvarchar](100) NULL,
	[DocumentMenuItemImage] [nvarchar](200) NULL,
	[DocumentMenuItemLeftImage] [nvarchar](200) NULL,
	[DocumentMenuItemRightImage] [nvarchar](200) NULL,
	[DocumentPageTemplateID] [int] NULL,
	[DocumentMenuJavascript] [nvarchar](450) NULL,
	[DocumentMenuRedirectUrl] [nvarchar](450) NULL,
	[DocumentUseNamePathForUrlPath] [bit] NULL,
	[DocumentStylesheetID] [int] NULL,
	[DocumentContent] [nvarchar](max) NULL,
	[DocumentMenuClass] [nvarchar](100) NULL,
	[DocumentMenuStyleHighlighted] [nvarchar](200) NULL,
	[DocumentMenuClassHighlighted] [nvarchar](100) NULL,
	[DocumentMenuItemImageHighlighted] [nvarchar](200) NULL,
	[DocumentMenuItemLeftImageHighlighted] [nvarchar](200) NULL,
	[DocumentMenuItemRightImageHighlighted] [nvarchar](200) NULL,
	[DocumentMenuItemInactive] [bit] NULL,
	[DocumentCustomData] [nvarchar](max) NULL,
	[DocumentExtensions] [nvarchar](100) NULL,
	[DocumentTags] [nvarchar](max) NULL,
	[DocumentTagGroupID] [int] NULL,
	[DocumentWildcardRule] [nvarchar](440) NULL,
	[DocumentWebParts] [nvarchar](max) NULL,
	[DocumentRatingValue] [float] NULL,
	[DocumentRatings] [int] NULL,
	[DocumentPriority] [int] NULL,
	[DocumentType] [nvarchar](50) NULL,
	[DocumentLastPublished] [datetime2](7) NULL,
	[DocumentUseCustomExtensions] [bit] NULL,
	[DocumentGroupWebParts] [nvarchar](max) NULL,
	[DocumentCheckedOutAutomatically] [bit] NULL,
	[DocumentTrackConversionName] [nvarchar](200) NULL,
	[DocumentConversionValue] [nvarchar](100) NULL,
	[DocumentSearchExcluded] [bit] NULL,
	[DocumentLastVersionNumber] [nvarchar](50) NULL,
	[DocumentIsArchived] [bit] NULL,
	[DocumentHash] [nvarchar](32) NULL,
	[DocumentLogVisitActivity] [bit] NULL,
	[DocumentGUID] [uniqueidentifier] NULL,
	[DocumentWorkflowCycleGUID] [uniqueidentifier] NULL,
	[DocumentSitemapSettings] [nvarchar](100) NULL,
	[DocumentIsWaitingForTranslation] [bit] NULL,
	[DocumentSKUName] [nvarchar](440) NULL,
	[DocumentSKUDescription] [nvarchar](max) NULL,
	[DocumentSKUShortDescription] [nvarchar](max) NULL,
	[DocumentWorkflowActionStatus] [nvarchar](450) NULL,
	[DocumentMenuRedirectToFirstChild] [bit] NULL,
	[DocumentCanBePublished] [bit] NOT NULL,
	[DocumentInheritsStylesheet] [bit] NOT NULL,
 CONSTRAINT [PK_CMS_Document] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentCheckedOutByUserID] ON [dbo].[CMS_Document]
(
	[DocumentCheckedOutByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentCheckedOutVersionHistoryID] ON [dbo].[CMS_Document]
(
	[DocumentCheckedOutVersionHistoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentCreatedByUserID] ON [dbo].[CMS_Document]
(
	[DocumentCreatedByUserID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentCulture] ON [dbo].[CMS_Document]
(
	[DocumentCulture] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID] ON [dbo].[CMS_Document]
(
	[DocumentForeignKeyValue] ASC,
	[DocumentID] ASC,
	[DocumentNodeID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentModifiedByUserID] ON [dbo].[CMS_Document]
(
	[DocumentModifiedByUserID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture] ON [dbo].[CMS_Document]
(
	[DocumentNodeID] ASC,
	[DocumentID] ASC,
	[DocumentCulture] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentPageTemplateID] ON [dbo].[CMS_Document]
(
	[DocumentPageTemplateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentPublishedVersionHistoryID] ON [dbo].[CMS_Document]
(
	[DocumentPublishedVersionHistoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentTagGroupID] ON [dbo].[CMS_Document]
(
	[DocumentTagGroupID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID] ON [dbo].[CMS_Document]
(
	[DocumentUrlPath] ASC
)
INCLUDE ( 	[DocumentID],
	[DocumentNodeID])
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentWildcardRule_DocumentPriority] ON [dbo].[CMS_Document]
(
	[DocumentWildcardRule] ASC,
	[DocumentPriority] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_DocumentWorkflowStepID] ON [dbo].[CMS_Document]
(
	[DocumentWorkflowStepID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Document] ADD  CONSTRAINT [DEFAULT_CMS_Document_DocumentUseCustomExtensions]  DEFAULT ((0)) FOR [DocumentUseCustomExtensions]
GO
ALTER TABLE [dbo].[CMS_Document] ADD  CONSTRAINT [DEFAULT_CMS_Document_DocumentMenuRedirectToFirstChild]  DEFAULT ((0)) FOR [DocumentMenuRedirectToFirstChild]
GO
ALTER TABLE [dbo].[CMS_Document] ADD  CONSTRAINT [DEFAULT_CMS_Document_DocumentCanBePublished]  DEFAULT ((1)) FOR [DocumentCanBePublished]
GO
ALTER TABLE [dbo].[CMS_Document] ADD  CONSTRAINT [DEFAULT_CMS_Document_DocumentInheritsStylesheet]  DEFAULT ((1)) FOR [DocumentInheritsStylesheet]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentCheckedOutByUserID_CMS_User] FOREIGN KEY([DocumentCheckedOutByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentCheckedOutByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentCheckedOutVersionHistoryID_CMS_VersionHistory] FOREIGN KEY([DocumentCheckedOutVersionHistoryID])
REFERENCES [dbo].[CMS_VersionHistory] ([VersionHistoryID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentCheckedOutVersionHistoryID_CMS_VersionHistory]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentCreatedByUserID_CMS_User] FOREIGN KEY([DocumentCreatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentCreatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentModifiedByUserID_CMS_User] FOREIGN KEY([DocumentModifiedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentModifiedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentNodeID_CMS_Tree] FOREIGN KEY([DocumentNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentNodeID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentPageTemplateID_CMS_Template] FOREIGN KEY([DocumentPageTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentPageTemplateID_CMS_Template]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentPublishedVersionHistoryID_CMS_VersionHistory] FOREIGN KEY([DocumentPublishedVersionHistoryID])
REFERENCES [dbo].[CMS_VersionHistory] ([VersionHistoryID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentPublishedVersionHistoryID_CMS_VersionHistory]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentStylesheetID_CMS_CssStylesheet] FOREIGN KEY([DocumentStylesheetID])
REFERENCES [dbo].[CMS_CssStylesheet] ([StylesheetID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentStylesheetID_CMS_CssStylesheet]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentTagGroupID_CMS_TagGroup] FOREIGN KEY([DocumentTagGroupID])
REFERENCES [dbo].[CMS_TagGroup] ([TagGroupID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentTagGroupID_CMS_TagGroup]
GO
ALTER TABLE [dbo].[CMS_Document]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Document_DocumentWorkflowStepID_CMS_WorkflowStep] FOREIGN KEY([DocumentWorkflowStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_Document] CHECK CONSTRAINT [FK_CMS_Document_DocumentWorkflowStepID_CMS_WorkflowStep]
GO
