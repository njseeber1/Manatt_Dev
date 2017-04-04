SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_OnlineSupport](
	[ChatOnlineSupportID] [int] IDENTITY(1,1) NOT NULL,
	[ChatOnlineSupportChatUserID] [int] NOT NULL,
	[ChatOnlineSupportLastChecking] [datetime2](7) NOT NULL,
	[ChatOnlineSupportSiteID] [int] NOT NULL,
	[ChatOnlineSupportToken] [nvarchar](50) NULL,
 CONSTRAINT [PK_Chat_OnlineSupport] PRIMARY KEY CLUSTERED 
(
	[ChatOnlineSupportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_Chat_OnlineSupport_ChatUserID-SiteID] UNIQUE NONCLUSTERED 
(
	[ChatOnlineSupportChatUserID] ASC,
	[ChatOnlineSupportSiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_OnlineSupport_ChatOnlineSupportChatUserID] ON [dbo].[Chat_OnlineSupport]
(
	[ChatOnlineSupportChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_OnlineSupport_SiteID] ON [dbo].[Chat_OnlineSupport]
(
	[ChatOnlineSupportSiteID] ASC
)
GO
ALTER TABLE [dbo].[Chat_OnlineSupport]  WITH CHECK ADD  CONSTRAINT [FK_Chat_OnlineSupport_Chat_User] FOREIGN KEY([ChatOnlineSupportChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_OnlineSupport] CHECK CONSTRAINT [FK_Chat_OnlineSupport_Chat_User]
GO
ALTER TABLE [dbo].[Chat_OnlineSupport]  WITH CHECK ADD  CONSTRAINT [FK_Chat_OnlineSupport_CMS_Site] FOREIGN KEY([ChatOnlineSupportSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Chat_OnlineSupport] CHECK CONSTRAINT [FK_Chat_OnlineSupport_CMS_Site]
GO
