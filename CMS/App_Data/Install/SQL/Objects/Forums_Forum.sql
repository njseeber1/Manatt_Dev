SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Forum](
	[ForumID] [int] IDENTITY(1,1) NOT NULL,
	[ForumGroupID] [int] NOT NULL,
	[ForumName] [nvarchar](200) NOT NULL,
	[ForumDisplayName] [nvarchar](200) NOT NULL,
	[ForumDescription] [nvarchar](max) NULL,
	[ForumOrder] [int] NULL,
	[ForumDocumentID] [int] NULL,
	[ForumOpen] [bit] NOT NULL,
	[ForumModerated] [bit] NOT NULL,
	[ForumDisplayEmails] [bit] NULL,
	[ForumRequireEmail] [bit] NULL,
	[ForumAccess] [int] NOT NULL,
	[ForumThreads] [int] NOT NULL,
	[ForumPosts] [int] NOT NULL,
	[ForumLastPostTime] [datetime2](7) NULL,
	[ForumLastPostUserName] [nvarchar](200) NULL,
	[ForumBaseUrl] [nvarchar](200) NULL,
	[ForumAllowChangeName] [bit] NULL,
	[ForumHTMLEditor] [bit] NULL,
	[ForumUseCAPTCHA] [bit] NULL,
	[ForumGUID] [uniqueidentifier] NOT NULL,
	[ForumLastModified] [datetime2](7) NOT NULL,
	[ForumUnsubscriptionUrl] [nvarchar](200) NULL,
	[ForumIsLocked] [bit] NULL,
	[ForumSettings] [nvarchar](max) NULL,
	[ForumAuthorEdit] [bit] NULL,
	[ForumAuthorDelete] [bit] NULL,
	[ForumType] [int] NULL,
	[ForumIsAnswerLimit] [int] NULL,
	[ForumImageMaxSideSize] [int] NULL,
	[ForumLastPostTimeAbsolute] [datetime2](7) NULL,
	[ForumLastPostUserNameAbsolute] [nvarchar](200) NULL,
	[ForumPostsAbsolute] [int] NULL,
	[ForumThreadsAbsolute] [int] NULL,
	[ForumAttachmentMaxFileSize] [int] NULL,
	[ForumDiscussionActions] [int] NULL,
	[ForumSiteID] [int] NOT NULL,
	[ForumLogActivity] [bit] NULL,
	[ForumCommunityGroupID] [int] NULL,
	[ForumEnableOptIn] [bit] NULL,
	[ForumSendOptInConfirmation] [bit] NULL,
	[ForumOptInApprovalURL] [nvarchar](450) NULL,
 CONSTRAINT [PK_Forums_Forum] PRIMARY KEY NONCLUSTERED 
(
	[ForumID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Forums_Forum_ForumGroupID_ForumOrder] ON [dbo].[Forums_Forum]
(
	[ForumGroupID] ASC,
	[ForumOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_Forum_ForumCommunityGroupID] ON [dbo].[Forums_Forum]
(
	[ForumCommunityGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_Forum_ForumDocumentID] ON [dbo].[Forums_Forum]
(
	[ForumDocumentID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Forums_Forum_ForumSiteID_ForumName] ON [dbo].[Forums_Forum]
(
	[ForumSiteID] ASC,
	[ForumName] ASC
)
GO
ALTER TABLE [dbo].[Forums_Forum] ADD  CONSTRAINT [DEFAULT_Forums_Forum_ForumIsLocked]  DEFAULT ((0)) FOR [ForumIsLocked]
GO
ALTER TABLE [dbo].[Forums_Forum] ADD  CONSTRAINT [DEFAULT_Forums_Forum_ForumIsAnswerLimit]  DEFAULT ((5)) FOR [ForumIsAnswerLimit]
GO
ALTER TABLE [dbo].[Forums_Forum] ADD  CONSTRAINT [DEFAULT_Forums_Forum_ForumImageMaxSideSize]  DEFAULT ((400)) FOR [ForumImageMaxSideSize]
GO
ALTER TABLE [dbo].[Forums_Forum] ADD  CONSTRAINT [DEFAULT_Forums_Forum_ForumSiteID]  DEFAULT ((0)) FOR [ForumSiteID]
GO
ALTER TABLE [dbo].[Forums_Forum]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Forum_ForumCommunityGroupID_Community_Group] FOREIGN KEY([ForumCommunityGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Forums_Forum] CHECK CONSTRAINT [FK_Forums_Forum_ForumCommunityGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Forums_Forum]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Forum_ForumDocumentID_CMS_Document] FOREIGN KEY([ForumDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[Forums_Forum] CHECK CONSTRAINT [FK_Forums_Forum_ForumDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[Forums_Forum]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Forum_ForumGroupID_Forums_ForumGroup] FOREIGN KEY([ForumGroupID])
REFERENCES [dbo].[Forums_ForumGroup] ([GroupID])
GO
ALTER TABLE [dbo].[Forums_Forum] CHECK CONSTRAINT [FK_Forums_Forum_ForumGroupID_Forums_ForumGroup]
GO
ALTER TABLE [dbo].[Forums_Forum]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Forum_ForumSiteID_CMS_Site] FOREIGN KEY([ForumSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Forums_Forum] CHECK CONSTRAINT [FK_Forums_Forum_ForumSiteID_CMS_Site]
GO
