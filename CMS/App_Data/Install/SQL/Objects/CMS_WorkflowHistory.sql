SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowHistory](
	[WorkflowHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[VersionHistoryID] [int] NOT NULL,
	[StepID] [int] NULL,
	[StepDisplayName] [nvarchar](450) NOT NULL,
	[ApprovedByUserID] [int] NULL,
	[ApprovedWhen] [datetime2](7) NULL,
	[Comment] [nvarchar](max) NULL,
	[WasRejected] [bit] NOT NULL,
	[StepName] [nvarchar](440) NULL,
	[TargetStepID] [int] NULL,
	[TargetStepName] [nvarchar](440) NULL,
	[TargetStepDisplayName] [nvarchar](450) NULL,
	[StepType] [int] NULL,
	[TargetStepType] [int] NULL,
	[HistoryObjectType] [nvarchar](100) NULL,
	[HistoryObjectID] [int] NULL,
	[HistoryTransitionType] [int] NULL,
	[HistoryWorkflowID] [int] NULL,
	[HistoryRejected] [bit] NULL,
 CONSTRAINT [PK_CMS_WorkflowHistory] PRIMARY KEY CLUSTERED 
(
	[WorkflowHistoryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_ApprovedByUserID] ON [dbo].[CMS_WorkflowHistory]
(
	[ApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_ApprovedWhen] ON [dbo].[CMS_WorkflowHistory]
(
	[ApprovedWhen] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_HistoryWorkflowID] ON [dbo].[CMS_WorkflowHistory]
(
	[HistoryWorkflowID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_StepID] ON [dbo].[CMS_WorkflowHistory]
(
	[StepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_TargetStepID] ON [dbo].[CMS_WorkflowHistory]
(
	[TargetStepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowHistory_VersionHistoryID] ON [dbo].[CMS_WorkflowHistory]
(
	[VersionHistoryID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowHistory_HistoryRejected]  DEFAULT ((0)) FOR [HistoryRejected]
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowHistory_ApprovedByUserID_CMS_User] FOREIGN KEY([ApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] CHECK CONSTRAINT [FK_CMS_WorkflowHistory_ApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowHistory_HistoryWorkflowID_CMS_Workflow] FOREIGN KEY([HistoryWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] CHECK CONSTRAINT [FK_CMS_WorkflowHistory_HistoryWorkflowID_CMS_Workflow]
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowHistory_StepID_CMS_WorkflowStep] FOREIGN KEY([StepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] CHECK CONSTRAINT [FK_CMS_WorkflowHistory_StepID_CMS_WorkflowStep]
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowHistory_TargetStepID_CMS_WorkflowStep] FOREIGN KEY([TargetStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] CHECK CONSTRAINT [FK_CMS_WorkflowHistory_TargetStepID_CMS_WorkflowStep]
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowHistory_VersionHistoryID_CMS_VersionHistory] FOREIGN KEY([VersionHistoryID])
REFERENCES [dbo].[CMS_VersionHistory] ([VersionHistoryID])
GO
ALTER TABLE [dbo].[CMS_WorkflowHistory] CHECK CONSTRAINT [FK_CMS_WorkflowHistory_VersionHistoryID_CMS_VersionHistory]
GO
