SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowStepRoles](
	[WorkflowStepRoleID] [int] IDENTITY(1,1) NOT NULL,
	[StepID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[StepSourcePointGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_CMS_WorkflowStepRoles] PRIMARY KEY NONCLUSTERED 
(
	[WorkflowStepRoleID] ASC
)
)

GO
CREATE UNIQUE CLUSTERED INDEX [IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID] ON [dbo].[CMS_WorkflowStepRoles]
(
	[StepID] ASC,
	[StepSourcePointGUID] ASC,
	[RoleID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowStepRoles_RoleID] ON [dbo].[CMS_WorkflowStepRoles]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowStepRoles]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowStepRoles_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStepRoles] CHECK CONSTRAINT [FK_CMS_WorkflowStepRoles_RoleID_CMS_Role]
GO
ALTER TABLE [dbo].[CMS_WorkflowStepRoles]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowStepRoles_StepID_CMS_WorkflowStep] FOREIGN KEY([StepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_WorkflowStepRoles] CHECK CONSTRAINT [FK_CMS_WorkflowStepRoles_StepID_CMS_WorkflowStep]
GO
