SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_MembershipUser](
	[MembershipUserID] [int] IDENTITY(1,1) NOT NULL,
	[MembershipID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ValidTo] [datetime2](7) NULL,
	[SendNotification] [bit] NULL,
 CONSTRAINT [PK_CMS_MembershipUser] PRIMARY KEY CLUSTERED 
(
	[MembershipUserID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_MembershipUser_MembershipID_UserID] ON [dbo].[CMS_MembershipUser]
(
	[MembershipID] ASC,
	[UserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_MembershipUser_UserID] ON [dbo].[CMS_MembershipUser]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_MembershipUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_MembershipUser_MembershipID_CMS_Membership] FOREIGN KEY([MembershipID])
REFERENCES [dbo].[CMS_Membership] ([MembershipID])
GO
ALTER TABLE [dbo].[CMS_MembershipUser] CHECK CONSTRAINT [FK_CMS_MembershipUser_MembershipID_CMS_Membership]
GO
ALTER TABLE [dbo].[CMS_MembershipUser]  WITH CHECK ADD  CONSTRAINT [FK_CMS_MembershipUser_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_MembershipUser] CHECK CONSTRAINT [FK_CMS_MembershipUser_UserID_CMS_User]
GO
