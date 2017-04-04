SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AutomationHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryStepID] [int] NULL,
	[HistoryStepName] [nvarchar](440) NULL,
	[HistoryStepDisplayName] [nvarchar](450) NOT NULL,
	[HistoryStepType] [int] NULL,
	[HistoryTargetStepID] [int] NULL,
	[HistoryTargetStepName] [nvarchar](440) NULL,
	[HistoryTargetStepDisplayName] [nvarchar](450) NULL,
	[HistoryTargetStepType] [int] NULL,
	[HistoryApprovedByUserID] [int] NULL,
	[HistoryApprovedWhen] [datetime2](7) NULL,
	[HistoryComment] [nvarchar](max) NULL,
	[HistoryTransitionType] [int] NULL,
	[HistoryWorkflowID] [int] NOT NULL,
	[HistoryRejected] [bit] NULL,
	[HistoryWasRejected] [bit] NOT NULL,
	[HistoryStateID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_AutomationHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryApprovedByUserID] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryApprovedWhen] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryApprovedWhen] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryStateID] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryStateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryStepID] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryStepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryTargetStepID] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryTargetStepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationHistory_HistoryWorkflowID] ON [dbo].[CMS_AutomationHistory]
(
	[HistoryWorkflowID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] ADD  CONSTRAINT [DEFAULT_CMS_AutomationHistory_HistoryStepDisplayName]  DEFAULT ('') FOR [HistoryStepDisplayName]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] ADD  CONSTRAINT [DEFAULT_CMS_AutomationHistory_HistoryWorkflowID]  DEFAULT ((0)) FOR [HistoryWorkflowID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] ADD  CONSTRAINT [DEFAULT_CMS_AutomationHistory_HistoryRejected]  DEFAULT ((0)) FOR [HistoryRejected]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] ADD  CONSTRAINT [DEFAULT_CMS_AutomationHistory_HistoryWasRejected]  DEFAULT ((0)) FOR [HistoryWasRejected]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] ADD  CONSTRAINT [DEFAULT_CMS_AutomationHistory_HistoryStateID]  DEFAULT ((0)) FOR [HistoryStateID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationHistory_HistoryApprovedByUserID] FOREIGN KEY([HistoryApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] CHECK CONSTRAINT [FK_CMS_AutomationHistory_HistoryApprovedByUserID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationHistory_HistoryStateID] FOREIGN KEY([HistoryStateID])
REFERENCES [dbo].[CMS_AutomationState] ([StateID])
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] CHECK CONSTRAINT [FK_CMS_AutomationHistory_HistoryStateID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationHistory_HistoryStepID] FOREIGN KEY([HistoryStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] CHECK CONSTRAINT [FK_CMS_AutomationHistory_HistoryStepID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationHistory_HistoryTargetStepID] FOREIGN KEY([HistoryTargetStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] CHECK CONSTRAINT [FK_CMS_AutomationHistory_HistoryTargetStepID]
GO
ALTER TABLE [dbo].[CMS_AutomationHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationHistory_HistoryWorkflowID] FOREIGN KEY([HistoryWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_AutomationHistory] CHECK CONSTRAINT [FK_CMS_AutomationHistory_HistoryWorkflowID]
GO
