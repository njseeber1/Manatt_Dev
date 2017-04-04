SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_FacebookAccount](
	[FacebookAccountID] [int] IDENTITY(1,1) NOT NULL,
	[FacebookAccountGUID] [uniqueidentifier] NOT NULL,
	[FacebookAccountLastModified] [datetime2](7) NOT NULL,
	[FacebookAccountSiteID] [int] NOT NULL,
	[FacebookAccountName] [nvarchar](200) NOT NULL,
	[FacebookAccountDisplayName] [nvarchar](200) NOT NULL,
	[FacebookAccountPageID] [nvarchar](500) NOT NULL,
	[FacebookAccountPageAccessToken] [nvarchar](max) NOT NULL,
	[FacebookAccountFacebookApplicationID] [int] NOT NULL,
	[FacebookAccountPageAccessTokenExpiration] [datetime2](7) NULL,
	[FacebookAccountPageUrl] [nvarchar](1000) NULL,
	[FacebookAccountIsDefault] [bit] NULL,
 CONSTRAINT [PK_SM_FacebookAccount] PRIMARY KEY CLUSTERED 
(
	[FacebookAccountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookAccount_FacebookAccountFacebookApplicationID] ON [dbo].[SM_FacebookAccount]
(
	[FacebookAccountFacebookApplicationID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookAccount_FacebookAccountSiteID] ON [dbo].[SM_FacebookAccount]
(
	[FacebookAccountSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_FacebookAccount] ADD  CONSTRAINT [DEFAULT_SM_FacebookAccount_FacebookAccountPageID]  DEFAULT ('') FOR [FacebookAccountPageID]
GO
ALTER TABLE [dbo].[SM_FacebookAccount] ADD  CONSTRAINT [DEFAULT_SM_FacebookAccount_FacebookAccountPageAccessToken]  DEFAULT ('') FOR [FacebookAccountPageAccessToken]
GO
ALTER TABLE [dbo].[SM_FacebookAccount] ADD  CONSTRAINT [DEFAULT_SM_FacebookAccount_FacebookAccountFacebookApplicationID]  DEFAULT ((0)) FOR [FacebookAccountFacebookApplicationID]
GO
ALTER TABLE [dbo].[SM_FacebookAccount]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookAccount_CMS_Site] FOREIGN KEY([FacebookAccountSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_FacebookAccount] CHECK CONSTRAINT [FK_SM_FacebookAccount_CMS_Site]
GO
ALTER TABLE [dbo].[SM_FacebookAccount]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookAccount_SM_FacebookApplication] FOREIGN KEY([FacebookAccountFacebookApplicationID])
REFERENCES [dbo].[SM_FacebookApplication] ([FacebookApplicationID])
GO
ALTER TABLE [dbo].[SM_FacebookAccount] CHECK CONSTRAINT [FK_SM_FacebookAccount_SM_FacebookApplication]
GO
