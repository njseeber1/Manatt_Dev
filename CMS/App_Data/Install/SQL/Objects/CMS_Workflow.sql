SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Workflow](
	[WorkflowID] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowDisplayName] [nvarchar](450) NOT NULL,
	[WorkflowName] [nvarchar](450) NOT NULL,
	[WorkflowGUID] [uniqueidentifier] NOT NULL,
	[WorkflowLastModified] [datetime2](7) NOT NULL,
	[WorkflowAutoPublishChanges] [bit] NULL,
	[WorkflowUseCheckinCheckout] [bit] NULL,
	[WorkflowType] [int] NULL,
	[WorkflowSendEmails] [bit] NULL,
	[WorkflowSendApproveEmails] [bit] NULL,
	[WorkflowSendRejectEmails] [bit] NULL,
	[WorkflowSendPublishEmails] [bit] NULL,
	[WorkflowSendArchiveEmails] [bit] NULL,
	[WorkflowApprovedTemplateName] [nvarchar](200) NULL,
	[WorkflowRejectedTemplateName] [nvarchar](200) NULL,
	[WorkflowPublishedTemplateName] [nvarchar](200) NULL,
	[WorkflowArchivedTemplateName] [nvarchar](200) NULL,
	[WorkflowSendReadyForApprovalEmails] [bit] NULL,
	[WorkflowReadyForApprovalTemplateName] [nvarchar](200) NULL,
	[WorkflowNotificationTemplateName] [nvarchar](200) NULL,
	[WorkflowAllowedObjects] [nvarchar](max) NULL,
	[WorkflowRecurrenceType] [int] NULL,
	[WorkflowEnabled] [bit] NULL,
 CONSTRAINT [PK_CMS_Workflow] PRIMARY KEY NONCLUSTERED 
(
	[WorkflowID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Workflow_WorkflowDisplayName] ON [dbo].[CMS_Workflow]
(
	[WorkflowDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowDisplayName]  DEFAULT ('') FOR [WorkflowDisplayName]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowName]  DEFAULT ('') FOR [WorkflowName]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowAutoPublishChanges]  DEFAULT ((0)) FOR [WorkflowAutoPublishChanges]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowUseCheckinCheckout]  DEFAULT ((0)) FOR [WorkflowUseCheckinCheckout]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowSendApproveEmails]  DEFAULT ((1)) FOR [WorkflowSendApproveEmails]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowSendRejectEmails]  DEFAULT ((1)) FOR [WorkflowSendRejectEmails]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowSendPublishEmails]  DEFAULT ((1)) FOR [WorkflowSendPublishEmails]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowSendArchiveEmails]  DEFAULT ((1)) FOR [WorkflowSendArchiveEmails]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowSendReadyForApprovalEmails]  DEFAULT ((1)) FOR [WorkflowSendReadyForApprovalEmails]
GO
ALTER TABLE [dbo].[CMS_Workflow] ADD  CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowEnabled]  DEFAULT ((1)) FOR [WorkflowEnabled]
GO
