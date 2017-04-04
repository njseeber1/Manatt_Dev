SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_FacebookApplication](
	[FacebookApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[FacebookApplicationConsumerKey] [nvarchar](500) NOT NULL,
	[FacebookApplicationConsumerSecret] [nvarchar](500) NOT NULL,
	[FacebookApplicationName] [nvarchar](200) NOT NULL,
	[FacebookApplicationDisplayName] [nvarchar](200) NOT NULL,
	[FacebookApplicationGUID] [uniqueidentifier] NOT NULL,
	[FacebookApplicationLastModified] [datetime2](7) NOT NULL,
	[FacebookApplicationSiteID] [int] NOT NULL,
 CONSTRAINT [PK_SM_FacebookApplication] PRIMARY KEY CLUSTERED 
(
	[FacebookApplicationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookApplication_FacebookApplicationSiteID] ON [dbo].[SM_FacebookApplication]
(
	[FacebookApplicationSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_FacebookApplication] ADD  CONSTRAINT [DEFAULT_SM_FacebookApplication_FacebookApplicationConsumerKey]  DEFAULT ('') FOR [FacebookApplicationConsumerKey]
GO
ALTER TABLE [dbo].[SM_FacebookApplication] ADD  CONSTRAINT [DEFAULT_SM_FacebookApplication_FacebookApplicationConsumerSecret]  DEFAULT ('') FOR [FacebookApplicationConsumerSecret]
GO
ALTER TABLE [dbo].[SM_FacebookApplication] ADD  CONSTRAINT [DEFAULT_SM_FacebookApplication_FacebookApplicationGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [FacebookApplicationGUID]
GO
ALTER TABLE [dbo].[SM_FacebookApplication] ADD  CONSTRAINT [DEFAULT_SM_FacebookApplication_FacebookApplicationLastModified]  DEFAULT ('5/28/2013 1:02:36 PM') FOR [FacebookApplicationLastModified]
GO
ALTER TABLE [dbo].[SM_FacebookApplication]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookApplication_CMS_Site] FOREIGN KEY([FacebookApplicationSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_FacebookApplication] CHECK CONSTRAINT [FK_SM_FacebookApplication_CMS_Site]
GO
