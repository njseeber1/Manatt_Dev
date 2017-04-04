SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_LinkedInAccount](
	[LinkedInAccountID] [int] IDENTITY(1,1) NOT NULL,
	[LinkedInAccountDisplayName] [nvarchar](200) NOT NULL,
	[LinkedInAccountName] [nvarchar](200) NOT NULL,
	[LinkedInAccountIsDefault] [bit] NULL,
	[LinkedInAccountAccessToken] [nvarchar](500) NOT NULL,
	[LinkedInAccountAccessTokenSecret] [nvarchar](500) NOT NULL,
	[LinkedInAccountLastModified] [datetime2](7) NOT NULL,
	[LinkedInAccountGUID] [uniqueidentifier] NOT NULL,
	[LinkedInAccountSiteID] [int] NOT NULL,
	[LinkedInAccountProfileID] [nvarchar](50) NOT NULL,
	[LinkedInAccountLinkedInApplicationID] [int] NOT NULL,
	[LinkedInAccountProfileName] [nvarchar](200) NULL,
	[LinkedInAccountAccessTokenExpiration] [datetime2](7) NULL,
 CONSTRAINT [PK_SM_LinkedInAccount] PRIMARY KEY CLUSTERED 
(
	[LinkedInAccountID] ASC
)
)

GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountDisplayName]  DEFAULT (N'') FOR [LinkedInAccountDisplayName]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountName]  DEFAULT (N'') FOR [LinkedInAccountName]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountAccessToken]  DEFAULT (N'') FOR [LinkedInAccountAccessToken]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountAccessTokenSecret]  DEFAULT (N'') FOR [LinkedInAccountAccessTokenSecret]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LinkedInAccountGUID]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountSiteID]  DEFAULT ((0)) FOR [LinkedInAccountSiteID]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountProfileID]  DEFAULT (N'') FOR [LinkedInAccountProfileID]
GO
ALTER TABLE [dbo].[SM_LinkedInAccount] ADD  CONSTRAINT [DEFAULT_SM_LinkedInAccount_LinkedInAccountLinkedInApplicationID]  DEFAULT ((0)) FOR [LinkedInAccountLinkedInApplicationID]
GO
