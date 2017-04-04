SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [nvarchar](200) NOT NULL,
	[AccountAddress1] [nvarchar](100) NULL,
	[AccountAddress2] [nvarchar](100) NULL,
	[AccountCity] [nvarchar](100) NULL,
	[AccountZIP] [nvarchar](20) NULL,
	[AccountStateID] [int] NULL,
	[AccountCountryID] [int] NULL,
	[AccountWebSite] [nvarchar](200) NULL,
	[AccountPhone] [nvarchar](26) NULL,
	[AccountEmail] [nvarchar](100) NULL,
	[AccountFax] [nvarchar](26) NULL,
	[AccountPrimaryContactID] [int] NULL,
	[AccountSecondaryContactID] [int] NULL,
	[AccountStatusID] [int] NULL,
	[AccountNotes] [nvarchar](max) NULL,
	[AccountOwnerUserID] [int] NULL,
	[AccountSubsidiaryOfID] [int] NULL,
	[AccountMergedWithAccountID] [int] NULL,
	[AccountSiteID] [int] NULL,
	[AccountGUID] [uniqueidentifier] NOT NULL,
	[AccountLastModified] [datetime2](7) NOT NULL,
	[AccountCreated] [datetime2](7) NOT NULL,
	[AccountGlobalAccountID] [int] NULL,
 CONSTRAINT [PK_OM_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountCountryID] ON [dbo].[OM_Account]
(
	[AccountCountryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountGlobalAccountID] ON [dbo].[OM_Account]
(
	[AccountGlobalAccountID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountMergedWithAccountID] ON [dbo].[OM_Account]
(
	[AccountMergedWithAccountID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountOwnerUserID] ON [dbo].[OM_Account]
(
	[AccountOwnerUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountPrimaryContactID] ON [dbo].[OM_Account]
(
	[AccountPrimaryContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountSecondaryContactID] ON [dbo].[OM_Account]
(
	[AccountSecondaryContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountSiteID] ON [dbo].[OM_Account]
(
	[AccountSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountStateID] ON [dbo].[OM_Account]
(
	[AccountStateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountStatusID] ON [dbo].[OM_Account]
(
	[AccountStatusID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Account_AccountSubsidiaryOfID] ON [dbo].[OM_Account]
(
	[AccountSubsidiaryOfID] ASC
)
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_CMS_Country] FOREIGN KEY([AccountCountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_CMS_Country]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_CMS_Site] FOREIGN KEY([AccountSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_CMS_Site]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_CMS_State] FOREIGN KEY([AccountStateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_CMS_State]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_CMS_User] FOREIGN KEY([AccountOwnerUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_CMS_User]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_Account_MergedWith] FOREIGN KEY([AccountMergedWithAccountID])
REFERENCES [dbo].[OM_Account] ([AccountID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_Account_MergedWith]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_Account_OriginalGlobal] FOREIGN KEY([AccountGlobalAccountID])
REFERENCES [dbo].[OM_Account] ([AccountID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_Account_OriginalGlobal]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_Account_SubsidiaryOf] FOREIGN KEY([AccountSubsidiaryOfID])
REFERENCES [dbo].[OM_Account] ([AccountID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_Account_SubsidiaryOf]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_AccountStatus] FOREIGN KEY([AccountStatusID])
REFERENCES [dbo].[OM_AccountStatus] ([AccountStatusID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_AccountStatus]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_Contact_PrimaryContact] FOREIGN KEY([AccountPrimaryContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_Contact_PrimaryContact]
GO
ALTER TABLE [dbo].[OM_Account]  WITH CHECK ADD  CONSTRAINT [FK_OM_Account_OM_Contact_SecondaryContact] FOREIGN KEY([AccountSecondaryContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Account] CHECK CONSTRAINT [FK_OM_Account_OM_Contact_SecondaryContact]
GO
