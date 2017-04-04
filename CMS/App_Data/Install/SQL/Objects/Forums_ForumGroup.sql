SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_ForumGroup](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupSiteID] [int] NOT NULL,
	[GroupName] [nvarchar](200) NOT NULL,
	[GroupDisplayName] [nvarchar](200) NOT NULL,
	[GroupOrder] [int] NULL,
	[GroupDescription] [nvarchar](max) NULL,
	[GroupGUID] [uniqueidentifier] NOT NULL,
	[GroupLastModified] [datetime2](7) NOT NULL,
	[GroupBaseUrl] [nvarchar](200) NULL,
	[GroupUnsubscriptionUrl] [nvarchar](200) NULL,
	[GroupGroupID] [int] NULL,
	[GroupAuthorEdit] [bit] NULL,
	[GroupAuthorDelete] [bit] NULL,
	[GroupType] [int] NULL,
	[GroupIsAnswerLimit] [int] NULL,
	[GroupImageMaxSideSize] [int] NULL,
	[GroupDisplayEmails] [bit] NULL,
	[GroupRequireEmail] [bit] NULL,
	[GroupHTMLEditor] [bit] NULL,
	[GroupUseCAPTCHA] [bit] NULL,
	[GroupAttachmentMaxFileSize] [int] NULL,
	[GroupDiscussionActions] [int] NULL,
	[GroupLogActivity] [bit] NULL,
	[GroupEnableOptIn] [bit] NULL,
	[GroupSendOptInConfirmation] [bit] NULL,
	[GroupOptInApprovalURL] [nvarchar](450) NULL,
 CONSTRAINT [PK_Forums_ForumGroup] PRIMARY KEY NONCLUSTERED 
(
	[GroupID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Forums_ForumGroup_GroupSiteID_GroupOrder] ON [dbo].[Forums_ForumGroup]
(
	[GroupSiteID] ASC,
	[GroupOrder] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumGroup_GroupGroupID] ON [dbo].[Forums_ForumGroup]
(
	[GroupGroupID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumGroup_GroupSiteID_GroupName] ON [dbo].[Forums_ForumGroup]
(
	[GroupSiteID] ASC,
	[GroupName] ASC
)
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupSiteID]  DEFAULT ((0)) FOR [GroupSiteID]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupName]  DEFAULT (N'') FOR [GroupName]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [GroupGUID]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupLastModified]  DEFAULT ('11/6/2013 2:43:02 PM') FOR [GroupLastModified]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupImageMaxSideSize]  DEFAULT ((400)) FOR [GroupImageMaxSideSize]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupHTMLEditor]  DEFAULT ((0)) FOR [GroupHTMLEditor]
GO
ALTER TABLE [dbo].[Forums_ForumGroup] ADD  CONSTRAINT [DEFAULT_Forums_ForumGroup_GroupUseCAPTCHA]  DEFAULT ((0)) FOR [GroupUseCAPTCHA]
GO
ALTER TABLE [dbo].[Forums_ForumGroup]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumGroup_GroupGroupID_Community_Group] FOREIGN KEY([GroupGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Forums_ForumGroup] CHECK CONSTRAINT [FK_Forums_ForumGroup_GroupGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Forums_ForumGroup]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumGroup_GroupSiteID_CMS_Site] FOREIGN KEY([GroupSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Forums_ForumGroup] CHECK CONSTRAINT [FK_Forums_ForumGroup_GroupSiteID_CMS_Site]
GO
