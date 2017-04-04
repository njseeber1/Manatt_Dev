SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_Notification](
	[ChatNotificationID] [int] IDENTITY(1,1) NOT NULL,
	[ChatNotificationSenderID] [int] NOT NULL,
	[ChatNotificationReceiverID] [int] NOT NULL,
	[ChatNotificationIsRead] [bit] NOT NULL,
	[ChatNotificationType] [int] NOT NULL,
	[ChatNotificationRoomID] [int] NULL,
	[ChatNotificationSendDateTime] [datetime2](7) NOT NULL,
	[ChatNotificationReadDateTime] [datetime2](7) NULL,
	[ChatNotificationSiteID] [int] NULL,
 CONSTRAINT [PK_CMS_ChatNotification] PRIMARY KEY CLUSTERED 
(
	[ChatNotificationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_Notification_ChatNotificationReceiverID] ON [dbo].[Chat_Notification]
(
	[ChatNotificationReceiverID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Notification_ChatNotificationRoomID] ON [dbo].[Chat_Notification]
(
	[ChatNotificationRoomID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Notification_ChatNotificationSenderID] ON [dbo].[Chat_Notification]
(
	[ChatNotificationSenderID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_Notification_ChatNotificationSiteID] ON [dbo].[Chat_Notification]
(
	[ChatNotificationSiteID] ASC
)
GO
ALTER TABLE [dbo].[Chat_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Notification_Chat_Room] FOREIGN KEY([ChatNotificationRoomID])
REFERENCES [dbo].[Chat_Room] ([ChatRoomID])
GO
ALTER TABLE [dbo].[Chat_Notification] CHECK CONSTRAINT [FK_Chat_Notification_Chat_Room]
GO
ALTER TABLE [dbo].[Chat_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Notification_Chat_User_Receiver] FOREIGN KEY([ChatNotificationReceiverID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_Notification] CHECK CONSTRAINT [FK_Chat_Notification_Chat_User_Receiver]
GO
ALTER TABLE [dbo].[Chat_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Notification_Chat_User_Sender] FOREIGN KEY([ChatNotificationSenderID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_Notification] CHECK CONSTRAINT [FK_Chat_Notification_Chat_User_Sender]
GO
ALTER TABLE [dbo].[Chat_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Notification_CMS_Site] FOREIGN KEY([ChatNotificationSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Chat_Notification] CHECK CONSTRAINT [FK_Chat_Notification_CMS_Site]
GO
