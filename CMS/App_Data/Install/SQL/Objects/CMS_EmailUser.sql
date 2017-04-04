SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_EmailUser](
	[EmailID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[LastSendResult] [nvarchar](max) NULL,
	[LastSendAttempt] [datetime2](7) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_CMS_EmailUser] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC,
	[UserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_EmailUser_Status] ON [dbo].[CMS_EmailUser]
(
	[Status] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_EmailUser_UserID] ON [dbo].[CMS_EmailUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_EmailUser] ADD  CONSTRAINT [DEFAULT_CMS_EmailRole_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[CMS_EmailUser]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_EmailUser_EmailID_CMS_Email] FOREIGN KEY([EmailID])
REFERENCES [dbo].[CMS_Email] ([EmailID])
GO
ALTER TABLE [dbo].[CMS_EmailUser] CHECK CONSTRAINT [FK_CMS_EmailUser_EmailID_CMS_Email]
GO
ALTER TABLE [dbo].[CMS_EmailUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_EmailUser_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_EmailUser] CHECK CONSTRAINT [FK_CMS_EmailUser_UserID_CMS_User]
GO
