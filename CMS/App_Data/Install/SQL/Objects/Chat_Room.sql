SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_Room](
	[ChatRoomID] [int] IDENTITY(1,1) NOT NULL,
	[ChatRoomName] [nvarchar](100) NOT NULL,
	[ChatRoomDisplayName] [nvarchar](100) NOT NULL,
	[ChatRoomSiteID] [int] NULL,
	[ChatRoomEnabled] [bit] NOT NULL,
	[ChatRoomPrivate] [bit] NOT NULL,
	[ChatRoomAllowAnonym] [bit] NOT NULL,
	[ChatRoomCreatedWhen] [datetime2](7) NOT NULL,
	[ChatRoomPassword] [nvarchar](100) NULL,
	[ChatRoomCreatedByChatUserID] [int] NULL,
	[ChatRoomIsSupport] [bit] NOT NULL,
	[ChatRoomIsOneToOne] [bit] NOT NULL,
	[ChatRoomDescription] [nvarchar](500) NULL,
	[ChatRoomLastModification] [datetime2](7) NOT NULL,
	[ChatRoomScheduledToDelete] [datetime2](7) NULL,
	[ChatRoomPrivateStateLastModification] [datetime2](7) NOT NULL,
	[ChatRoomGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CMS_ChatRoom] PRIMARY KEY CLUSTERED 
(
	[ChatRoomID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_Room_ChatRoomCreatedByChatUserID] ON [dbo].[Chat_Room]
(
	[ChatRoomCreatedByChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Room_Enabled] ON [dbo].[Chat_Room]
(
	[ChatRoomEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Room_IsSupport] ON [dbo].[Chat_Room]
(
	[ChatRoomIsSupport] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Room_SiteID] ON [dbo].[Chat_Room]
(
	[ChatRoomSiteID] ASC
)
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_CMS_ChatRoom_ChatRoomDisplayName]  DEFAULT ('') FOR [ChatRoomDisplayName]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_CMS_ChatRoom_ChatRoomPrivate]  DEFAULT ((0)) FOR [ChatRoomPrivate]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_CMS_ChatRoom_ChatRoomIsSupport]  DEFAULT ((0)) FOR [ChatRoomIsSupport]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_CMS_ChatRoom_ChatRoomIsOneToOne]  DEFAULT ((0)) FOR [ChatRoomIsOneToOne]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_Chat_Room_ChatRoomLastModification]  DEFAULT ('10/19/2011 12:16:33 PM') FOR [ChatRoomLastModification]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_Chat_Room_ChatRoomPrivateStateLastModification]  DEFAULT ('1/30/2012 4:36:47 PM') FOR [ChatRoomPrivateStateLastModification]
GO
ALTER TABLE [dbo].[Chat_Room] ADD  CONSTRAINT [DEFAULT_Chat_Room_ChatRoomGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ChatRoomGUID]
GO
ALTER TABLE [dbo].[Chat_Room]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Room_Chat_User] FOREIGN KEY([ChatRoomCreatedByChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_Room] CHECK CONSTRAINT [FK_Chat_Room_Chat_User]
GO
ALTER TABLE [dbo].[Chat_Room]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Room_CMS_Site] FOREIGN KEY([ChatRoomSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Chat_Room] CHECK CONSTRAINT [FK_Chat_Room_CMS_Site]
GO
