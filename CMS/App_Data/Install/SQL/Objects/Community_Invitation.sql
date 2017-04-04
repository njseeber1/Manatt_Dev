SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community_Invitation](
	[InvitationID] [int] IDENTITY(1,1) NOT NULL,
	[InvitedUserID] [int] NULL,
	[InvitedByUserID] [int] NOT NULL,
	[InvitationGroupID] [int] NULL,
	[InvitationCreated] [datetime2](7) NULL,
	[InvitationValidTo] [datetime2](7) NULL,
	[InvitationComment] [nvarchar](max) NULL,
	[InvitationGUID] [uniqueidentifier] NOT NULL,
	[InvitationLastModified] [datetime2](7) NOT NULL,
	[InvitationUserEmail] [nvarchar](200) NULL,
 CONSTRAINT [PK_Community_GroupInvitation] PRIMARY KEY CLUSTERED 
(
	[InvitationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Community_Invitation_InvitationGroupID] ON [dbo].[Community_Invitation]
(
	[InvitationGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Invitation_InvitedByUserID] ON [dbo].[Community_Invitation]
(
	[InvitedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Community_Invitation_InvitedUserID] ON [dbo].[Community_Invitation]
(
	[InvitedUserID] ASC
)
GO
ALTER TABLE [dbo].[Community_Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupInvitation_InvitationGroupID_Community_Group] FOREIGN KEY([InvitationGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Community_Invitation] CHECK CONSTRAINT [FK_Community_GroupInvitation_InvitationGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Community_Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupInvitation_InvitedByUserID_CMS_User] FOREIGN KEY([InvitedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Invitation] CHECK CONSTRAINT [FK_Community_GroupInvitation_InvitedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Community_Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Community_GroupInvitation_InvitedUserID_CMS_User] FOREIGN KEY([InvitedUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Community_Invitation] CHECK CONSTRAINT [FK_Community_GroupInvitation_InvitedUserID_CMS_User]
GO
