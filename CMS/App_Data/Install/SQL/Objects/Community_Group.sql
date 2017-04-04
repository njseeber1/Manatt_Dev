SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community_Group](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupGUID] [uniqueidentifier] NOT NULL,
	[GroupLastModified] [datetime2](7) NOT NULL,
	[GroupSiteID] [int] NOT NULL,
	[GroupDisplayName] [nvarchar](200) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[GroupDescription] [nvarchar](max) NOT NULL,
	[GroupNodeGUID] [uniqueidentifier] NULL,
	[GroupApproveMembers] [int] NOT NULL,
	[GroupAccess] [int] NOT NULL,
	[GroupCreatedByUserID] [int] NULL,
	[GroupApprovedByUserID] [int] NULL,
	[GroupAvatarID] [int] NULL,
	[GroupApproved] [bit] NULL,
	[GroupCreatedWhen] [datetime2](7) NOT NULL,
	[GroupSendJoinLeaveNotification] [bit] NULL,
	[GroupSendWaitingForApprovalNotification] [bit] NULL,
	[GroupSecurity] [int] NULL,
	[GroupLogActivity] [bit] NULL,
 CONSTRAINT [PK_Community_Group] PRIMARY KEY NONCLUSTERED 
(
	[GroupID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Community_Group_GroupDisplayName] ON [dbo].[Community_Group]
(
	[GroupSiteID] ASC,
	[GroupDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Group_GroupApproved] ON [dbo].[Community_Group]
(
	[GroupApproved] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Group_GroupApprovedByUserID] ON [dbo].[Community_Group]
(
	[GroupApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Group_GroupAvatarID] ON [dbo].[Community_Group]
(
	[GroupAvatarID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Group_GroupCreatedByUserID] ON [dbo].[Community_Group]
(
	[GroupCreatedByUserID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Community_Group_GroupSiteID_GroupName] ON [dbo].[Community_Group]
(
	[GroupSiteID] ASC,
	[GroupName] ASC
)
GO
ALTER TABLE [dbo].[Community_Group] ADD  CONSTRAINT [DEFAULT_Community_Group_GroupApproved]  DEFAULT ((0)) FOR [GroupApproved]
GO
ALTER TABLE [dbo].[Community_Group] ADD  CONSTRAINT [DEFAULT_Community_Group_GroupCreatedWhen]  DEFAULT ('10/21/2008 10:17:56 AM') FOR [GroupCreatedWhen]
GO
ALTER TABLE [dbo].[Community_Group] ADD  CONSTRAINT [DEFAULT_Community_Group_GroupSendJoinLeaveNotification]  DEFAULT ((1)) FOR [GroupSendJoinLeaveNotification]
GO
ALTER TABLE [dbo].[Community_Group] ADD  CONSTRAINT [DEFAULT_Community_Group_GroupSendWaitingForApprovalNotification]  DEFAULT ((1)) FOR [GroupSendWaitingForApprovalNotification]
GO
ALTER TABLE [dbo].[Community_Group] ADD  CONSTRAINT [DEFAULT_Community_Group_GroupSecurity]  DEFAULT ((444)) FOR [GroupSecurity]
GO
ALTER TABLE [dbo].[Community_Group]  WITH CHECK ADD  CONSTRAINT [FK_Community_Group_GroupApprovedByUserID_CMS_User] FOREIGN KEY([GroupApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Group] CHECK CONSTRAINT [FK_Community_Group_GroupApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_Group]  WITH CHECK ADD  CONSTRAINT [FK_Community_Group_GroupAvatarID_CMS_Avatar] FOREIGN KEY([GroupAvatarID])
REFERENCES [dbo].[CMS_Avatar] ([AvatarID])
GO
ALTER TABLE [dbo].[Community_Group] CHECK CONSTRAINT [FK_Community_Group_GroupAvatarID_CMS_Avatar]
GO
ALTER TABLE [dbo].[Community_Group]  WITH CHECK ADD  CONSTRAINT [FK_Community_Group_GroupCreatedByUserID_CMS_User] FOREIGN KEY([GroupCreatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Group] CHECK CONSTRAINT [FK_Community_Group_GroupCreatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_Group]  WITH CHECK ADD  CONSTRAINT [FK_Community_Group_GroupSiteID_CMS_Site] FOREIGN KEY([GroupSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Community_Group] CHECK CONSTRAINT [FK_Community_Group_GroupSiteID_CMS_Site]
GO
