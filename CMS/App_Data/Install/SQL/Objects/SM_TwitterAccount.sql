SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_TwitterAccount](
	[TwitterAccountID] [int] IDENTITY(1,1) NOT NULL,
	[TwitterAccountDisplayName] [nvarchar](200) NOT NULL,
	[TwitterAccountName] [nvarchar](200) NOT NULL,
	[TwitterAccountLastModified] [datetime2](7) NOT NULL,
	[TwitterAccountGUID] [uniqueidentifier] NOT NULL,
	[TwitterAccountSiteID] [int] NOT NULL,
	[TwitterAccountAccessToken] [nvarchar](500) NOT NULL,
	[TwitterAccountAccessTokenSecret] [nvarchar](500) NOT NULL,
	[TwitterAccountTwitterApplicationID] [int] NOT NULL,
	[TwitterAccountFollowers] [int] NULL,
	[TwitterAccountMentions] [int] NULL,
	[TwitterAccountMentionsRange] [nvarchar](40) NULL,
	[TwitterAccountUserID] [nvarchar](20) NULL,
	[TwitterAccountIsDefault] [bit] NULL,
 CONSTRAINT [PK_SM_TwitterAccount] PRIMARY KEY CLUSTERED 
(
	[TwitterAccountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterAccount_TwitterAccountSiteID] ON [dbo].[SM_TwitterAccount]
(
	[TwitterAccountSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterAccount_TwitterAccountTwitterApplicationID] ON [dbo].[SM_TwitterAccount]
(
	[TwitterAccountTwitterApplicationID] ASC
)
GO
ALTER TABLE [dbo].[SM_TwitterAccount] ADD  CONSTRAINT [DEFAULT_SM_TwitterAccount_TwitterAccountAccessToken]  DEFAULT ('') FOR [TwitterAccountAccessToken]
GO
ALTER TABLE [dbo].[SM_TwitterAccount] ADD  CONSTRAINT [DEFAULT_SM_TwitterAccount_TwitterAccountAccessTokenSecret]  DEFAULT ('') FOR [TwitterAccountAccessTokenSecret]
GO
ALTER TABLE [dbo].[SM_TwitterAccount] ADD  CONSTRAINT [DEFAULT_SM_TwitterAccount_TwitterAccountTwitterApplicationID]  DEFAULT ((0)) FOR [TwitterAccountTwitterApplicationID]
GO
ALTER TABLE [dbo].[SM_TwitterAccount]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterAccount_CMS_Site] FOREIGN KEY([TwitterAccountSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_TwitterAccount] CHECK CONSTRAINT [FK_SM_TwitterAccount_CMS_Site]
GO
ALTER TABLE [dbo].[SM_TwitterAccount]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterAccount_SM_TwitterApplication] FOREIGN KEY([TwitterAccountTwitterApplicationID])
REFERENCES [dbo].[SM_TwitterApplication] ([TwitterApplicationID])
GO
ALTER TABLE [dbo].[SM_TwitterAccount] CHECK CONSTRAINT [FK_SM_TwitterAccount_SM_TwitterApplication]
GO
