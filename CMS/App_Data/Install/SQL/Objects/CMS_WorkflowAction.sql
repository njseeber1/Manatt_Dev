SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowAction](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionDisplayName] [nvarchar](200) NOT NULL,
	[ActionName] [nvarchar](200) NOT NULL,
	[ActionParameters] [nvarchar](max) NULL,
	[ActionDescription] [nvarchar](max) NULL,
	[ActionAssemblyName] [nvarchar](200) NOT NULL,
	[ActionClass] [nvarchar](200) NOT NULL,
	[ActionResourceID] [int] NULL,
	[ActionThumbnailGUID] [uniqueidentifier] NULL,
	[ActionGUID] [uniqueidentifier] NOT NULL,
	[ActionLastModified] [datetime2](7) NOT NULL,
	[ActionEnabled] [bit] NOT NULL,
	[ActionAllowedObjects] [nvarchar](max) NULL,
	[ActionIconGUID] [uniqueidentifier] NULL,
	[ActionWorkflowType] [int] NULL,
	[ActionIconClass] [nvarchar](200) NULL,
	[ActionThumbnailClass] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_WorkflowAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowAction_ActionResourceID] ON [dbo].[CMS_WorkflowAction]
(
	[ActionResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowAction] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowAction_ActionEnabled]  DEFAULT ((1)) FOR [ActionEnabled]
GO
ALTER TABLE [dbo].[CMS_WorkflowAction]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WorkflowAction_ActionResourceID] FOREIGN KEY([ActionResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_WorkflowAction] CHECK CONSTRAINT [FK_CMS_WorkflowAction_ActionResourceID]
GO
