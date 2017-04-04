SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_AccountContact](
	[AccountContactID] [int] IDENTITY(1,1) NOT NULL,
	[ContactRoleID] [int] NULL,
	[AccountID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
 CONSTRAINT [PK_OM_AccountContact] PRIMARY KEY CLUSTERED 
(
	[AccountContactID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_AccountContact_AccountID] ON [dbo].[OM_AccountContact]
(
	[AccountID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_AccountContact_ContactID] ON [dbo].[OM_AccountContact]
(
	[ContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_AccountContact_ContactRoleID] ON [dbo].[OM_AccountContact]
(
	[ContactRoleID] ASC
)
GO
ALTER TABLE [dbo].[OM_AccountContact] ADD  CONSTRAINT [DEFAULT_OM_AccountContact_OriginalAccountID]  DEFAULT ((0)) FOR [AccountID]
GO
ALTER TABLE [dbo].[OM_AccountContact]  WITH CHECK ADD  CONSTRAINT [FK_OM_AccountContact_OM_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[OM_Account] ([AccountID])
GO
ALTER TABLE [dbo].[OM_AccountContact] CHECK CONSTRAINT [FK_OM_AccountContact_OM_Account]
GO
ALTER TABLE [dbo].[OM_AccountContact]  WITH CHECK ADD  CONSTRAINT [FK_OM_AccountContact_OM_Contact] FOREIGN KEY([ContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_AccountContact] CHECK CONSTRAINT [FK_OM_AccountContact_OM_Contact]
GO
ALTER TABLE [dbo].[OM_AccountContact]  WITH CHECK ADD  CONSTRAINT [FK_OM_AccountContact_OM_ContactRole] FOREIGN KEY([ContactRoleID])
REFERENCES [dbo].[OM_ContactRole] ([ContactRoleID])
GO
ALTER TABLE [dbo].[OM_AccountContact] CHECK CONSTRAINT [FK_OM_AccountContact_OM_ContactRole]
GO
