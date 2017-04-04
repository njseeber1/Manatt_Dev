SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_ForumPost](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[PostForumID] [int] NOT NULL,
	[PostParentID] [int] NULL,
	[PostIDPath] [nvarchar](450) NOT NULL,
	[PostLevel] [int] NOT NULL,
	[PostSubject] [nvarchar](450) NOT NULL,
	[PostUserID] [int] NULL,
	[PostUserName] [nvarchar](200) NOT NULL,
	[PostUserMail] [nvarchar](100) NULL,
	[PostText] [nvarchar](max) NULL,
	[PostTime] [datetime2](7) NOT NULL,
	[PostApprovedByUserID] [int] NULL,
	[PostThreadPosts] [int] NULL,
	[PostThreadLastPostUserName] [nvarchar](200) NULL,
	[PostThreadLastPostTime] [datetime2](7) NULL,
	[PostUserSignature] [nvarchar](max) NULL,
	[PostGUID] [uniqueidentifier] NOT NULL,
	[PostLastModified] [datetime2](7) NOT NULL,
	[PostApproved] [bit] NULL,
	[PostIsLocked] [bit] NULL,
	[PostIsAnswer] [int] NULL,
	[PostStickOrder] [int] NOT NULL,
	[PostViews] [int] NULL,
	[PostLastEdit] [datetime2](7) NULL,
	[PostInfo] [nvarchar](max) NULL,
	[PostAttachmentCount] [int] NULL,
	[PostType] [int] NULL,
	[PostThreadPostsAbsolute] [int] NULL,
	[PostThreadLastPostUserNameAbsolute] [nvarchar](200) NULL,
	[PostThreadLastPostTimeAbsolute] [datetime2](7) NULL,
	[PostQuestionSolved] [bit] NULL,
	[PostIsNotAnswer] [int] NULL,
	[PostSiteID] [int] NULL,
 CONSTRAINT [PK_Forums_ForumPost] PRIMARY KEY NONCLUSTERED 
(
	[PostId] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [IX_Forums_ForumPost_PostIDPath] ON [dbo].[Forums_ForumPost]
(
	[PostIDPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostApproved] ON [dbo].[Forums_ForumPost]
(
	[PostApproved] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostApprovedByUserID] ON [dbo].[Forums_ForumPost]
(
	[PostApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostForumID] ON [dbo].[Forums_ForumPost]
(
	[PostForumID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostLevel] ON [dbo].[Forums_ForumPost]
(
	[PostLevel] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostParentID] ON [dbo].[Forums_ForumPost]
(
	[PostParentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumPost_PostUserID] ON [dbo].[Forums_ForumPost]
(
	[PostUserID] ASC
)
GO
ALTER TABLE [dbo].[Forums_ForumPost] ADD  CONSTRAINT [DEFAULT_Forums_ForumPost_PostUserName]  DEFAULT ('') FOR [PostUserName]
GO
ALTER TABLE [dbo].[Forums_ForumPost] ADD  CONSTRAINT [DEFAULT_Forums_ForumPost_PostIsLocked]  DEFAULT ((0)) FOR [PostIsLocked]
GO
ALTER TABLE [dbo].[Forums_ForumPost] ADD  CONSTRAINT [DEFAULT_Forums_ForumPost_PostAttachmentCount]  DEFAULT ((0)) FOR [PostAttachmentCount]
GO
ALTER TABLE [dbo].[Forums_ForumPost] ADD  CONSTRAINT [DEFAULT_Forums_ForumPost_PostQuestionSolved]  DEFAULT ((0)) FOR [PostQuestionSolved]
GO
ALTER TABLE [dbo].[Forums_ForumPost]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumPost_PostApprovedByUserID_CMS_User] FOREIGN KEY([PostApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Forums_ForumPost] CHECK CONSTRAINT [FK_Forums_ForumPost_PostApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Forums_ForumPost]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumPost_PostForumID_Forums_Forum] FOREIGN KEY([PostForumID])
REFERENCES [dbo].[Forums_Forum] ([ForumID])
GO
ALTER TABLE [dbo].[Forums_ForumPost] CHECK CONSTRAINT [FK_Forums_ForumPost_PostForumID_Forums_Forum]
GO
ALTER TABLE [dbo].[Forums_ForumPost]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumPost_PostParentID_Forums_ForumPost] FOREIGN KEY([PostParentID])
REFERENCES [dbo].[Forums_ForumPost] ([PostId])
GO
ALTER TABLE [dbo].[Forums_ForumPost] CHECK CONSTRAINT [FK_Forums_ForumPost_PostParentID_Forums_ForumPost]
GO
ALTER TABLE [dbo].[Forums_ForumPost]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumPost_PostUserID_CMS_User] FOREIGN KEY([PostUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Forums_ForumPost] CHECK CONSTRAINT [FK_Forums_ForumPost_PostUserID_CMS_User]
GO
