SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ObjectSettings](
	[ObjectSettingsID] [int] IDENTITY(1,1) NOT NULL,
	[ObjectTags] [nvarchar](max) NULL,
	[ObjectCheckedOutByUserID] [int] NULL,
	[ObjectCheckedOutWhen] [datetime2](7) NULL,
	[ObjectCheckedOutVersionHistoryID] [int] NULL,
	[ObjectWorkflowStepID] [int] NULL,
	[ObjectPublishedVersionHistoryID] [int] NULL,
	[ObjectSettingsObjectID] [int] NOT NULL,
	[ObjectSettingsObjectType] [nvarchar](100) NOT NULL,
	[ObjectComments] [nvarchar](max) NULL,
	[ObjectWorkflowSendEmails] [bit] NULL,
 CONSTRAINT [PK_CMS_ObjectSettings] PRIMARY KEY CLUSTERED 
(
	[ObjectSettingsID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectSettings_ObjectCheckedOutByUserID] ON [dbo].[CMS_ObjectSettings]
(
	[ObjectCheckedOutByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectSettings_ObjectCheckedOutVersionHistoryID] ON [dbo].[CMS_ObjectSettings]
(
	[ObjectCheckedOutVersionHistoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectSettings_ObjectPublishedVersionHistoryID] ON [dbo].[CMS_ObjectSettings]
(
	[ObjectPublishedVersionHistoryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID] ON [dbo].[CMS_ObjectSettings]
(
	[ObjectSettingsObjectID] ASC,
	[ObjectSettingsObjectType] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectSettings_ObjectWorkflowStepID] ON [dbo].[CMS_ObjectSettings]
(
	[ObjectWorkflowStepID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] ADD  CONSTRAINT [DEFAULT_CMS_ObjectSettings_ObjectSettingsObjectID]  DEFAULT ((0)) FOR [ObjectSettingsObjectID]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] ADD  CONSTRAINT [DEFAULT_CMS_ObjectSettings_ObjectSettingsObjectType]  DEFAULT ('') FOR [ObjectSettingsObjectType]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] ADD  CONSTRAINT [DEFAULT_CMS_ObjectSettings_ObjectWorkflowSendEmails]  DEFAULT ((1)) FOR [ObjectWorkflowSendEmails]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectSettings_ObjectCheckedOutByUserID_CMS_User] FOREIGN KEY([ObjectCheckedOutByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] CHECK CONSTRAINT [FK_CMS_ObjectSettings_ObjectCheckedOutByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectSettings_ObjectCheckedOutVersionHistoryID_CMS_ObjectVersionHistory] FOREIGN KEY([ObjectCheckedOutVersionHistoryID])
REFERENCES [dbo].[CMS_ObjectVersionHistory] ([VersionID])
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] CHECK CONSTRAINT [FK_CMS_ObjectSettings_ObjectCheckedOutVersionHistoryID_CMS_ObjectVersionHistory]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectSettings_ObjectPublishedVersionHistoryID_CMS_ObjectVersionHistory] FOREIGN KEY([ObjectPublishedVersionHistoryID])
REFERENCES [dbo].[CMS_ObjectVersionHistory] ([VersionID])
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] CHECK CONSTRAINT [FK_CMS_ObjectSettings_ObjectPublishedVersionHistoryID_CMS_ObjectVersionHistory]
GO
ALTER TABLE [dbo].[CMS_ObjectSettings]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectSettings_ObjectWorkflowStepID_CMS_WorkflowStep] FOREIGN KEY([ObjectWorkflowStepID])
REFERENCES [dbo].[CMS_WorkflowStep] ([StepID])
GO
ALTER TABLE [dbo].[CMS_ObjectSettings] CHECK CONSTRAINT [FK_CMS_ObjectSettings_ObjectWorkflowStepID_CMS_WorkflowStep]
GO
