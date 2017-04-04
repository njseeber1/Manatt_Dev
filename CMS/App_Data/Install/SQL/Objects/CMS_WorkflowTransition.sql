SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowTransition](
	[TransitionID] [int] IDENTITY(1,1) NOT NULL,
	[TransitionStartStepID] [int] NOT NULL,
	[TransitionEndStepID] [int] NOT NULL,
	[TransitionType] [int] NOT NULL,
	[TransitionLastModified] [datetime2](7) NOT NULL,
	[TransitionSourcePointGUID] [uniqueidentifier] NULL,
	[TransitionWorkflowID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_WorkflowTransition] PRIMARY KEY CLUSTERED 
(
	[TransitionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowTransition_TransitionEndStepID] ON [dbo].[CMS_WorkflowTransition]
(
	[TransitionEndStepID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID] ON [dbo].[CMS_WorkflowTransition]
(
	[TransitionStartStepID] ASC,
	[TransitionSourcePointGUID] ASC,
	[TransitionEndStepID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowTransition_TransitionWorkflowID] ON [dbo].[CMS_WorkflowTransition]
(
	[TransitionWorkflowID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowTransition_TransitionWorkflowID]  DEFAULT ((0)) FOR [TransitionWorkflowID]
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowTransition_TransitionEndStepID_CMS_WorkflowStep] FOREIGN KEY([TransitionEndStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition] CHECK CONSTRAINT [FK_CMS_WorkflowTransition_TransitionEndStepID_CMS_WorkflowStep]
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowTransition_TransitionStartStepID_CMS_WorkflowStep] FOREIGN KEY([TransitionStartStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition] CHECK CONSTRAINT [FK_CMS_WorkflowTransition_TransitionStartStepID_CMS_WorkflowStep]
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowTransition_TransitionWorkflowID_CMS_Workflow] FOREIGN KEY([TransitionWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_WorkflowTransition] CHECK CONSTRAINT [FK_CMS_WorkflowTransition_TransitionWorkflowID_CMS_Workflow]
GO
