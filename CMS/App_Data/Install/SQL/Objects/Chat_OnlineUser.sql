SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_OnlineUser](
	[ChatOnlineUserID] [int] IDENTITY(1,1) NOT NULL,
	[ChatOnlineUserSiteID] [int] NOT NULL,
	[ChatOnlineUserLastChecking] [datetime2](7) NULL,
	[ChatOnlineUserChatUserID] [int] NOT NULL,
	[ChatOnlineUserJoinTime] [datetime2](7) NULL,
	[ChatOnlineUserLeaveTime] [datetime2](7) NULL,
	[ChatOnlineUserToken] [nvarchar](50) NULL,
	[ChatOnlineUserIsHidden] [bit] NOT NULL,
 CONSTRAINT [PK_Chat_OnlineUser] PRIMARY KEY CLUSTERED 
(
	[ChatOnlineUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_Chat_OnlineUser_SiteID-ChatUserID] UNIQUE NONCLUSTERED 
(
	[ChatOnlineUserChatUserID] ASC,
	[ChatOnlineUserSiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_OnlineUser_ChatOnlineUserChatUserID] ON [dbo].[Chat_OnlineUser]
(
	[ChatOnlineUserChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_OnlineUser_SiteID] ON [dbo].[Chat_OnlineUser]
(
	[ChatOnlineUserSiteID] ASC
)
GO
ALTER TABLE [dbo].[Chat_OnlineUser] ADD  CONSTRAINT [DEFAULT_Chat_OnlineUser_ChatOnlineUserIsHidden]  DEFAULT ((0)) FOR [ChatOnlineUserIsHidden]
GO
ALTER TABLE [dbo].[Chat_OnlineUser]  WITH CHECK ADD  CONSTRAINT [FK_Chat_OnlineUser_Chat_User] FOREIGN KEY([ChatOnlineUserChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_OnlineUser] CHECK CONSTRAINT [FK_Chat_OnlineUser_Chat_User]
GO
ALTER TABLE [dbo].[Chat_OnlineUser]  WITH CHECK ADD  CONSTRAINT [FK_Chat_OnlineUser_CMS_Site] FOREIGN KEY([ChatOnlineUserSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Chat_OnlineUser] CHECK CONSTRAINT [FK_Chat_OnlineUser_CMS_Site]
GO
