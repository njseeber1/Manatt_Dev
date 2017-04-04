SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_ForumSubscription](
	[SubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionUserID] [int] NULL,
	[SubscriptionEmail] [nvarchar](100) NULL,
	[SubscriptionForumID] [int] NOT NULL,
	[SubscriptionPostID] [int] NULL,
	[SubscriptionGUID] [uniqueidentifier] NOT NULL,
	[SubscriptionLastModified] [datetime2](7) NOT NULL,
	[SubscriptionApproved] [bit] NULL,
	[SubscriptionApprovalHash] [nvarchar](100) NULL,
 CONSTRAINT [PK_Forums_ForumSubscription] PRIMARY KEY NONCLUSTERED 
(
	[SubscriptionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail] ON [dbo].[Forums_ForumSubscription]
(
	[SubscriptionEmail] ASC,
	[SubscriptionForumID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumSubscription_SubscriptionForumID] ON [dbo].[Forums_ForumSubscription]
(
	[SubscriptionForumID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumSubscription_SubscriptionPostID] ON [dbo].[Forums_ForumSubscription]
(
	[SubscriptionPostID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumSubscription_SubscriptionUserID] ON [dbo].[Forums_ForumSubscription]
(
	[SubscriptionUserID] ASC
)
GO
ALTER TABLE [dbo].[Forums_ForumSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionForumID_Forums_Forum] FOREIGN KEY([SubscriptionForumID])
REFERENCES [dbo].[Forums_Forum] ([ForumID])
GO
ALTER TABLE [dbo].[Forums_ForumSubscription] CHECK CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionForumID_Forums_Forum]
GO
ALTER TABLE [dbo].[Forums_ForumSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionPostID_Forums_ForumPost] FOREIGN KEY([SubscriptionPostID])
REFERENCES [dbo].[Forums_ForumPost] ([PostId])
GO
ALTER TABLE [dbo].[Forums_ForumSubscription] CHECK CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionPostID_Forums_ForumPost]
GO
ALTER TABLE [dbo].[Forums_ForumSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionUserID_CMS_User] FOREIGN KEY([SubscriptionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Forums_ForumSubscription] CHECK CONSTRAINT [FK_Forums_ForumSubscription_SubscriptionUserID_CMS_User]
GO
