SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_User](
	[ChatUserID] [int] IDENTITY(1,1) NOT NULL,
	[ChatUserUserID] [int] NULL,
	[ChatUserNickname] [nvarchar](50) NOT NULL,
	[ChatUserLastModification] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_ChatUser] PRIMARY KEY CLUSTERED 
(
	[ChatUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_User_UserID] ON [dbo].[Chat_User]
(
	[ChatUserUserID] ASC
)
GO
ALTER TABLE [dbo].[Chat_User] ADD  CONSTRAINT [DEFAULT_Chat_User_ChatUserNickname]  DEFAULT (N'') FOR [ChatUserNickname]
GO
ALTER TABLE [dbo].[Chat_User] ADD  CONSTRAINT [DEFAULT_Chat_User_ChatUserLastModification]  DEFAULT ('2/20/2012 2:02:00 PM') FOR [ChatUserLastModification]
GO
ALTER TABLE [dbo].[Chat_User]  WITH CHECK ADD  CONSTRAINT [FK_Chat_User_CMS_User] FOREIGN KEY([ChatUserUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Chat_User] CHECK CONSTRAINT [FK_Chat_User_CMS_User]
GO
