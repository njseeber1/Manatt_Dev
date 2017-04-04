SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_RoomUser](
	[ChatRoomUserID] [int] IDENTITY(1,1) NOT NULL,
	[ChatRoomUserRoomID] [int] NOT NULL,
	[ChatRoomUserChatUserID] [int] NOT NULL,
	[ChatRoomUserLastChecking] [datetime2](7) NULL,
	[ChatRoomUserKickExpiration] [datetime2](7) NULL,
	[ChatRoomUserJoinTime] [datetime2](7) NULL,
	[ChatRoomUserLeaveTime] [datetime2](7) NULL,
	[ChatRoomUserAdminLevel] [int] NOT NULL,
	[ChatRoomUserLastModification] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_ChatRoomUser] PRIMARY KEY CLUSTERED 
(
	[ChatRoomUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_RoomUser_ChatRoomUserChatUserID] ON [dbo].[Chat_RoomUser]
(
	[ChatRoomUserChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_RoomUser_ChatRoomUserRoomID] ON [dbo].[Chat_RoomUser]
(
	[ChatRoomUserRoomID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Chat_RoomUser_RoomID-ChatUserID] ON [dbo].[Chat_RoomUser]
(
	[ChatRoomUserRoomID] ASC,
	[ChatRoomUserChatUserID] ASC
)
GO
ALTER TABLE [dbo].[Chat_RoomUser] ADD  CONSTRAINT [DEFAULT_Chat_RoomUser_ChatRoomUserRoomID]  DEFAULT ((0)) FOR [ChatRoomUserRoomID]
GO
ALTER TABLE [dbo].[Chat_RoomUser] ADD  CONSTRAINT [DEFAULT_Chat_RoomUser_ChatRoomUserChatUserID]  DEFAULT ((0)) FOR [ChatRoomUserChatUserID]
GO
ALTER TABLE [dbo].[Chat_RoomUser] ADD  CONSTRAINT [DEFAULT_Chat_RoomUser_ChatRoomUserAdminLevel]  DEFAULT ((0)) FOR [ChatRoomUserAdminLevel]
GO
ALTER TABLE [dbo].[Chat_RoomUser] ADD  CONSTRAINT [DEFAULT_Chat_RoomUser_ChatRoomUserLastModification]  DEFAULT ('11/10/2011 3:29:00 PM') FOR [ChatRoomUserLastModification]
GO
ALTER TABLE [dbo].[Chat_RoomUser]  WITH CHECK ADD  CONSTRAINT [FK_Chat_RoomUser_Chat_Room] FOREIGN KEY([ChatRoomUserRoomID])
REFERENCES [dbo].[Chat_Room] ([ChatRoomID])
GO
ALTER TABLE [dbo].[Chat_RoomUser] CHECK CONSTRAINT [FK_Chat_RoomUser_Chat_Room]
GO
ALTER TABLE [dbo].[Chat_RoomUser]  WITH CHECK ADD  CONSTRAINT [FK_Chat_RoomUser_Chat_User] FOREIGN KEY([ChatRoomUserChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_RoomUser] CHECK CONSTRAINT [FK_Chat_RoomUser_Chat_User]
GO
