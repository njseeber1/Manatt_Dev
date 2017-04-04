SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messaging_ContactList](
	[ContactListUserID] [int] NOT NULL,
	[ContactListContactUserID] [int] NOT NULL,
 CONSTRAINT [PK_Messaging_ContactList] PRIMARY KEY CLUSTERED 
(
	[ContactListUserID] ASC,
	[ContactListContactUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Messaging_ContactList_ContactListContactUserID] ON [dbo].[Messaging_ContactList]
(
	[ContactListContactUserID] ASC
)
GO
ALTER TABLE [dbo].[Messaging_ContactList]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_ContactList_ContactListContactUserID_CMS_User] FOREIGN KEY([ContactListContactUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_ContactList] CHECK CONSTRAINT [FK_Messaging_ContactList_ContactListContactUserID_CMS_User]
GO
ALTER TABLE [dbo].[Messaging_ContactList]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_ContactList_ContactListUserID_CMS_User] FOREIGN KEY([ContactListUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_ContactList] CHECK CONSTRAINT [FK_Messaging_ContactList_ContactListUserID_CMS_User]
GO
