SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_Message](
	[ChatMessageID] [int] IDENTITY(1,1) NOT NULL,
	[ChatMessageCreatedWhen] [datetime2](7) NOT NULL,
	[ChatMessageIPAddress] [nvarchar](max) NOT NULL,
	[ChatMessageUserID] [int] NULL,
	[ChatMessageRoomID] [int] NOT NULL,
	[ChatMessageRejected] [bit] NOT NULL,
	[ChatMessageLastModified] [datetime2](7) NOT NULL,
	[ChatMessageText] [nvarchar](max) NOT NULL,
	[ChatMessageSystemMessageType] [int] NOT NULL,
	[ChatMessageRecipientID] [int] NULL,
 CONSTRAINT [PK_CMS_ChatMessage] PRIMARY KEY CLUSTERED 
(
	[ChatMessageID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_Message_ChatMessageLastModified] ON [dbo].[Chat_Message]
(
	[ChatMessageLastModified] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Message_ChatMessageRecipientID] ON [dbo].[Chat_Message]
(
	[ChatMessageRecipientID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Message_ChatMessageRoomID] ON [dbo].[Chat_Message]
(
	[ChatMessageRoomID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Message_ChatMessageSystemMessageType] ON [dbo].[Chat_Message]
(
	[ChatMessageSystemMessageType] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Message_ChatMessageUserID] ON [dbo].[Chat_Message]
(
	[ChatMessageUserID] ASC
)
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageCreatedWhen]  DEFAULT ('7/25/2011 2:47:18 PM') FOR [ChatMessageCreatedWhen]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageIPAddress]  DEFAULT ('') FOR [ChatMessageIPAddress]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageRoomID]  DEFAULT ((0)) FOR [ChatMessageRoomID]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageRejected]  DEFAULT ((0)) FOR [ChatMessageRejected]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageLastModified]  DEFAULT ('8/3/2011 11:24:54 AM') FOR [ChatMessageLastModified]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageText]  DEFAULT ('') FOR [ChatMessageText]
GO
ALTER TABLE [dbo].[Chat_Message] ADD  CONSTRAINT [DEFAULT_CMS_ChatMessage_ChatMessageSystemMessageType]  DEFAULT ((0)) FOR [ChatMessageSystemMessageType]
GO
ALTER TABLE [dbo].[Chat_Message]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Message_Chat_Room] FOREIGN KEY([ChatMessageRoomID])
REFERENCES [dbo].[Chat_Room] ([ChatRoomID])
GO
ALTER TABLE [dbo].[Chat_Message] CHECK CONSTRAINT [FK_Chat_Message_Chat_Room]
GO
ALTER TABLE [dbo].[Chat_Message]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Message_Chat_User_Recipient] FOREIGN KEY([ChatMessageRecipientID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_Message] CHECK CONSTRAINT [FK_Chat_Message_Chat_User_Recipient]
GO
ALTER TABLE [dbo].[Chat_Message]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Message_Chat_User_Sender] FOREIGN KEY([ChatMessageUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_Message] CHECK CONSTRAINT [FK_Chat_Message_Chat_User_Sender]
GO
