SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_LinkedInApplication](
	[LinkedInApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[LinkedInApplicationDisplayName] [nvarchar](200) NOT NULL,
	[LinkedInApplicationName] [nvarchar](200) NOT NULL,
	[LinkedInApplicationConsumerSecret] [nvarchar](500) NOT NULL,
	[LinkedInApplicationConsumerKey] [nvarchar](500) NOT NULL,
	[LinkedInApplicationLastModified] [datetime2](7) NOT NULL,
	[LinkedInApplicationGUID] [uniqueidentifier] NOT NULL,
	[LinkedInApplicationSiteID] [int] NOT NULL,
 CONSTRAINT [PK_SM_LinkedInApplication] PRIMARY KEY CLUSTERED 
(
	[LinkedInApplicationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_LinkedInApplication_LinkedInApplicationSiteID] ON [dbo].[SM_LinkedInApplication]
(
	[LinkedInApplicationSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationDisplayName]  DEFAULT (N'') FOR [LinkedInApplicationDisplayName]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationName]  DEFAULT (N'') FOR [LinkedInApplicationName]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationConsumerSecret]  DEFAULT (N'') FOR [LinkedInApplicationConsumerSecret]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationConsumerKey]  DEFAULT (N'') FOR [LinkedInApplicationConsumerKey]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LinkedInApplicationGUID]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] ADD  CONSTRAINT [DEFAULT_SM_LinkedInApplication_LinkedInApplicationSiteID]  DEFAULT ((0)) FOR [LinkedInApplicationSiteID]
GO
ALTER TABLE [dbo].[SM_LinkedInApplication]  WITH CHECK ADD  CONSTRAINT [FK_SM_LinkedInApplication_CMS_Site] FOREIGN KEY([LinkedInApplicationSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_LinkedInApplication] CHECK CONSTRAINT [FK_SM_LinkedInApplication_CMS_Site]
GO
