SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_TwitterApplication](
	[TwitterApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[TwitterApplicationDisplayName] [nvarchar](200) NOT NULL,
	[TwitterApplicationName] [nvarchar](200) NOT NULL,
	[TwitterApplicationLastModified] [datetime2](7) NOT NULL,
	[TwitterApplicationGUID] [uniqueidentifier] NOT NULL,
	[TwitterApplicationSiteID] [int] NOT NULL,
	[TwitterApplicationConsumerKey] [nvarchar](500) NOT NULL,
	[TwitterApplicationConsumerSecret] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_SM_TwitterApplication] PRIMARY KEY CLUSTERED 
(
	[TwitterApplicationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterApplication_TwitterApplicationSiteID] ON [dbo].[SM_TwitterApplication]
(
	[TwitterApplicationSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_TwitterApplication] ADD  CONSTRAINT [DEFAULT_SM_TwitterApplication_TwitterApplicationConsumerKey]  DEFAULT ('') FOR [TwitterApplicationConsumerKey]
GO
ALTER TABLE [dbo].[SM_TwitterApplication] ADD  CONSTRAINT [DEFAULT_SM_TwitterApplication_TwitterApplicationConsumerSecret]  DEFAULT ('') FOR [TwitterApplicationConsumerSecret]
GO
ALTER TABLE [dbo].[SM_TwitterApplication]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterApplication_CMS_Site] FOREIGN KEY([TwitterApplicationSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_TwitterApplication] CHECK CONSTRAINT [FK_SM_TwitterApplication_CMS_Site]
GO
