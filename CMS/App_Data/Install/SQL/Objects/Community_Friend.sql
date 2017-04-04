SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community_Friend](
	[FriendID] [int] IDENTITY(1,1) NOT NULL,
	[FriendRequestedUserID] [int] NOT NULL,
	[FriendUserID] [int] NOT NULL,
	[FriendRequestedWhen] [datetime2](7) NOT NULL,
	[FriendComment] [nvarchar](max) NULL,
	[FriendApprovedBy] [int] NULL,
	[FriendApprovedWhen] [datetime2](7) NULL,
	[FriendRejectedBy] [int] NULL,
	[FriendRejectedWhen] [datetime2](7) NULL,
	[FriendGUID] [uniqueidentifier] NOT NULL,
	[FriendStatus] [int] NOT NULL,
 CONSTRAINT [PK_Community_Friend] PRIMARY KEY CLUSTERED 
(
	[FriendID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Community_Friend_FriendApprovedBy] ON [dbo].[Community_Friend]
(
	[FriendApprovedBy] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Friend_FriendRejectedBy] ON [dbo].[Community_Friend]
(
	[FriendRejectedBy] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Friend_FriendRequestedUserID_FriendStatus] ON [dbo].[Community_Friend]
(
	[FriendRequestedUserID] ASC,
	[FriendStatus] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Community_Friend_FriendRequestedUserID_FriendUserID] ON [dbo].[Community_Friend]
(
	[FriendRequestedUserID] ASC,
	[FriendUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Friend_FriendUserID_FriendStatus] ON [dbo].[Community_Friend]
(
	[FriendUserID] ASC,
	[FriendStatus] ASC
)
GO
ALTER TABLE [dbo].[Community_Friend] ADD  CONSTRAINT [DEFAULT_Community_Friend_FriendStatus]  DEFAULT ((0)) FOR [FriendStatus]
GO
ALTER TABLE [dbo].[Community_Friend]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Friend_FriendApprovedBy_CMS_User] FOREIGN KEY([FriendApprovedBy])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Friend] CHECK CONSTRAINT [FK_CMS_Friend_FriendApprovedBy_CMS_User]
GO
ALTER TABLE [dbo].[Community_Friend]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Friend_FriendRejectedBy_CMS_User] FOREIGN KEY([FriendRejectedBy])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Friend] CHECK CONSTRAINT [FK_CMS_Friend_FriendRejectedBy_CMS_User]
GO
ALTER TABLE [dbo].[Community_Friend]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Friend_FriendRequestedUserID_CMS_User] FOREIGN KEY([FriendRequestedUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Friend] CHECK CONSTRAINT [FK_CMS_Friend_FriendRequestedUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_Friend]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Friend_FriendUserID_CMS_User] FOREIGN KEY([FriendUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Friend] CHECK CONSTRAINT [FK_CMS_Friend_FriendUserID_CMS_User]
GO
