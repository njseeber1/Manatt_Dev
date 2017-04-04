SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Board_Message](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[MessageUserName] [nvarchar](250) NOT NULL,
	[MessageText] [nvarchar](max) NOT NULL,
	[MessageEmail] [nvarchar](250) NOT NULL,
	[MessageURL] [nvarchar](450) NOT NULL,
	[MessageIsSpam] [bit] NOT NULL,
	[MessageBoardID] [int] NOT NULL,
	[MessageApproved] [bit] NOT NULL,
	[MessageApprovedByUserID] [int] NULL,
	[MessageUserID] [int] NULL,
	[MessageUserInfo] [nvarchar](max) NOT NULL,
	[MessageAvatarGUID] [uniqueidentifier] NULL,
	[MessageInserted] [datetime2](7) NOT NULL,
	[MessageLastModified] [datetime2](7) NOT NULL,
	[MessageGUID] [uniqueidentifier] NOT NULL,
	[MessageRatingValue] [float] NULL,
 CONSTRAINT [PK_Board_Message] PRIMARY KEY NONCLUSTERED 
(
	[MessageID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Board_Message_MessageInserted] ON [dbo].[Board_Message]
(
	[MessageInserted] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Board_Message_MessageApproved_MessageIsSpam] ON [dbo].[Board_Message]
(
	[MessageApproved] ASC,
	[MessageIsSpam] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Board_Message_MessageApprovedByUserID] ON [dbo].[Board_Message]
(
	[MessageApprovedByUserID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Board_Message_MessageBoardID_MessageGUID] ON [dbo].[Board_Message]
(
	[MessageBoardID] ASC,
	[MessageGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Board_Message_MessageUserID] ON [dbo].[Board_Message]
(
	[MessageUserID] ASC
)
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageUserName]  DEFAULT ('') FOR [MessageUserName]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageText]  DEFAULT ('') FOR [MessageText]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageEmail]  DEFAULT ('') FOR [MessageEmail]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageURL]  DEFAULT ('') FOR [MessageURL]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageIsSpam]  DEFAULT ((0)) FOR [MessageIsSpam]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageBoardID]  DEFAULT ((0)) FOR [MessageBoardID]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageApproved]  DEFAULT ((0)) FOR [MessageApproved]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageUserInfo]  DEFAULT ('') FOR [MessageUserInfo]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageInserted]  DEFAULT ('8/26/2008 12:14:50 PM') FOR [MessageInserted]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageLastModified]  DEFAULT ('8/26/2008 12:15:04 PM') FOR [MessageLastModified]
GO
ALTER TABLE [dbo].[Board_Message] ADD  CONSTRAINT [DEFAULT_Board_Message_MessageGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MessageGUID]
GO
ALTER TABLE [dbo].[Board_Message]  WITH CHECK ADD  CONSTRAINT [FK_Board_Message_MessageApprovedByUserID_CMS_User] FOREIGN KEY([MessageApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Board_Message] CHECK CONSTRAINT [FK_Board_Message_MessageApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Board_Message]  WITH CHECK ADD  CONSTRAINT [FK_Board_Message_MessageBoardID_Board_Board] FOREIGN KEY([MessageBoardID])
REFERENCES [dbo].[Board_Board] ([BoardID])
GO
ALTER TABLE [dbo].[Board_Message] CHECK CONSTRAINT [FK_Board_Message_MessageBoardID_Board_Board]
GO
ALTER TABLE [dbo].[Board_Message]  WITH CHECK ADD  CONSTRAINT [FK_Board_Message_MessageUserID_CMS_User] FOREIGN KEY([MessageUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Board_Message] CHECK CONSTRAINT [FK_Board_Message_MessageUserID_CMS_User]
GO
