SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messaging_Message](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[MessageSenderUserID] [int] NULL,
	[MessageSenderNickName] [nvarchar](200) NULL,
	[MessageRecipientUserID] [int] NULL,
	[MessageRecipientNickName] [nvarchar](200) NULL,
	[MessageSent] [datetime2](7) NOT NULL,
	[MessageSubject] [nvarchar](200) NULL,
	[MessageBody] [nvarchar](max) NOT NULL,
	[MessageRead] [datetime2](7) NULL,
	[MessageSenderDeleted] [bit] NULL,
	[MessageRecipientDeleted] [bit] NULL,
	[MessageGUID] [uniqueidentifier] NOT NULL,
	[MessageLastModified] [datetime2](7) NOT NULL,
	[MessageIsRead] [bit] NULL,
 CONSTRAINT [PK_Messaging_Message] PRIMARY KEY NONCLUSTERED 
(
	[MessageID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted] ON [dbo].[Messaging_Message]
(
	[MessageRecipientUserID] ASC,
	[MessageSent] DESC,
	[MessageRecipientDeleted] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted] ON [dbo].[Messaging_Message]
(
	[MessageSenderUserID] ASC,
	[MessageSent] ASC,
	[MessageSenderDeleted] ASC
)
GO
ALTER TABLE [dbo].[Messaging_Message] ADD  CONSTRAINT [DEFAULT_Messaging_Message_MessageSenderNickName]  DEFAULT (N'') FOR [MessageSenderNickName]
GO
ALTER TABLE [dbo].[Messaging_Message] ADD  CONSTRAINT [DEFAULT_Messaging_Message_MessageRecipientNickName]  DEFAULT (N'') FOR [MessageRecipientNickName]
GO
ALTER TABLE [dbo].[Messaging_Message] ADD  CONSTRAINT [DEFAULT_Messaging_Message_MessageSubject]  DEFAULT (N'') FOR [MessageSubject]
GO
ALTER TABLE [dbo].[Messaging_Message]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_Message_MessageRecipientUserID_CMS_User] FOREIGN KEY([MessageRecipientUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_Message] CHECK CONSTRAINT [FK_Messaging_Message_MessageRecipientUserID_CMS_User]
GO
ALTER TABLE [dbo].[Messaging_Message]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_Message_MessageSenderUserID_CMS_User] FOREIGN KEY([MessageSenderUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_Message] CHECK CONSTRAINT [FK_Messaging_Message_MessageSenderUserID_CMS_User]
GO
