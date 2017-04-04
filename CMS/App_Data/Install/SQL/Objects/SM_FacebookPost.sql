SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_FacebookPost](
	[FacebookPostID] [int] IDENTITY(1,1) NOT NULL,
	[FacebookPostGUID] [uniqueidentifier] NOT NULL,
	[FacebookPostLastModified] [datetime2](7) NOT NULL,
	[FacebookPostSiteID] [int] NOT NULL,
	[FacebookPostFacebookAccountID] [int] NOT NULL,
	[FacebookPostText] [nvarchar](max) NOT NULL,
	[FacebookPostURLShortenerType] [int] NULL,
	[FacebookPostErrorCode] [int] NULL,
	[FacebookPostErrorSubcode] [int] NULL,
	[FacebookPostExternalID] [nvarchar](max) NULL,
	[FacebookPostPublishedDateTime] [datetime2](7) NULL,
	[FacebookPostScheduledPublishDateTime] [datetime2](7) NULL,
	[FacebookPostCampaignID] [int] NULL,
	[FacebookPostPostAfterDocumentPublish] [bit] NULL,
	[FacebookPostInsightPeopleReached] [int] NULL,
	[FacebookPostInsightLikesFromPage] [int] NULL,
	[FacebookPostInsightCommentsFromPage] [int] NULL,
	[FacebookPostInsightSharesFromPage] [int] NULL,
	[FacebookPostInsightLikesTotal] [int] NULL,
	[FacebookPostInsightCommentsTotal] [int] NULL,
	[FacebookPostInsightNegativeHidePost] [int] NULL,
	[FacebookPostInsightNegativeHideAllPosts] [int] NULL,
	[FacebookPostInsightNegativeReportSpam] [int] NULL,
	[FacebookPostInsightNegativeUnlikePage] [int] NULL,
	[FacebookPostInsightsLastUpdated] [datetime2](7) NULL,
	[FacebookPostDocumentGUID] [uniqueidentifier] NULL,
	[FacebookPostIsCreatedByUser] [bit] NULL,
 CONSTRAINT [PK_SM_FacebookPost] PRIMARY KEY CLUSTERED 
(
	[FacebookPostID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookPost_FacebookPostCampaignID] ON [dbo].[SM_FacebookPost]
(
	[FacebookPostCampaignID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookPost_FacebookPostFacebookAccountID] ON [dbo].[SM_FacebookPost]
(
	[FacebookPostFacebookAccountID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_FacebookPost_FacebookPostSiteID] ON [dbo].[SM_FacebookPost]
(
	[FacebookPostSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_FacebookPost] ADD  CONSTRAINT [DEFAULT_SM_FacebookPost_FacebookPostFacebookAccountID]  DEFAULT ((0)) FOR [FacebookPostFacebookAccountID]
GO
ALTER TABLE [dbo].[SM_FacebookPost] ADD  CONSTRAINT [DEFAULT_SM_FacebookPost_FacebookPostIsCreatedByUser]  DEFAULT ((1)) FOR [FacebookPostIsCreatedByUser]
GO
ALTER TABLE [dbo].[SM_FacebookPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookPost_Analytics_Campaign_FacebookPostCampaignID] FOREIGN KEY([FacebookPostCampaignID])
REFERENCES [dbo].[Analytics_Campaign] ([CampaignID])
GO
ALTER TABLE [dbo].[SM_FacebookPost] CHECK CONSTRAINT [FK_SM_FacebookPost_Analytics_Campaign_FacebookPostCampaignID]
GO
ALTER TABLE [dbo].[SM_FacebookPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookPost_CMS_Site] FOREIGN KEY([FacebookPostSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_FacebookPost] CHECK CONSTRAINT [FK_SM_FacebookPost_CMS_Site]
GO
ALTER TABLE [dbo].[SM_FacebookPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_FacebookPost_SM_FacebookAccount] FOREIGN KEY([FacebookPostFacebookAccountID])
REFERENCES [dbo].[SM_FacebookAccount] ([FacebookAccountID])
GO
ALTER TABLE [dbo].[SM_FacebookPost] CHECK CONSTRAINT [FK_SM_FacebookPost_SM_FacebookAccount]
GO
