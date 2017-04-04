SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ContactGroupMember](
	[ContactGroupMemberID] [int] IDENTITY(1,1) NOT NULL,
	[ContactGroupMemberContactGroupID] [int] NOT NULL,
	[ContactGroupMemberType] [int] NOT NULL,
	[ContactGroupMemberRelatedID] [int] NOT NULL,
	[ContactGroupMemberFromCondition] [bit] NULL,
	[ContactGroupMemberFromAccount] [bit] NULL,
	[ContactGroupMemberFromManual] [bit] NULL,
 CONSTRAINT [PK_OM_ContactGroupMember] PRIMARY KEY CLUSTERED 
(
	[ContactGroupMemberID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OM_ContactGroupMember_ContactGroupID_Type_RelatedID] ON [dbo].[OM_ContactGroupMember]
(
	[ContactGroupMemberContactGroupID] ASC,
	[ContactGroupMemberType] ASC,
	[ContactGroupMemberRelatedID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID] ON [dbo].[OM_ContactGroupMember]
(
	[ContactGroupMemberContactGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ContactGroupMember_ContactGroupMemberRelatedID] ON [dbo].[OM_ContactGroupMember]
(
	[ContactGroupMemberRelatedID] ASC
)
GO
ALTER TABLE [dbo].[OM_ContactGroupMember] ADD  CONSTRAINT [DEFAULT_OM_ContactGroupMember_MemberType]  DEFAULT ((0)) FOR [ContactGroupMemberType]
GO
ALTER TABLE [dbo].[OM_ContactGroupMember] ADD  CONSTRAINT [DEFAULT_OM_ContactGroupMember_RelatedID]  DEFAULT ((0)) FOR [ContactGroupMemberRelatedID]
GO
ALTER TABLE [dbo].[OM_ContactGroupMember] ADD  CONSTRAINT [DEFAULT_OM_ContactGroupMember_ContactGroupMemberFromCondition]  DEFAULT ((0)) FOR [ContactGroupMemberFromCondition]
GO
ALTER TABLE [dbo].[OM_ContactGroupMember] ADD  CONSTRAINT [DEFAULT_OM_ContactGroupMember_MemberFromManual]  DEFAULT ((0)) FOR [ContactGroupMemberFromManual]
GO
ALTER TABLE [dbo].[OM_ContactGroupMember]  WITH CHECK ADD  CONSTRAINT [FK_OM_ContactGroupMembers_OM_ContactGroup] FOREIGN KEY([ContactGroupMemberContactGroupID])
REFERENCES [dbo].[OM_ContactGroup] ([ContactGroupID])
GO
ALTER TABLE [dbo].[OM_ContactGroupMember] CHECK CONSTRAINT [FK_OM_ContactGroupMembers_OM_ContactGroup]
GO
