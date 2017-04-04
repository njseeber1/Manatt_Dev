SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowUser](
	[WorkflowID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_WorkflowUser_1] PRIMARY KEY CLUSTERED 
(
	[WorkflowID] ASC,
	[UserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowUser_UserID] ON [dbo].[CMS_WorkflowUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowUser_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_WorkflowUser] CHECK CONSTRAINT [FK_CMS_WorkflowUser_UserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_WorkflowUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowUser_WorkflowID_CMS_Workflow] FOREIGN KEY([WorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_WorkflowUser] CHECK CONSTRAINT [FK_CMS_WorkflowUser_WorkflowID_CMS_Workflow]
GO
