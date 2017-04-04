SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowStep](
	[StepID] [int] IDENTITY(1,1) NOT NULL,
	[StepDisplayName] [nvarchar](450) NOT NULL,
	[StepName] [nvarchar](440) NULL,
	[StepOrder] [int] NULL,
	[StepWorkflowID] [int] NOT NULL,
	[StepGUID] [uniqueidentifier] NOT NULL,
	[StepLastModified] [datetime2](7) NOT NULL,
	[StepType] [int] NULL,
	[StepAllowReject] [bit] NULL,
	[StepDefinition] [nvarchar](max) NULL,
	[StepRolesSecurity] [int] NULL,
	[StepUsersSecurity] [int] NULL,
	[StepApprovedTemplateName] [nvarchar](200) NULL,
	[StepRejectedTemplateName] [nvarchar](200) NULL,
	[StepReadyforApprovalTemplateName] [nvarchar](200) NULL,
	[StepSendApproveEmails] [bit] NULL,
	[StepSendRejectEmails] [bit] NULL,
	[StepSendReadyForApprovalEmails] [bit] NULL,
	[StepSendEmails] [bit] NULL,
	[StepAllowPublish] [bit] NULL,
	[StepActionID] [int] NULL,
	[StepActionParameters] [nvarchar](max) NULL,
	[StepWorkflowType] [int] NULL,
 CONSTRAINT [PK_CMS_WorkflowStep] PRIMARY KEY NONCLUSTERED 
(
	[StepID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_WorkflowStep_StepID_StepName] ON [dbo].[CMS_WorkflowStep]
(
	[StepID] ASC,
	[StepName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowStep_StepActionID] ON [dbo].[CMS_WorkflowStep]
(
	[StepActionID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_WorkflowStep_StepWorkflowID_StepName] ON [dbo].[CMS_WorkflowStep]
(
	[StepWorkflowID] ASC,
	[StepName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowStep_StepWorkflowID_StepOrder] ON [dbo].[CMS_WorkflowStep]
(
	[StepWorkflowID] ASC,
	[StepOrder] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowStep] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowStep_StepAllowReject]  DEFAULT ((1)) FOR [StepAllowReject]
GO
ALTER TABLE [dbo].[CMS_WorkflowStep] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowStep_StepAllowPublish]  DEFAULT ((0)) FOR [StepAllowPublish]
GO
ALTER TABLE [dbo].[CMS_WorkflowStep]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowStep_StepActionID] FOREIGN KEY([StepActionID])
REFERENCES [dbo].[CMS_WorkflowAction] ([ActionID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStep] CHECK CONSTRAINT [FK_CMS_WorkflowStep_StepActionID]
GO
ALTER TABLE [dbo].[CMS_WorkflowStep]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowStep_StepWorkflowID] FOREIGN KEY([StepWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStep] CHECK CONSTRAINT [FK_CMS_WorkflowStep_StepWorkflowID]
GO
