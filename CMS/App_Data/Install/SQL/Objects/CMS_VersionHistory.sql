SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_VersionHistory](
	[VersionHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[NodeSiteID] [int] NULL,
	[DocumentID] [int] NULL,
	[DocumentNamePath] [nvarchar](450) NOT NULL,
	[NodeXML] [nvarchar](max) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ModifiedWhen] [datetime2](7) NOT NULL,
	[VersionNumber] [nvarchar](50) NULL,
	[VersionComment] [nvarchar](max) NULL,
	[ToBePublished] [bit] NOT NULL,
	[PublishFrom] [datetime2](7) NULL,
	[PublishTo] [datetime2](7) NULL,
	[WasPublishedFrom] [datetime2](7) NULL,
	[WasPublishedTo] [datetime2](7) NULL,
	[VersionDocumentName] [nvarchar](100) NULL,
	[VersionDocumentType] [nvarchar](50) NULL,
	[VersionClassID] [int] NULL,
	[VersionMenuRedirectUrl] [nvarchar](450) NULL,
	[VersionWorkflowID] [int] NULL,
	[VersionWorkflowStepID] [int] NULL,
	[VersionNodeAliasPath] [nvarchar](450) NULL,
	[VersionDeletedByUserID] [int] NULL,
	[VersionDeletedWhen] [datetime2](7) NULL,
 CONSTRAINT [PK_CMS_VersionHistory] PRIMARY KEY NONCLUSTERED 
(
	[VersionHistoryID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_VersionHistory_DocumentID] ON [dbo].[CMS_VersionHistory]
(
	[DocumentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_ModifiedByUserID] ON [dbo].[CMS_VersionHistory]
(
	[ModifiedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_NodeSiteID] ON [dbo].[CMS_VersionHistory]
(
	[NodeSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo] ON [dbo].[CMS_VersionHistory]
(
	[ToBePublished] ASC,
	[PublishFrom] ASC,
	[PublishTo] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_VersionClassID] ON [dbo].[CMS_VersionHistory]
(
	[VersionClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen] ON [dbo].[CMS_VersionHistory]
(
	[VersionDeletedByUserID] ASC,
	[VersionDeletedWhen] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_VersionWorkflowID] ON [dbo].[CMS_VersionHistory]
(
	[VersionWorkflowID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_VersionHistory_VersionWorkflowStepID] ON [dbo].[CMS_VersionHistory]
(
	[VersionWorkflowStepID] ASC
)
GO
ALTER TABLE [dbo].[CMS_VersionHistory] ADD  CONSTRAINT [DEFAULT_CMS_VersionHistory_DocumentNamePath]  DEFAULT (N'') FOR [DocumentNamePath]
GO
ALTER TABLE [dbo].[CMS_VersionHistory] ADD  CONSTRAINT [DF__CMS_Versi__ToBeP__71D1E811]  DEFAULT ((0)) FOR [ToBePublished]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_DeletedByUserID_CMS_User] FOREIGN KEY([VersionDeletedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_DeletedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_ModifiedByUserID_CMS_User] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_ModifiedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_NodeSiteID_CMS_Site] FOREIGN KEY([NodeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_NodeSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_VersionClassID_CMS_Class] FOREIGN KEY([VersionClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_VersionClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_VersionWorkflowID_CMS_Workflow] FOREIGN KEY([VersionWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_VersionWorkflowID_CMS_Workflow]
GO
ALTER TABLE [dbo].[CMS_VersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_VersionHistory_VersionWorkflowStepID_CMS_WorkflowStep] FOREIGN KEY([VersionWorkflowStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_VersionHistory] CHECK CONSTRAINT [FK_CMS_VersionHistory_VersionWorkflowStepID_CMS_WorkflowStep]
GO
