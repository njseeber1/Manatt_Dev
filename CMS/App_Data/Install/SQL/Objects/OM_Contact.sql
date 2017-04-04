SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[ContactFirstName] [nvarchar](100) NULL,
	[ContactMiddleName] [nvarchar](100) NULL,
	[ContactLastName] [nvarchar](100) NOT NULL,
	[ContactSalutation] [nvarchar](50) NULL,
	[ContactTitleBefore] [nvarchar](50) NULL,
	[ContactTitleAfter] [nvarchar](50) NULL,
	[ContactJobTitle] [nvarchar](50) NULL,
	[ContactAddress1] [nvarchar](100) NULL,
	[ContactAddress2] [nvarchar](100) NULL,
	[ContactCity] [nvarchar](100) NULL,
	[ContactZIP] [nvarchar](100) NULL,
	[ContactStateID] [int] NULL,
	[ContactCountryID] [int] NULL,
	[ContactMobilePhone] [nvarchar](26) NULL,
	[ContactHomePhone] [nvarchar](26) NULL,
	[ContactBusinessPhone] [nvarchar](26) NULL,
	[ContactEmail] [nvarchar](100) NULL,
	[ContactWebSite] [nvarchar](100) NULL,
	[ContactBirthday] [datetime2](7) NULL,
	[ContactGender] [int] NULL,
	[ContactStatusID] [int] NULL,
	[ContactNotes] [nvarchar](max) NULL,
	[ContactOwnerUserID] [int] NULL,
	[ContactMonitored] [bit] NULL,
	[ContactMergedWithContactID] [int] NULL,
	[ContactIsAnonymous] [bit] NOT NULL,
	[ContactSiteID] [int] NULL,
	[ContactGUID] [uniqueidentifier] NOT NULL,
	[ContactLastModified] [datetime2](7) NOT NULL,
	[ContactCreated] [datetime2](7) NOT NULL,
	[ContactMergedWhen] [datetime2](7) NULL,
	[ContactGlobalContactID] [int] NULL,
	[ContactBounces] [int] NULL,
	[ContactLastLogon] [datetime2](7) NULL,
	[ContactCampaign] [nvarchar](200) NULL,
	[ContactSalesForceLeadID] [nvarchar](18) NULL,
	[ContactSalesForceLeadReplicationDisabled] [bit] NULL,
	[ContactSalesForceLeadReplicationDateTime] [datetime2](7) NULL,
	[ContactSalesForceLeadReplicationSuspensionDateTime] [datetime2](7) NULL,
	[ContactCompanyName] [nvarchar](100) NULL,
	[ContactSalesForceLeadReplicationRequired] [bit] NULL,
	[ContactPersonaID] [int] NULL,
 CONSTRAINT [PK_OM_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactCountryID] ON [dbo].[OM_Contact]
(
	[ContactCountryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactEmail] ON [dbo].[OM_Contact]
(
	[ContactEmail] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactGlobalContactID] ON [dbo].[OM_Contact]
(
	[ContactGlobalContactID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactLastName] ON [dbo].[OM_Contact]
(
	[ContactLastName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactMergedWithContactID] ON [dbo].[OM_Contact]
(
	[ContactMergedWithContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactMergedWithContactID_ContactSiteID] ON [dbo].[OM_Contact]
(
	[ContactMergedWithContactID] ASC,
	[ContactSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactOwnerUserID] ON [dbo].[OM_Contact]
(
	[ContactOwnerUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactPersonaID] ON [dbo].[OM_Contact]
(
	[ContactPersonaID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactSiteID] ON [dbo].[OM_Contact]
(
	[ContactSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactSiteID_ContactGUID] ON [dbo].[OM_Contact]
(
	[ContactSiteID] ASC,
	[ContactGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactStateID] ON [dbo].[OM_Contact]
(
	[ContactStateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_ContactStatusID] ON [dbo].[OM_Contact]
(
	[ContactStatusID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_OM_Contact_SalesForce] ON [dbo].[OM_Contact]
(
	[ContactSalesForceLeadID] ASC,
	[ContactSalesForceLeadReplicationDisabled] ASC,
	[ContactSalesForceLeadReplicationSuspensionDateTime] ASC
)
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactLastName]  DEFAULT ('') FOR [ContactLastName]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactMonitored]  DEFAULT ((0)) FOR [ContactMonitored]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactIsAnonymous]  DEFAULT ((1)) FOR [ContactIsAnonymous]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ContactGUID]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactCreated]  DEFAULT ('5/3/2011 10:51:13 AM') FOR [ContactCreated]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactSalesForceLeadReplicationDisabled]  DEFAULT ((0)) FOR [ContactSalesForceLeadReplicationDisabled]
GO
ALTER TABLE [dbo].[OM_Contact] ADD  CONSTRAINT [DEFAULT_OM_Contact_ContactSalesForceLeadReplicationRequired]  DEFAULT ((0)) FOR [ContactSalesForceLeadReplicationRequired]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_CMS_Country] FOREIGN KEY([ContactCountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_CMS_Country]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_CMS_Site] FOREIGN KEY([ContactSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_CMS_Site]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_CMS_State] FOREIGN KEY([ContactStateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_CMS_State]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_CMS_User] FOREIGN KEY([ContactOwnerUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_CMS_User]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_OM_Contact_ActiveGlobal] FOREIGN KEY([ContactGlobalContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_OM_Contact_ActiveGlobal]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_OM_Contact_Merged] FOREIGN KEY([ContactMergedWithContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_OM_Contact_Merged]
GO
ALTER TABLE [dbo].[OM_Contact]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Contact_OM_ContactStatus] FOREIGN KEY([ContactStatusID])
REFERENCES [dbo].[OM_ContactStatus] ([ContactStatusID])
GO
ALTER TABLE [dbo].[OM_Contact] CHECK CONSTRAINT [FK_OM_Contact_OM_ContactStatus]
GO
