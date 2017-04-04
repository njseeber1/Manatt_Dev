SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_MembershipRole](
	[MembershipID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_MembershipRole] PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC,
	[RoleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_MembershipRole_RoleID] ON [dbo].[CMS_MembershipRole]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[CMS_MembershipRole]  WITH CHECK ADD  CONSTRAINT [FK_CMS_MembershipRole_MembershipID_CMS_Membership] FOREIGN KEY([MembershipID])
REFERENCES [dbo].[CMS_Membership] ([MembershipID])
GO
ALTER TABLE [dbo].[CMS_MembershipRole] CHECK CONSTRAINT [FK_CMS_MembershipRole_MembershipID_CMS_Membership]
GO
ALTER TABLE [dbo].[CMS_MembershipRole]  WITH CHECK ADD  CONSTRAINT [FK_CMS_MembershipRole_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[CMS_MembershipRole] CHECK CONSTRAINT [FK_CMS_MembershipRole_RoleID_CMS_Role]
GO
