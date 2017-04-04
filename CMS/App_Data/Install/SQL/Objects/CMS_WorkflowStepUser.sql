SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowStepUser](
	[WorkflowStepUserID] [int] IDENTITY(1,1) NOT NULL,
	[StepID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[StepSourcePointGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_CMS_WorkflowStepUser] PRIMARY KEY NONCLUSTERED 
(
	[WorkflowStepUserID] ASC
)
)

GO
CREATE UNIQUE CLUSTERED INDEX [IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID] ON [dbo].[CMS_WorkflowStepUser]
(
	[StepID] ASC,
	[StepSourcePointGUID] ASC,
	[UserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowStepUser_UserID] ON [dbo].[CMS_WorkflowStepUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowStepUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowStepUser_StepID_CMS_WorkflowStep] FOREIGN KEY([StepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStepUser] CHECK CONSTRAINT [FK_CMS_WorkflowStepUser_StepID_CMS_WorkflowStep]
GO
ALTER TABLE [dbo].[CMS_WorkflowStepUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowStepUser_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStepUser] CHECK CONSTRAINT [FK_CMS_WorkflowStepUser_UserID_CMS_User]
GO
