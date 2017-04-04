SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AutomationState](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[StateStepID] [int] NOT NULL,
	[StateObjectID] [int] NOT NULL,
	[StateObjectType] [nvarchar](100) NOT NULL,
	[StateActionStatus] [nvarchar](450) NULL,
	[StateCreated] [datetime2](7) NULL,
	[StateLastModified] [datetime2](7) NULL,
	[StateWorkflowID] [int] NOT NULL,
	[StateStatus] [int] NULL,
	[StateSiteID] [int] NULL,
	[StateUserID] [int] NULL,
	[StateGUID] [uniqueidentifier] NOT NULL,
	[StateCustomData] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_AutomationState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationState_StateObjectID_StateObjectType] ON [dbo].[CMS_AutomationState]
(
	[StateObjectID] ASC,
	[StateObjectType] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationState_StateSiteID] ON [dbo].[CMS_AutomationState]
(
	[StateSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationState_StateStepID] ON [dbo].[CMS_AutomationState]
(
	[StateStepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationState_StateUserID] ON [dbo].[CMS_AutomationState]
(
	[StateUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AutomationState_StateWorkflowID] ON [dbo].[CMS_AutomationState]
(
	[StateWorkflowID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AutomationState] ADD  CONSTRAINT [DEFAULT_CMS_AutomationState_StateWorkflowID]  DEFAULT ((0)) FOR [StateWorkflowID]
GO
ALTER TABLE [dbo].[CMS_AutomationState] ADD  CONSTRAINT [DEFAULT_CMS_AutomationState_StateGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [StateGUID]
GO
ALTER TABLE [dbo].[CMS_AutomationState]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationState_StateSiteID_CMS_Site] FOREIGN KEY([StateSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_AutomationState] CHECK CONSTRAINT [FK_CMS_AutomationState_StateSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_AutomationState]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationState_StateStepID] FOREIGN KEY([StateStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_AutomationState] CHECK CONSTRAINT [FK_CMS_AutomationState_StateStepID]
GO
ALTER TABLE [dbo].[CMS_AutomationState]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationState_StateUserID_CMS_User] FOREIGN KEY([StateUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_AutomationState] CHECK CONSTRAINT [FK_CMS_AutomationState_StateUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_AutomationState]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AutomationState_StateWorkflowID] FOREIGN KEY([StateWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_AutomationState] CHECK CONSTRAINT [FK_CMS_AutomationState_StateWorkflowID]
GO
