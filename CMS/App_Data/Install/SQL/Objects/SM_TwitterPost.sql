SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_TwitterPost](
	[TwitterPostID] [int] IDENTITY(1,1) NOT NULL,
	[TwitterPostGUID] [uniqueidentifier] NOT NULL,
	[TwitterPostLastModified] [datetime2](7) NOT NULL,
	[TwitterPostSiteID] [int] NOT NULL,
	[TwitterPostTwitterAccountID] [int] NOT NULL,
	[TwitterPostText] [nvarchar](max) NOT NULL,
	[TwitterPostURLShortenerType] [int] NULL,
	[TwitterPostExternalID] [nvarchar](max) NULL,
	[TwitterPostErrorCode] [int] NULL,
	[TwitterPostPublishedDateTime] [datetime2](7) NULL,
	[TwitterPostScheduledPublishDateTime] [datetime2](7) NULL,
	[TwitterPostCampaignID] [int] NULL,
	[TwitterPostFavorites] [int] NULL,
	[TwitterPostRetweets] [int] NULL,
	[TwitterPostPostAfterDocumentPublish] [bit] NULL,
	[TwitterPostInsightsUpdateDateTime] [datetime2](7) NULL,
	[TwitterPostDocumentGUID] [uniqueidentifier] NULL,
	[TwitterPostIsCreatedByUser] [bit] NULL,
 CONSTRAINT [PK_SM_TwitterPost] PRIMARY KEY CLUSTERED 
(
	[TwitterPostID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterPost_TwitterPostCampaignID] ON [dbo].[SM_TwitterPost]
(
	[TwitterPostCampaignID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterPost_TwitterPostSiteID] ON [dbo].[SM_TwitterPost]
(
	[TwitterPostSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_TwitterPost_TwitterPostTwitterAccountID] ON [dbo].[SM_TwitterPost]
(
	[TwitterPostTwitterAccountID] ASC
)
GO
ALTER TABLE [dbo].[SM_TwitterPost] ADD  CONSTRAINT [DEFAULT_SM_TwitterPost_TwitterPostTwitterAccountID]  DEFAULT ((0)) FOR [TwitterPostTwitterAccountID]
GO
ALTER TABLE [dbo].[SM_TwitterPost] ADD  CONSTRAINT [DEFAULT_SM_TwitterPost_TwitterPostText]  DEFAULT ('') FOR [TwitterPostText]
GO
ALTER TABLE [dbo].[SM_TwitterPost] ADD  CONSTRAINT [DEFAULT_SM_TwitterPost_TwitterPostIsCreatedByUser]  DEFAULT ((1)) FOR [TwitterPostIsCreatedByUser]
GO
ALTER TABLE [dbo].[SM_TwitterPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterPost_Analytics_Campaign_TwitterPostCampaignID] FOREIGN KEY([TwitterPostCampaignID])
REFERENCES [dbo].[Analytics_Campaign] ([CampaignID])
GO
ALTER TABLE [dbo].[SM_TwitterPost] CHECK CONSTRAINT [FK_SM_TwitterPost_Analytics_Campaign_TwitterPostCampaignID]
GO
ALTER TABLE [dbo].[SM_TwitterPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterPost_CMS_Site] FOREIGN KEY([TwitterPostSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_TwitterPost] CHECK CONSTRAINT [FK_SM_TwitterPost_CMS_Site]
GO
ALTER TABLE [dbo].[SM_TwitterPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_TwitterPost_SM_TwitterAccount] FOREIGN KEY([TwitterPostTwitterAccountID])
REFERENCES [dbo].[SM_TwitterAccount] ([TwitterAccountID])
GO
ALTER TABLE [dbo].[SM_TwitterPost] CHECK CONSTRAINT [FK_SM_TwitterPost_SM_TwitterAccount]
GO
