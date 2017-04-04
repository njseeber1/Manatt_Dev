SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Membership](
	[MembershipID] [int] IDENTITY(1,1) NOT NULL,
	[RelatedID] [int] NOT NULL,
	[MemberType] [int] NOT NULL,
	[MembershipGUID] [uniqueidentifier] NOT NULL,
	[MembershipCreated] [datetime2](7) NOT NULL,
	[OriginalContactID] [int] NOT NULL,
	[ActiveContactID] [int] NOT NULL,
 CONSTRAINT [PK_OM_Membership] PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Membership_ActiveContactID] ON [dbo].[OM_Membership]
(
	[ActiveContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Membership_OriginalContactID] ON [dbo].[OM_Membership]
(
	[OriginalContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Membership_RelatedID] ON [dbo].[OM_Membership]
(
	[RelatedID] ASC
)
GO
ALTER TABLE [dbo].[OM_Membership] ADD  CONSTRAINT [DEFAULT_OM_Membership_MemberType]  DEFAULT ((0)) FOR [MemberType]
GO
ALTER TABLE [dbo].[OM_Membership]  WITH CHECK ADD  CONSTRAINT [FK_OM_Membership_OM_Contact] FOREIGN KEY([OriginalContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Membership] CHECK CONSTRAINT [FK_OM_Membership_OM_Contact]
GO
ALTER TABLE [dbo].[OM_Membership]  WITH CHECK ADD  CONSTRAINT [FK_OM_Membership_OM_Contact1] FOREIGN KEY([ActiveContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Membership] CHECK CONSTRAINT [FK_OM_Membership_OM_Contact1]
GO
