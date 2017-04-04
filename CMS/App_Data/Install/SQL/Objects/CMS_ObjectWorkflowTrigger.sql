SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ObjectWorkflowTrigger](
	[TriggerID] [int] IDENTITY(1,1) NOT NULL,
	[TriggerGUID] [uniqueidentifier] NOT NULL,
	[TriggerLastModified] [datetime2](7) NOT NULL,
	[TriggerType] [int] NOT NULL,
	[TriggerMacroCondition] [nvarchar](max) NULL,
	[TriggerWorkflowID] [int] NOT NULL,
	[TriggerSiteID] [int] NULL,
	[TriggerDisplayName] [nvarchar](450) NOT NULL,
	[TriggerObjectType] [nvarchar](100) NOT NULL,
	[TriggerParameters] [nvarchar](max) NULL,
	[TriggerTargetObjectType] [nvarchar](100) NULL,
	[TriggerTargetObjectID] [int] NULL,
 CONSTRAINT [PK_CMS_ObjectWorkflowTrigger] PRIMARY KEY CLUSTERED 
(
	[TriggerID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectWorkflowTrigger_TriggerSiteID] ON [dbo].[CMS_ObjectWorkflowTrigger]
(
	[TriggerSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectWorkflowTrigger_TriggerWorkflowID] ON [dbo].[CMS_ObjectWorkflowTrigger]
(
	[TriggerWorkflowID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] ADD  CONSTRAINT [DEFAULT_CMS_ObjectWorkflowTrigger_TriggerType]  DEFAULT ((0)) FOR [TriggerType]
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] ADD  CONSTRAINT [DEFAULT_CMS_ObjectWorkflowTrigger_TriggerWorkflowID]  DEFAULT ((0)) FOR [TriggerWorkflowID]
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] ADD  CONSTRAINT [DEFAULT_CMS_ObjectWorkflowTrigger_TriggerDisplayName]  DEFAULT ('') FOR [TriggerDisplayName]
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] ADD  CONSTRAINT [DEFAULT_CMS_ObjectWorkflowTrigger_TriggerObjectType]  DEFAULT ('') FOR [TriggerObjectType]
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectWorkflowTrigger_TriggerSiteID] FOREIGN KEY([TriggerSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] CHECK CONSTRAINT [FK_CMS_ObjectWorkflowTrigger_TriggerSiteID]
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectWorkflowTrigger_TriggerWorkflowID] FOREIGN KEY([TriggerWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_ObjectWorkflowTrigger] CHECK CONSTRAINT [FK_CMS_ObjectWorkflowTrigger_TriggerWorkflowID]
GO
