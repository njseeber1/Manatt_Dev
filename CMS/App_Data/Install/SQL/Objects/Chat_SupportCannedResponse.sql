SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_SupportCannedResponse](
	[ChatSupportCannedResponseID] [int] IDENTITY(1,1) NOT NULL,
	[ChatSupportCannedResponseChatUserID] [int] NULL,
	[ChatSupportCannedResponseText] [nvarchar](500) NOT NULL,
	[ChatSupportCannedResponseTagName] [nvarchar](50) NOT NULL,
	[ChatSupportCannedResponseSiteID] [int] NULL,
	[ChatSupportCannedResponseName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CMS_ChatSupportCannedResponse] PRIMARY KEY CLUSTERED 
(
	[ChatSupportCannedResponseID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_SupportCannedResponse_ChatSupportCannedResponseChatUserID] ON [dbo].[Chat_SupportCannedResponse]
(
	[ChatSupportCannedResponseChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_SupportCannedResponse_ChatSupportCannedResponseSiteID] ON [dbo].[Chat_SupportCannedResponse]
(
	[ChatSupportCannedResponseSiteID] ASC
)
GO
ALTER TABLE [dbo].[Chat_SupportCannedResponse] ADD  CONSTRAINT [DEFAULT_CMS_ChatSupportCannedResponse_ChatSupportCannedResponseTagName]  DEFAULT ('') FOR [ChatSupportCannedResponseTagName]
GO
ALTER TABLE [dbo].[Chat_SupportCannedResponse]  WITH CHECK ADD  CONSTRAINT [FK_Chat_SupportCannedResponse_Chat_User] FOREIGN KEY([ChatSupportCannedResponseChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_SupportCannedResponse] CHECK CONSTRAINT [FK_Chat_SupportCannedResponse_Chat_User]
GO
ALTER TABLE [dbo].[Chat_SupportCannedResponse]  WITH CHECK ADD  CONSTRAINT [FK_Chat_SupportCannedResponse_CMS_Site] FOREIGN KEY([ChatSupportCannedResponseSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Chat_SupportCannedResponse] CHECK CONSTRAINT [FK_Chat_SupportCannedResponse_CMS_Site]
GO
