SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_SupportTakenRoom](
	[ChatSupportTakenRoomID] [int] IDENTITY(1,1) NOT NULL,
	[ChatSupportTakenRoomChatUserID] [int] NULL,
	[ChatSupportTakenRoomRoomID] [int] NOT NULL,
	[ChatSupportTakenRoomResolvedDateTime] [datetime2](7) NULL,
	[ChatSupportTakenRoomLastModification] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Chat_SupportTakenRooms] PRIMARY KEY CLUSTERED 
(
	[ChatSupportTakenRoomID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_SupportTakenRoom_ChatSupportTakenRoomChatUserID] ON [dbo].[Chat_SupportTakenRoom]
(
	[ChatSupportTakenRoomChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_SupportTakenRoom_ChatSupportTakenRoomRoomID] ON [dbo].[Chat_SupportTakenRoom]
(
	[ChatSupportTakenRoomRoomID] ASC
)
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom] ADD  CONSTRAINT [DEFAULT_Chat_SupportTakenRoom_ChatSupportTakenRoomRoomID]  DEFAULT ((0)) FOR [ChatSupportTakenRoomRoomID]
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom] ADD  CONSTRAINT [DEFAULT_Chat_SupportTakenRoom_ChatSupportTakenRoomLastModification]  DEFAULT ('4/16/2012 5:11:30 PM') FOR [ChatSupportTakenRoomLastModification]
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom]  WITH CHECK ADD  CONSTRAINT [FK_Chat_SupportTakenRoom_Chat_Room] FOREIGN KEY([ChatSupportTakenRoomRoomID])
REFERENCES [dbo].[Chat_Room] ([ChatRoomID])
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom] CHECK CONSTRAINT [FK_Chat_SupportTakenRoom_Chat_Room]
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom]  WITH CHECK ADD  CONSTRAINT [FK_Chat_SupportTakenRoom_Chat_User] FOREIGN KEY([ChatSupportTakenRoomChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_SupportTakenRoom] CHECK CONSTRAINT [FK_Chat_SupportTakenRoom_Chat_User]
GO
