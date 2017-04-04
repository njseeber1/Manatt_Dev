SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community_GroupMember](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[MemberGUID] [uniqueidentifier] NOT NULL,
	[MemberUserID] [int] NOT NULL,
	[MemberGroupID] [int] NOT NULL,
	[MemberJoined] [datetime2](7) NOT NULL,
	[MemberApprovedWhen] [datetime2](7) NULL,
	[MemberRejectedWhen] [datetime2](7) NULL,
	[MemberApprovedByUserID] [int] NULL,
	[MemberComment] [nvarchar](max) NULL,
	[MemberInvitedByUserID] [int] NULL,
	[MemberStatus] [int] NULL,
 CONSTRAINT [PK_Community_GroupMember] PRIMARY KEY NONCLUSTERED 
(
	[MemberID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Community_GroupMember_MemberJoined] ON [dbo].[Community_GroupMember]
(
	[MemberJoined] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupMember_MemberApprovedByUserID] ON [dbo].[Community_GroupMember]
(
	[MemberApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupMember_MemberGroupID] ON [dbo].[Community_GroupMember]
(
	[MemberGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupMember_MemberInvitedByUserID] ON [dbo].[Community_GroupMember]
(
	[MemberInvitedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupMember_MemberStatus] ON [dbo].[Community_GroupMember]
(
	[MemberStatus] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_GroupMember_MemberUserID] ON [dbo].[Community_GroupMember]
(
	[MemberUserID] ASC
)
GO
ALTER TABLE [dbo].[Community_GroupMember] ADD  CONSTRAINT [DEFAULT_Community_GroupMember_MemberStatus]  DEFAULT ((0)) FOR [MemberStatus]
GO
ALTER TABLE [dbo].[Community_GroupMember]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupMember_MemberApprovedByUserID_CMS_User] FOREIGN KEY([MemberApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_GroupMember] CHECK CONSTRAINT [FK_Community_GroupMember_MemberApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_GroupMember]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupMember_MemberGroupID_Community_Group] FOREIGN KEY([MemberGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Community_GroupMember] CHECK CONSTRAINT [FK_Community_GroupMember_MemberGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Community_GroupMember]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupMember_MemberInvitedByUserID_CMS_User] FOREIGN KEY([MemberInvitedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_GroupMember] CHECK CONSTRAINT [FK_Community_GroupMember_MemberInvitedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_GroupMember]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupMember_MemberUserID_CMS_User] FOREIGN KEY([MemberUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_GroupMember] CHECK CONSTRAINT [FK_Community_GroupMember_MemberUserID_CMS_User]
GO
